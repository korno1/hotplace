<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<style>
.error {
	border: 1px solid #FF9999;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		console.log("onload....");
	});

	function insertOK() {
		console.log("insertOK....");
		$.ajax({
			url : "json/insertOK.do",
			data : {
				nick_name : $('#nick_name').val(),
				email : $('#email').val(),
				pw : $('#pw').val(),
				address : $('#address').val(),
				gender : selectedGender,
				food_like : foodLikes.join(',')
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '회원가입에 성공했습니다.';
					// 					location.reload();
				} else {
					msg = '회원가입에 실패했습니다.';
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
	<div></div>
</body>
</html>