<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		console.log("onload....");
	});

	function NickNameCheck() {
		console.log("NickNameCheck....", $('#NICK_NAME').val());

		$.ajax({
			url : "json/nickNameCheck.do",
			data : {
				id : $('#NICK_NAME').val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '사용가능한 닉네임입니다.';
				} else {
					msg = '사용중인 닉네임입니다.';
				}
				$('#demo').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end idCheck()...
	function emailCheck() {
		console.log("emailCheck....", $('#EMAIL').val());

		$.ajax({
			url : "json/emailCheck.do.do",
			data : {
				id : $('#EMAIL').val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '사용가능한 이메일입니다.';
				} else {
					msg = '사용중인 이메일입니다.';
				}
				$('#demo').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end idCheck()...
</script>
</head>
<body>
	<h1>회원가입</h1>

	<form method="post" enctype="multipart/form-data" onsubmit="insertOK()">
		<table>
			<tr>
				<td><label for="NICK_NAME">닉네임:</label></td>
				<td><input type="text" id="NICK_NAME" name="NICK_NAME"
					value="닉네임1">
					<button type="button" onclick="NickNameCheck()" class="myButton">닉네임
						중복체크</button> <span id="demo"></span></td>
			</tr>
			<tr>
				<td><label for="EMAIL">이메일:</label></td>
				<td><input type="email" id="email" name="email"
					value="abc@hotplace.com">
					<button type="button" onclick="emailCheck()" class="myButton">이메일
						중복체크</button> <span id="demo"></span></td>
			</tr>
			<tr>
				<td><label for="pw">비밀번호:</label></td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
			<tr>
				<td><label for="pw">비밀번호 확인:</label></td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
			<tr>
				<td><label for="address">주소:</label></td>
				<td><input type="text" id="address" name="address"
					value="강남대로 1번길"></td>
			</tr>
			<tr>
				<td><label for="gender">성별:</label></td>
				<td><input type="radio" name="gender" value="1">
					남자 <input type="radio" name="gender" value="2">
					여자 <input type="radio" name="gender" value="3">
					비공개 </td>
			</tr>
						<tr>
				<td><label for="foodlike">음식 선호:</label></td>
				<td><input type="checkbox" name="foodlike" value="한식"> 한식
					<input type="checkbox" name="foodlike" value="중식"> 중식
					<input type="checkbox" name="foodlike" value="일식"> 일식
					<input type="checkbox" name="foodlike" value="양식"> 양식
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" class="myButton"></td>
			</tr>
		</table>
	</form>
</body>
</html>