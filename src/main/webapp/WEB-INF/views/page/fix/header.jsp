<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${root}/resources/css/fixCss/header.css">
    <title>POPSTIVER</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script> const root = "${root}"; </script>
    <script src="${root}/resources/js/loginName.js"></script>
    <script>
        $(document).ready(function() {
            $(".mainTopLogo").hover(
                function() {
                    $(".logoButtons").stop().slideDown(300);
                },
                function() {
                    $(".logoButtons").stop().slideUp(300);
                }
            );
        });

        function redirectRandom() {
            const urls = ['mainPopup', 'mainFestival'];
            const randomIndex = Math.floor(Math.random() * urls.length);
            window.location.href = root + '/' + urls[randomIndex];
        }
    </script>

</head>
<body>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">
<header class="mainTop">
    <div class="mainTopLogo">
        <h1><a href="#" onclick="redirectRandom()">POPSTIVER</a></h1>
        <div class="logoButtons">
            <button class="logoButton" onclick="window.location.href='mainPopup'">POP-UP</button>
            <button class="logoButton" onclick="window.location.href='mainFestival'">FESTIVAL</button>
        </div>
    </div>

    <div class="topSearchButton" id="searchButton">
        <button class="searchButton" id="searchButton">
            <img src="${root}/resources/asset/메인검색창검색버튼.svg" alt="">
        </button>
    </div>

    <div class="mainTopMenu">
        <ul>
            <li>
                <a href="${root}/myPage">마이페이지</a>
                <ul>
                    <li><a href="${root}/myPage">내 정보</a></li>
                    <li><a href="${root}/deleteUser">회원 탈퇴</a></li>
                </ul>
            </li>
            <li>
                <a href="${root}/map">근처 행사</a>
            </li>
            <li>
                <a href="${root}/bookmark">관심 행사</a>
            </li>
            <li>
                <a href="${root}/calendar">행사 일정</a>
            </li>
            <li>
                <a href="${root}/contact">게시판</a>
                <ul>
                    <li><a href="${root}/contact">공지사항</a></li>
                    <li><a href="${root}/money">비즈니스 문의</a></li>
                    <li><a href="${root}/report">제보하기</a></li>
                    <li><a href="${root}/together">동행구하기</a></li>
                    <li><a href="${root}/free">자유게시판</a></li>
                </ul>
            </li>
            <li>
                <a href="${root}/recommended">추천행사</a>
            </li>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li>
                <a href="${root}/admin">관리자</a>
            </li>
        </sec:authorize>
        </ul>
    </div>

    <div class="weather">
<%--        <script>--%>
<%--            (function(d, s, id) {--%>
<%--                if (d.getElementById(id)) {--%>
<%--                    if (window.__TOMORROW__) {--%>
<%--                        window.__TOMORROW__.renderWidget();--%>
<%--                    }--%>
<%--                    return;--%>
<%--                }--%>
<%--                const fjs = d.getElementsByTagName(s)[0];--%>
<%--                const js = d.createElement(s);--%>
<%--                js.id = id;--%>
<%--                js.src = "https://www.tomorrow.io/v1/widget/sdk/sdk.bundle.min.js";--%>

<%--                fjs.parentNode.insertBefore(js, fjs);--%>
<%--            })(document, 'script', 'tomorrow-sdk');--%>
<%--        </script>--%>

<%--        <div class="tomorrow"--%>
<%--             data-location-id=""--%>
<%--             data-language="KO"--%>
<%--             data-unit-system="METRIC"--%>
<%--             data-skin="dark"--%>
<%--             data-widget-type="aqiMini"--%>
<%--             style="padding-bottom:22px;position:relative;"--%>
<%--        >--%>
<%--            <a--%>
<%--                    href="https://www.tomorrow.io/weather-api/"--%>
<%--                    rel="nofollow noopener noreferrer"--%>
<%--                    target="_blank"--%>
<%--                    style="position: absolute; bottom: 0; transform: translateX(-50%); left: 50%;"--%>
<%--            >--%>
<%--                <img--%>
<%--                        alt="Powered by the Tomorrow.io Weather API"--%>
<%--                        src="https://weather-website-client.tomorrow.io/img/powered-by.svg"--%>
<%--                        width="250"--%>
<%--                        height="18"--%>
<%--                />--%>
<%--            </a>--%>
<%--        </div>--%>
<%--    <iframe src="https://www.meteoblue.com/en/weather/widget/three?geoloc=detect&nocurrent=0&noforecast=0&noforecast=1&days=4&tempunit=CELSIUS&windunit=KILOMETER_PER_HOUR&layout=image"  frameborder="0" scrolling="NO" allowtransparency="true" sandbox="allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox" style="width: 300px; height: 80px"></iframe><div><!-- DO NOT REMOVE THIS LINK --><a href="https://www.meteoblue.com/en/weather/week/index?utm_source=three_widget&utm_medium=linkus&utm_content=three&utm_campaign=Weather%2BWidget" target="_blank" rel="noopener">meteoblue</a></div>--%>
    <jsp:include page="/WEB-INF/views/page/fix/weatherWidget.jsp" />
    </div>


    <div class="mainTopButton">
        <sec:authorize access="!isAuthenticated()">
            <button class="loginButton" onclick="window.location.href='login'">
                로그인
            </button>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <button class="logoutButton" onclick="window.location.href='logout'">
                로그아웃
            </button>
        </sec:authorize>
    </div>
</header>

<div id="searchModal" class="search-modal">
    <div class="mainTopSearch">
        <form class="mainTopSearchContainer" action="${root}/main/search" method="GET">
            <label>
                <input type="text" name="keyword" placeholder="팝업스토어, 페스티벌 검색">
            </label>
            <button type="submit" class="searchButton">
                <img src="${root}/resources/asset/메인검색창검색버튼.svg" alt="">
            </button>
        </form>
    </div>
</div>

<div id="loader"></div>
<script>
    $(window).on('load', function() {
        $('#loader').fadeOut(500); // 페이지 로딩 완료 시 스피너 숨김
    });

    // 검색 버튼 클릭 시 검색 모달 열기
    $("#searchButton").on("click", function() {
        $("#searchModal").slideToggle();
    });
</script>
</body>
</html>
