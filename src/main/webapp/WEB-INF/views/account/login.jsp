<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member/login.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		console.log("onload....");
	});
	function loginOK() {
		console.log("loginOK....");
		let email = $('#email').val();
		let pw = $('#pw').val();
		
		if(email===""){
			alert('이메일을 입력해주시기 바랍니다.');
			return;
		}else if(pw===""){
			alert('비밀번호를 입력해주시기 바랍니다.');
			return;
		}
		
		$.ajax({
			url : "json/loginOK.do",
			data : {
				email : $('#email').val(),
				pw : $('#pw').val(),
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '로그인에 성공했습니다.';
					window.location.href = "/hotplace/home";
				} else {
					msg = '로그인에 실패했습니다.';
				}
				alert(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
	}//end insertOK()...
	
function linkSignUp() {
	  // 회원가입 페이지로 이동하는 코드 작성
	  window.location.href = "/hotplace/account/insert.do"; // 회원가입 페이지의 경로를 설정
	}
function findId() {
	  window.location.href = "/hotplace/account/findId.do";
	}
function findPw() {
	  window.location.href = "/hotplace/account/findPw.do";
	}
</script>
</head>
<body>
	<div class="bodyWrap">
	<span class="loginText">로그인</span>
		<div class="loginWrap">
			<div class="inputWrap">
				<div class="emailWrap">
					<div class="emailInput"><input type=email name="email" id="email" placeholder="이메일 입력"></div>
				</div>
				<div class="pwWrap">
					<div class="pwInput"><input type=password name="pw" id="pw" placeholder="비밀번호 입력"></div>
				</div>
			</div>
			<div class="loginBtnWrap">
				<div class="LoginBtn" onclick="loginOK()">로그인</div>
			</div>
			<div class="loginBottmMenu">
				<div class="singUp" onclick="linkSignUp()">회원가입</div>
				<div class="findId" onclick="findId()">아이디 찾기</div>
				<div class="findPw" onclick="findPw()">비밀번호 찾기</div>
			</div>
		</div>
	</div>
</body>
</html>