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
		console.log("NickNameCheck....", $('#nick_name').val());

		$.ajax({
			url : "json/nickNameCheck.do",
			data : {
				nick_name : $('#nick_name').val()
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
				$('#nickNameCheck').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end NickNameCheck()...
	function emailCheck() {
		console.log("emailCheck....", $('#email').val());

		$.ajax({
			url : "json/emailCheck.do",
			data : {
				email : $('#email').val()
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
				$('#emailCheck').text(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...

	}//end emailCheck()...
	function insertOK() {
		console.log("insertOK....");
		
		let selectedGender = document.querySelector('input[name="gender"]:checked').value;

	    // 선택된 음식 선호 값을 가져옴
	    let foodLikes = []; // 배열에 넣기
	    let foodLikeCheckboxes = document.querySelectorAll('input[name="foodlike"]:checked');
	    for (let i = 0; i < foodLikeCheckboxes.length; i++) {
	      foodLikes.push(foodLikeCheckboxes[i].value);
	    };
		console.log('foodLikes',foodLikes);
		$.ajax({
			url : "json/insertOK.do",
			data : {
				nick_name : $('#nick_name').val(),
				email : $('#email').val(),
				pw : $('#pw').val(),
				address : $('#address').val(),
				gender: selectedGender,
			    food_like: foodLikes.join(',')
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '회원가입에 성공했습니다.';
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
	<h1>회원가입</h1>

	<form onsubmit="insertOK()">
		<table>
			<tr>
				<td><label for="nick_name">닉네임:</label></td>
				<td><input type="text" id="nick_name" name="nick_name"
					value="닉네임1">
					<button type="button" onclick="NickNameCheck()" class="myButton">닉네임
						중복체크</button> <span id="nickNameCheck"></span></td>
			</tr>
			<tr>
				<td><label for="email">이메일:</label></td>
				<td><input type="email" id="email" name="email"
					value="abc@hotplace.com">
					<button type="button" onclick="emailCheck()" class="myButton">이메일
						중복체크</button> <span id="emailCheck"></span></td>
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