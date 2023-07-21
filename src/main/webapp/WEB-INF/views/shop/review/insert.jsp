<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>

function insertReview() {
	var nickName = "${param.nickName}"; // 사용자의 닉네임 정보
    var shopNum = ${shopVO.num}; // 가게 번호 정보
    var content = document.getElementById("content").value; // 리뷰 내용 정보
    var rated = document.getElementById("rated").value; // 평점 정보
    var fileInput = $('input[type=file]')[0]; // 파일 인풋 엘리먼트

    if (rated === "") {
    	alert("평점을 선택해주세요");
    	return;
    }
    
    if (content.trim() === "") {
    	alert("내용을 입력해주세요");
    	return;
    }
    
    var formData = new FormData();
    formData.append("writerName", nickName);
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
        url: "/hotplace/shop/review/json/insertOK.do",
        type: "POST",
        data: formData,
        processData: false, // 데이터 처리 방식 설정
        contentType: false, // 컨텐트 타입 설정
        success: function(response) {
            // 처리 결과에 따른 작업 수행
            console.log("리뷰 작성 성공");
            
         	// 팝업 창 표시
            alert("리뷰가 등록되었습니다!");
         	
         	window.parent.location.reload();
         	
         	window.close();
        },
        error: function(xhr, status, error) {
            // 에러 발생 시 작업 수행
            console.error("리뷰 작성 실패");
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
    <div class="title">후기 작성</div>
    <div class="upper-form">
    	<div class="left-form">
	    	<div class="img-insert">
        	    <img id="imagePreview" src="../../resources/ShopReviewImage/default.png" alt="Image Preview" style="width:220px;height:220px;object-fit:cover;object-position:center;">
				<input type="file" name="multipartFile" accept="image/*" onchange="showImagePreview(this)">
	    	</div>
    	</div>
	    <div class="right-form">
	    	<div class="inform-title" id="shopName">${shopVO.name}</div>
	    	<div class="inform-data">${shopVO.cate}</div>
    		<div class="inform-data">${shopVO.tel}</div>
	    	<div class="rate">
		   		<div class="rate-label">평점</div>
	            <div class="star-rating" data-rated="${vo.rated}">
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
    <textarea id="content" name="content" class="content"></textarea>
    <input type="hidden" id="rated" name="rated" value="${sreVO.rated}">
    <button class="submit-button" onclick="insertReview()">작성 완료</button>
</body>
<script>

$(document).ready(function() {
    var shopNameDiv = $("#shopName");
    var shopName = shopNameDiv.text();

    // 긴 글자일 경우, 글자 크기를 조정하여 표시
    if (shopName.length > 10) {
        shopNameDiv.css("font-size", "30px");
    }
});

$('.star-rating .star').on('click', function() {
	console.log("star clicked");
    var selectedValue = parseInt($(this).attr('data-value'));
    $('#rated').val(selectedValue); // 선택된 별점 값을 hidden input에 저장

    // 선택된 별 이후의 별 아이콘들을 노란색으로 변경
    $('.star-rating .star').removeClass('selected');
    $('.star-rating .star[data-value="' + selectedValue + '"]').addClass('selected');
    $('.star-rating .star[data-value="' + selectedValue + '"]').prevAll('.star').addClass('selected');

    // 선택 이전의 별 아이콘들을 회색으로 변경
    $('.star-rating .star[data-value="' + selectedValue + '"]').nextAll('.star').removeClass('selected');
});
</script>
</html>
