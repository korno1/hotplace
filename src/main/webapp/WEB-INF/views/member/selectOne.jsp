<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOne</title>
<style>
.error {
	border: 1px solid #FF9999;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
let nickNameCheck = 0;
let emailCheck = 0;

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
	<h1>회원정보</h1>
	<div class="memberInfoWrap block">
		<div class="memberInfo__leftTab">
			<div class="memberInfo__title title">프로필 사진</div>
			<div class="memberInfo__title title">닉네임</div>
			<div class="memberInfo__title title">이메일 주소</div>
			<div class="memberInfo__title title">사는 지역</div>
			<div class="memberInfo__title title">비밀 번호</div>
			<div class="memberInfo__title title">성별</div>
			<div class="memberInfo__title title">음식 취향</div>		
		</div>
		<div class="memberInfo__rightTab">
			<div class="memberInfo__imageTab content">
				<div>
					<img width="300px" src="resources/uploadimg/${vo2.num}">
				</div>
				<div>
					<button>찾아보기</button>
				</div>
			</div>
			<div class="memberInfo__nickName content">
				<input type="text" id="nick_name" name="nick_name" value="${vo2.nick_name}">
				<button type="button" onclick="NickNameCheck()" class="myButton">닉네임 중복체크
				</button>
				<span id="nickNameCheck"></span>
			</div>
			<div class="memberInfo__email content">
				<input type="email" id="email" name="email"	value="${vo2.email}">
				<button type="button" onclick="EmailCheck()" class="myButton">이메일 중복체크
				</button>
				<span id="emailCheck"></span>
			</div>
			<div class="memberInfo__pw content">
				<input type="password" id="pw" name="pw" value="${vo.pw}">
				<input type="password" id="pwCheck" name="pwCheck" oninput="checkPassword()" value="${vo.pw}">
				<span>
					특수문자(예: !@#$ 등) 1자 이상을 포함한 10~16 글자의 비밀번호로 설정해주세요.
				</span>
			</div>
			<div class="memberInfo__address content">
				<input type="text" id="address" name="address" value="${vo2.address}">
			</div>
			<div>
				<div>
					<input type="radio" name="gender" value="1" ${vo2.gender == '0' ? 'checked' : ''}> 남자
					<input type="radio" name="gender" value="2" ${vo2.gender == '1' ? 'checked' : ''}> 여자
					<input type="radio" name="gender" value="3" ${vo2.gender == '2' ? 'checked' : ''}> 비공개
				</div>
			</div>
			<div>
				<input type="checkbox" name="foodlike" value="한식" ${vo2.food_like.contains('한식') ? 'checked' : ''}> 한식
				<input type="checkbox" name="foodlike" value="중식" ${vo2.food_like.contains('중식') ? 'checked' : ''}> 중식
				<input type="checkbox" name="foodlike" value="일식" ${vo2.food_like.contains('일식') ? 'checked' : ''}> 일식
				<input type="checkbox" name="foodlike" value="양식" ${vo2.food_like.contains('양식') ? 'checked' : ''}> 양식
			</div>
		</div>
	</div>
 		<button onclick="update()">회원수정</button>
		<button onclick="deleteOK()">회원삭제</button> 
</body>
</html>