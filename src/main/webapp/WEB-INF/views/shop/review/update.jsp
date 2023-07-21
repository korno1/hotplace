<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // sreVO.rated 값을 읽어와서 해당되는 별점을 먼저 부여
    var ratedValue = ${sreVO.rated};
    $('.star-rating .star').removeClass('selected');
    $('.star-rating .star[data-value="' + ratedValue + '"]').addClass('selected');
    $('.star-rating .star[data-value="' + ratedValue + '"]').prevAll('.star').addClass('selected');

    // 별점 클릭 이벤트 설정
    $('.star-rating .star').on('click', function() {
        var selectedValue = parseInt($(this).attr('data-value'));
        $('#rated').val(selectedValue); // 선택된 별점 값을 hidden input에 저장

        // 선택된 별 이후의 별 아이콘들을 노란색으로 변경
        $('.star-rating .star').removeClass('selected');
        $('.star-rating .star[data-value="' + selectedValue + '"]').addClass('selected');
        $('.star-rating .star[data-value="' + selectedValue + '"]').prevAll('.star').addClass('selected');

        // 선택 이전의 별 아이콘들을 회색으로 변경
        $('.star-rating .star[data-value="' + selectedValue + '"]').nextAll('.star').removeClass('selected');
    });
});

function updateReview() {
	var nickName = "${param.nickName}"; // 사용자의 닉네임 정보
    var shopNum = ${shoVO.num}; // 가게 번호 정보
    var num = ${sreVO.num}; // 가게 리뷰 고유번호
    var content = document.getElementById("content").value; // 리뷰 내용 정보
    var rated = document.getElementById("rated").value; // 평점 정보
    var fileInput = $('input[type=file]')[0]; // 파일 인풋 엘리먼트

    var formData = new FormData();
    formData.append("writerName", nickName);
    formData.append("num", num);
    formData.append("shopNum", shopNum);
    formData.append("content", content);
    formData.append("rated", rated);
    
    var anonymous = document.getElementById("privateNickname").checked ? 1 : 0;
    formData.append("anonymous", anonymous);
    
    if (fileInput.files.length > 0) {
        formData.append("multipartFile", fileInput.files[0]);
    }
    
    // Ajax를 통한 비동기식 데이터 전송
    $.ajax({
        url: "/hotplace/shop/review/json/updateOK.do",
        type: "POST",
        data: formData,
        processData: false, // 데이터 처리 방식 설정
        contentType: false, // 컨텐트 타입 설정
        success: function(response) {
            // 처리 결과에 따른 작업 수행
            console.log("리뷰 수정 성공");
            
         	// 팝업 창 표시
            alert("리뷰가 수정되었습니다!");
         	
         	window.parent.location.reload();
         	
         	window.close();
        },
        error: function(xhr, status, error) {
            // 에러 발생 시 작업 수행
            console.error("리뷰 수정 실패");
            // 에러 처리 작업 수행
        }
    }); 
}

function showImagePreview(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#imagePreview').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}
</script>
<link rel="stylesheet" href="../../resources/css/shop/insertReview.css">
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <div class="title">후기 수정</div>
    <div class="upper-form">
    	<div class="left-form">
	    	<div class="img-insert">
        	    <img id="imagePreview" src="../../resources/ShopReviewImage/${sreVO.num}.png" onerror="src='../../resources/ShopReviewImage/default.png'" alt="Image Preview" style="width:220px;height:220px;object-fit:cover;object-position:center;">
                <input type="file" name="multipartFile" accept="image/*" onchange="showImagePreview(this)" style="display: none;">
                <button type="button" onclick="document.querySelector('input[name=multipartFile]').click()">파일 선택</button>
	    	</div>
    	</div>
	    <div class="right-form">
	    	<div class="inform-title">${shoVO.name}</div>
	    	<div class="inform-data">${shoVO.cate}</div>
    		<div class="inform-data">${shoVO.tel}</div>
	    	<div class="rate">
		   		<div class="rate-label">평점</div>
	            <div class="star-rating" data-rated="${sreVO.rated}">
        			<span class="star" data-value="1">&#9733;</span>
        			<span class="star" data-value="2">&#9733;</span>
        			<span class="star" data-value="3">&#9733;</span>
        			<span class="star" data-value="4">&#9733;</span>
        			<span class="star" data-value="5">&#9733;</span>
    			</div>
	        	<input type="checkbox" class="privateNick" id="privateNickname" name="privateNickname" value="true">
            	<div class="privateLabel">닉네임 비공개</div>
            </div>
	    </div>
    </div>
    <textarea id="content" name="content" class="content">${sreVO.content}</textarea>
    <input type="hidden" id="rated" name="rated" value="${sreVO.rated}">
    <button class="submit-button" onclick="updateReview()">수정 완료</button>
</body>
</html>
