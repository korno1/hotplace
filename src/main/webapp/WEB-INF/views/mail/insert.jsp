<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<link rel="stylesheet" href="../resources/css/mail/insert.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
// 현재 URL에서 쿼리 문자열 가져오기
let queryString = window.location.search;

// URLSearchParams를 사용하여 쿼리 문자열 파싱
let searchParams = new URLSearchParams(queryString);

// num 번호 추출
let paramNum = searchParams.get('num');

// Test용 로그인 계정 num
let user_num = 3;

$(function() {
	console.log("onload....");
	
	function selectOne() {
		console.log("selectOne....");
		console.log("paramNum....",paramNum);
		
		$.ajax({
			url : "../member/json/selectOne.do",
			data : {
				num:paramNum
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				$("#recipientName").val(obj.nick_name);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
	}//end selectOne()...

	selectOne(); // selectOne() 함수 호출
});


	function insertOK() {
		console.log("insertOK....");
		$.ajax({
			url : "json/insertOK.do",
			data : {
				title : $('#title').val(),
				recipient_num : paramNum,
				content : $('#Content').val(),
				sender_num : user_num
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '쪽지가 성공적으로 전송되었습니다.';
					// 					location.reload();
				} else {
					msg = '쪽지가 전송에 실패했습니다.';
				}
				alert(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
	}//end insertOK()...
</script>
</head>
<body>
	<h1>쪽지 보내기</h1>
	<div class="mailInsertWrap block">
		<div class="mailInsertTitle Title">
		<input type="text" id="title" name="title" placeholder="쪽지 제목">
		</div>
		<div class="mailInsertRecipientName RecipientName">
		<input type="text" id="recipientName" name="recipientName" readonly>
		</div>
		<div class="mailInsertContent Content">
		<input type="text" id="Content" name="Content" placeholder="내용">
		</div>
		<div class="mailInsert__bottomWrap">
			<div class="mailInsertBtn InsertBtn" onclick="insertOK()">전송</div>
		</div>
	</div>
</body>
</html>