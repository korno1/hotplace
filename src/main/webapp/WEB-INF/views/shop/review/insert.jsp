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

    var formData = new FormData();
    formData.append("writerName", nickName);
    formData.append("shopNum", shopNum);
    formData.append("content", content);
    formData.append("rated", rated);
    
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
	    	<div class="inform-title">${shopVO.name}</div>
	    	<div class="inform-data">${shopVO.cate}</div>
    		<div class="inform-data">${shopVO.tel}</div>
	    	<div class="rate">
		   		<div class="rate-label">평점</div>
	            <select id="rated" name="rated" class="rate-dropdown">
                	<option value="1" ${vo.rated == 1 ? 'selected' : ''}>1</option>
	        	    <option value="2" ${vo.rated == 2 ? 'selected' : ''}>2</option>
    		        <option value="3" ${vo.rated == 3 ? 'selected' : ''}>3</option>
    	    	    <option value="4" ${vo.rated == 4 ? 'selected' : ''}>4</option>
	            	<option value="5" ${vo.rated == 5 ? 'selected' : ''}>5</option>
	        	</select>
	        	<input type="checkbox" class="privateNick" id="privateNickname" name="privateNickname" value="true">
            	<div class="privateLabel">닉네임 비공개</div>
            </div>
	    </div>
    </div>
    <textarea id="content" name="content" class="content"></textarea>
    <button class="submit-button" onclick="insertReview()">작성 완료</button>
</body>
</html>
