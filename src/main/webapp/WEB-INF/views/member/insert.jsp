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
	let nickNameCheck = 0;
	let emailCheck = 0;

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
					nickNameCheck = 1;
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
	function EmailCheck() {
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
					emailCheck = 1;
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
		console.log('nickNameCheck', nickNameCheck)
		console.log('emailCheck', emailCheck)

		let selectedGender = $('input[name="gender"]:checked').val();

		// 선택된 음식 선호 값을 가져옴
		let foodLikes = []; // 배열에 넣기
		$('input[name="foodlike"]:checked').each(function() {
			foodLikes.push($(this).val());
		});
		console.log('foodLikes', foodLikes);

		// 필수 입력 필드 검증
		let nickName = $('#nick_name').val();
		let email = $('#email').val();
		let pw = $('#pw').val();
		let pwCheck = $('#pwCheck').val();
		let address = $('#address').val();
		let gender = '';
		gender = $('input[name="gender"]:checked').val();
		let food_like = '';
		food_like = $('input[name="foodlike"]:checked').val();
		if (nickName === '') {
			alert('닉네임을 입력해주세요.');
		} else if (email === '') {
			alert('이메일을 입력해주세요.');
		} else if (pw === '') {
			alert('비밀번호를 입력해주세요.');
		} else if (pw !== pwCheck) {
			alert('입력된 비밀번호가 일치하지 않습니다.');
		} else if (gender === '') {
			alert('성별을 선택해주세요.');
		} else if (food_like === '') {
			alert('음식 취향을 선택해주세요.');
		} else if (address === '') {
			alert('주소를 입력해주세요.');
			return; // 요청 중단
		}
		console.log('필수 입력 필드 검증 done...')

		// 		닉네임,이메일 중복확인 통과 예외 처리
		if (nickNameCheck !== 1) {
			console.log('nickNameCheck', nickNameCheck);
			alert('닉네임 중복을 확인해주시기 바랍니다.');
			return; // 요청 중단
		} else if (emailCheck !== 1) {
			console.log('emailCheck', emailCheck);
			alert('이메일 중복을 확인해주시기 바랍니다.');
			return; // 요청 중단
		}
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
		return checkPassword();
	}//end insertOK()...

	$(document).ready(function() {
		$('#nick_name').click(function() {
			nickNameCheck = 0;
			$('#nickNameCheck').text('');
		});
		$('#email').click(function() {
			emailCheck = 0;
			$('#emailCheck').text('');
		});
	});

	function checkPassword() {
		let password = document.getElementById("pw").value;
		let confirmPassword = document.getElementById("pwCheck");

		if (password !== confirmPassword.value) {
			confirmPassword.classList.add("error");
			return false;
		} else {
			confirmPassword.classList.remove("error");
			return true;
		}
	}
</script>
</head>
<body>
	<h1>회원가입</h1>

	<form onsubmit="insertOK()">
		<!-- 	<form id="myForm"> -->
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
					<button type="button" onclick="EmailCheck()" class="myButton">이메일
						중복체크</button> <span id="emailCheck"></span></td>
			</tr>
			<tr>
				<td><label for="pw">비밀번호:</label></td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
			<tr>
				<td><label for="pwCheck">비밀번호 확인:</label></td>
				<td><input type="password" id="pwCheck" name="pwCheck"
					oninput="checkPassword()"></td>
			</tr>
			<tr>
				<td><label for="address">주소:</label></td>
				<td><input type="text" id="address" name="address"
					value="강남대로 1번길"></td>
			</tr>
			<tr>
				<td><label for="gender">성별:</label></td>
				<td><input type="radio" name="gender" value="1"> 남자 <input
					type="radio" name="gender" value="2"> 여자 <input
					type="radio" name="gender" value="3"> 비공개</td>
			</tr>
			<tr>
				<td><label for="foodlike">음식 선호:</label></td>
				<td><input type="checkbox" name="foodlike" value="한식">
					한식 <input type="checkbox" name="foodlike" value="중식"> 중식 <input
					type="checkbox" name="foodlike" value="일식"> 일식 <input
					type="checkbox" name="foodlike" value="양식"> 양식</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" class="myButton"></td>
			</tr>
		</table>
	</form>
</body>
</html>