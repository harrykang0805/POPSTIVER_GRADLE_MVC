<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${root}/resources/css/searchResultCss/posterInfo.css">
    <title>POPSTIVER</title>
    <style>
        @font-face {
            font-family: Giants;
            src: url('${root}/resources/font/Giants-Inline.ttf');
        }

        @font-face {
            font-family: KBO;
            src: url('${root}/resources/font/KBO.ttf');
        }

        @font-face {
            font-family: Pre;
            src: url('${root}/resources/font/Pre.ttf');
        }
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9441e4fcdaf29ae0ef64a498fa8c752d&libraries=services"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${root}/resources/js/festival_Details.js"></script>
    <script>
        // 이미지가 로드된 후 실행할 함수 정의
        function adjustImageSize() {
            var img = document.querySelector('.mainPoster img'); // 이미지 요소 선택

            if (img.complete) { // 이미지가 로드되었는지 확인
                var maxWidth = window.innerWidth; // 현재 창의 너비
                var maxHeight = window.innerHeight; // 현재 창의 높이

                var ratio = Math.min(maxWidth / img.naturalWidth, maxHeight / img.naturalHeight); // 이미지 비율 계산

                img.style.width = (img.naturalWidth * ratio) + 'px'; // 이미지 너비 설정
                img.style.height = (img.naturalHeight * ratio) + 'px'; // 이미지 높이 설정
            }
        }

        // 페이지 로드 시 실행할 함수 등록
        window.onload = function() {
            adjustImageSize(); // 이미지 크기 조정 함수 호출
        }

        // 창 크기 변경 시에도 이미지 크기 조정
        window.onresize = function() {
            adjustImageSize(); // 이미지 크기 조정 함수 호출
        }

    </script>
</head>
<body>

<jsp:include page="/WEB-INF/views/page/fix/header.jsp"/>

<div class="mainPoster">
    <img src="${festival.festival_attachment}" alt="">
</div>

<div class="detailInfo">
    <div class="detailInfoTitle">
        <ul>
            <c:if test="${not empty festival.festival_tag1}">
                <li><button>${festival.festival_tag1}</button></li>
            </c:if>
            <c:if test="${not empty festival.festival_tag2}">
                <li><button>${festival.festival_tag2}</button></li>
            </c:if>
            <c:if test="${not empty festival.festival_tag3}">
                <li><button>${festival.festival_tag3}</button></li>
            </c:if>
            <c:if test="${not empty festival.festival_tag4}">
                <li><button>${festival.festival_tag4}</button></li>
            </c:if>
            <c:if test="${not empty festival.festival_tag5}">
                <li><button>${festival.festival_tag5}</button></li>
            </c:if>

            <li><img src="${root}/resources/asset/조회수.svg" alt=""><p>${festival.views}</p></li>
            <li><img src="${root}/resources/asset/좋아요.svg" class="bookmark" alt=""></li>
            <li><img src="${root}/resources/asset/공유버튼.svg" alt="" onclick="toggleShareModal()">
                <!-- 공유 모달 창 -->
                <div id="shareModal" class="share-modal">
                    <div class="share-modal-content">
                        <div class="brand-item">
                            <p>브랜드 홈페이지</p>
                            <div class="link-container">
                                <div class="link-wrapper">
                                    <a id="brandWebsiteLink" href="${festival.brand_link}" target="_blank">${festival.brand_link}</a>
                                </div>
                                <button onclick="copyToClipboard('brandWebsiteLink')">
                                    <img src="${root}/resources/asset/복사버튼.svg" alt="">
                                </button>
                            </div>
                        </div>

                        <div class="brand-item">
                            <p>브랜드 SNS</p>
                            <div class="link-container">
                                <div class="link-wrapper">
                                    <a id="brandSNSLink" href="${festival.brand_sns}" target="_blank">${festival.brand_sns}</a>
                                </div>
                                <button onclick="copyToClipboard('brandSNSLink')">
                                    <img src="${root}/resources/asset/복사버튼.svg" alt="">
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <h1 class="title">${festival.festival_title}</h1>
        <p class="detailDate">${festival.festival_start} ~ ${festival.festival_end}</p>
        <p class="detailAddress">
            <img src="${root}/resources/asset/위치표시.svg" alt="">
            ${festival.festival_location}
        </p>

        <div class="detailInfoTime">
            <p class="detailInfoTimeTitle">운영시간</p>
            <p class="detailInfoTimeInfo">
            <p>${festival.open_time}</p>
        </div>
        <p class="detailIntroduceTitle">팝업스토어, 페스티벌 소개</p>
        <div class="detailIntroduce">
            <p>${festival.festival_content}</p>
        </div>
        <p class="detailInfoMapTitle">행사 위치 (카카오 지도)</p>
        <div class="detailInfoMap">
            <div id="singleMap"></div>
        </div>
        <div class="detailInfoReview">
            <p class="detailInfoReviewTitle">후기</p>
            <!-- 후기 개수 표시 -->
            <p>댓글 ${allComments.size()}개</p>
            <form method="post" onsubmit="submitForm(event)">

                <input type="hidden" name="festival_no" value="${festival.festival_no}">
                <input type="hidden" name="event_type" value="${festival.event_type}">
                <input type="hidden" id="user_name" name="user_name" value="">
                <input type="hidden" id="user_id" name="user_id" value="">
                <div class="commentArea">
                    <input class="commentDate" type="text" name="visit_date" placeholder="방문일을 입력해주세요.">
                    <input class="commentContent" type="text" name="comment_content" placeholder="후기를 입력해주세요.">

                <div class="stars" id="starRating">
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                </div>
                <input type="hidden" name="star_rate" id="star_rate">
                <button type="submit">등록</button>
                </div>
            </form>
            <div class="detailInfoReviewTable">
                <table>
                    <!-- 댓글을 반복하여 출력 -->
                    <c:forEach var="comment" items="${allComments}">
                        <tr>
                            <td>
                                <div class="comment-header">
                                    <div class="name">${comment.comment_writer}</div>
                                    <div class="date">${comment.visit_date}</div>
                                </div>
                            </td>
                            <td>
                                <div class="comment-text">${comment.comment_content}</div>
                            </td>
                            <td class="star_rate">
                                <c:forEach var="i" begin="1" end="5">
                                    <span class="star ${i <= comment.star_rate ? 'selected' : ''}">&#9733;</span>
                                </c:forEach>
                            </td>
                            <td>
                                <div class="delete" style="display: none;" data-comment-writer="${comment.comment_writer}">
                                    <img src="${root}/resources/asset/삭제버튼.svg" alt="" onclick="deleteComment(${comment.comment_no})">
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>


        </div>
    </div>
</div>

<div id="customAlertModal" class="custom-alert-modal">
    <div class="custom-alert-content">
        <p id="customAlertMessage"></p>
        <button class="custom-alert-close" onclick="closeCustomAlert()">확인</button>
    </div>
</div>



<jsp:include page="/WEB-INF/views/page/fix/footer.jsp" />
<script src="${root}/resources/js/bookmarkToggle.js"></script>
<script src="${root}/resources/js/shareModal.js"></script>
<script>
    var geocoder = new kakao.maps.services.Geocoder();

    // 첫 번째 지도: 특정 행사 위치
    var singleMapContainer = document.getElementById('singleMap'), // 지도를 표시할 div
        singleMapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울을 중심으로 기본값 설정
            level: 3 // 지도의 확대 레벨
        };

    var singleMap = new kakao.maps.Map(singleMapContainer, singleMapOption); // 지도를 생성합니다

    geocoder.addressSearch("${festival.festival_dist} ${festival.festival_subdist} ${festival.festival_location}", function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            const coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            singleMap.setCenter(coords);

            // 결과값으로 받은 위치에 마커를 생성합니다
            const marker = new kakao.maps.Marker({
                map: singleMap,
                position: coords
            });
        }
    });
</script>


</body>
</html>
