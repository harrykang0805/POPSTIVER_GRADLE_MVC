$(document).ready(function () {
    getUserInfoAndSetUserId();

    // 별점 클릭 이벤트 핸들러
    $('.star').on('click', function () {
        var selectedStarValue = $(this).data('value');
        $('#star_rate').val(selectedStarValue);

        // 모든 별의 색상 초기화
        $('.star').removeClass('selected');

        // 선택된 별과 그 이전 별의 색상 변경
        $(this).addClass('selected');
        $(this).prevAll('.star').addClass('selected');
    });

    // 마우스를 올렸을 때 이벤트 핸들러
    $('.star').hover(function () {
        // 모든 별의 색상 초기화
        $('.star').removeClass('hovered');

        // 마우스를 올린 별과 그 이전 별의 색상 변경
        $(this).addClass('hovered');
        $(this).prevAll('.star').addClass('hovered');
    }, function () {
        // 마우스를 뗐을 때 모든 별의 hover 클래스 제거
        $('.star').removeClass('hovered');
    });
});

function getUserInfoAndSetUserId() {
    $.ajax({
        type: "GET",
        url: "/member/getUserInfo",
        success: function (response) {
            if (response && response.user_id && response.user_nickname) {
                // Set the user_id and user_nickname in the hidden input fields
                $("#user_id").val(response.user_id);
                $("#user_name").val(response.user_nickname);
            } else {
                console.error("사용자 정보를 가져오는 데 실패했습니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("사용자 정보를 가져오는 중 오류 발생: " + error);
        }
    });
}

// 저장하기 버튼을 누르면
function submitForm(event) {
    event.preventDefault(); // 폼 제출 방지

    var festivalNo = $("input[name='festival_no']").val();
    var eventType = $("input[name='event_type']").val();
    var userId = $("input[name='user_id']").val();
    var userName = $("input[name='user_name']").val();
    var commentContent = $("input[name='comment_content']").val();
    var visitDate = $("input[name='visit_date']").val();
    var starRate = $("#star_rate").val();

    $.ajax({
        method: "put",
        url: "/comment/festivalInsert",
        contentType: 'application/json;charset=utf-8',
        data: JSON.stringify({
            "festival_no": festivalNo,
            "event_type": eventType,
            "comment_writer": userName,
            "comment_content": commentContent,
            "visit_date": visitDate,
            "star_rate": starRate
        }),
        success: function (response) {
            // 업데이트 성공 시 처리할 코드
            var message = "후기 등록이 완료되었습니다!";
            openCustomAlert(message);
            // 필요한 경우 추가적인 UI 업데이트 등을 수행할 수 있음
        },
        error: function (xhr, status, error) {
            // 실패 시 처리할 코드
            var errorMessage = "게시글 저장 중 오류가 발생했습니다.";
            openCustomAlert(errorMessage);
        }
    });
}

function openCustomAlert(message) {
    // 설정한 메시지를 모달에 표시
    $('#customAlertMessage').text(message);

    // 모달 보이기
    $('.custom-alert-modal').css('display', 'block');
}

function closeCustomAlert() {
    // 모달 닫기
    $('.custom-alert-modal').css('display', 'none');
}
