<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member/insert.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	let nickNameCheck = 0;
	let emailCheck = 0;

	$(function() {
		console.log("onload....");
	});

	function NickNameCheck() {
		console.log("NickNameCheck....", $('#nickName').val());

		$.ajax({
			url : "/hotplace/member/json/nickNameCheck.do",
			data : {
				nick_name : $('#nickName').val()
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
		$('#emailCheck').html('');
		const fiveMinutes = 5 * 60;
		const display = document.getElementById('authTime');
		$.ajax({
			url : "/hotplace/member/json/emailCheck.do",
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
				    $('.emailBtn').attr('onclick', 'authNumCheck()');
				    $('.emailBtn').text('인증번호 확인');
					msg = '사용가능한 이메일입니다.<br>발송된 이메일 확인 후 인증 번호를 입력해주세요.';
					startTimer(fiveMinutes, display);
				} else {
					msg = '사용중인 이메일입니다.';
				}
				$('#emailCheck').html(msg);
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
		let nickName = $('#nickName').val();
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
		} else if (address === '') {
			alert('주소를 입력해주세요.');
			return; // 요청 중단
		}
		// 		닉네임,이메일 중복확인 통과 예외 처리
		else if (nickNameCheck !== 1) {
			alert('닉네임 중복을 확인해주시기 바랍니다.');
			return; // 요청 중단
		} else if (emailCheck !== 1) {
			alert('이메일 인증을 확인해주시기 바랍니다.');
			return; // 요청 중단
		console.log('필수 입력 필드 검증 done...')

		}
		$.ajax({
			url : "/hotplace/member/json/insertOK.do",
			data : {
				nick_name : $('#nickName').val(),
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
				    window.location.href = '/hotplace/home';
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
		$('#nickName').click(function() {
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
			$('#pwWorng').html('입력된 비밀번호가 일치하지 않습니다.');
			return false;
		} else {
			$('#pwWorng').html('');
			return true;
		}
	}
	
	function startTimer(duration, display) {
		  let timer = duration;
		  let minutes, seconds;

		  const timerInterval = setInterval(function() {
		    minutes = parseInt(timer / 60, 10);
		    seconds = parseInt(timer % 60, 10);

		    minutes = minutes < 10 ? '0' + minutes : minutes;
		    seconds = seconds < 10 ? '0' + seconds : seconds;

		    display.textContent = minutes + ':' + seconds;

		    if (--timer < 0) {
		      clearInterval(timerInterval);
			  emailCheck = 0;
			  $('.emailBtn').attr('onclick', 'EmailCheck()');
			  $('.emailBtn').text('이메일 인증');
			  $('#emailCheck').html('인증번호 입력시간이 초과되었습니다.<br>이메일 인증을 다시 시도해주시기 바랍니다.');
		    }
		  }, 1000);
		}
	function authNumCheck() {
		  let message = ''; // 메시지 변수 초기화

		  $.ajax({
		    url: "json/authCheck.do",
		    data: {
		      num : $("#authNum").val()
		    },
		    method: 'POST',
		    dataType: 'json',
		    success: function(result) {
		      console.log('ajax...success:', result);

		      if (result.result === "OK") {
		        // 인증번호가 일치하는 경우
		        emailCheck=1;
		        message= "이메일 인증이 완료되었습니다.";
		      } else if(result.result === "NotOK") {
		        // 인증번호가 일치하지 않는 경우
		        message = "인증번호가 일치하지 않습니다.";
		      }

		      $('#emailCheck').html(message);
		    },
		    error: function(xhr, status, error) {
		      console.log('xhr.status:', xhr.status);
		    }
		  });
		}
	
function textlimit(category, obj) {
	let cateogry = category;
	let str = obj.value;
	let pattern = "";

	if (cateogry === "nickName") {
	    pattern = /^[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]{2,12}$/;
	    	if (str !== "" && !pattern.test(str)) {
	        	alert("닉네임은 알파벳, 한글로 조합된 2~12글자로 설정할 수 있습니다.");
	        	$("#nickName").val('');
			}
	}else if(cateogry==="email"){
		pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{5,33}$/;
			if (str !== "" && !pattern.test(str)) {
				alert("유효하지 않은 이메일 형식입니다");
			}
	}else if(cateogry==="pw"){
		pattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$/;
			if (str !== "" && !pattern.test(str)) {
		        alert("비밀번호는 숫자,소문자,대문자 각각 최소 1개씩 포함된 8~16자리로 설정해야합니다");
			}
	}else if(cateogry==="address"){
		pattern = /^.{0,70}$/;
			if (str !== "" && !pattern.test(str)) {
		        alert("거주 지역은 최대 70글자까지 입력이 가능합니다.");
	  		}
		}
	}
</script>
</head>
<body>
	<h1>회원가입</h1>
		<div class="signWrap">
			<div class="nickNameWrap">	
				<div class="nickNameTitle signTitle">(*필수)닉네임</div>
				<div class="nickNameContent signContent">
				<input type="text" id="nickName" name="nickName" placeholder="닉네임 입력" onchange="textlimit('nickName',this)">
				<button type="button" onclick="NickNameCheck()" class="nickNameBtn signButton">중복확인</button><br>
				</div>
				<span id="nickNameCheck"></span>
			</div>
			<div class="emailWrap">	
				<div class="emailTitle signTitle">(*필수)이메일 (로그인시 아이디로 사용)</div>
				<input type="email" id="email" name="email" placeholder="이메일 입력" onchange="textlimit('email',this)">
				<div class="emailAuthWrap">
					<input type="text" id="authNum" name="authNum" placeholder="인증번호 입력">
					<span id="authTime"></span>	
					<button type="button" onclick="EmailCheck()" class="emailBtn signButton">이메일 인증</button>
				</div>
					<span id="emailCheck"></span>
					
			</div>
			<div class="pwWrap">	
				<div class="pwTitle signTitle">(*필수)비밀번호</div>
				<input type="password" id="pw" name="pw" placeholder="비밀번호 입력" onchange="textlimit('pw',this)">
				<input type="password" id="pwCheck" name="pwCheck" onchange="checkPassword()" placeholder="비밀번호 재확인" onchange="textlimit('pw',this)">
				<span id="pwWorng"></span>	
			</div>
			<div class="addressWrap">
				<div class="addressTitle signTitle">(*필수)거주지역</div>
				<input type="text" id="address" name="address" value="(예시)서울특별시 강남구" onchange="textlimit('address',this)">
			</div>
			<div class="genderWrap">
				<div class="genderTitle signTitle">성별</div>
				<input type="radio" name="gender" value="0"><label for="gender">남자</label>
				<input type="radio" name="gender" value="1"><label for="gender">여자</label>
				<input type="radio" name="gender" value="2"><label for="gender">비공개</label>
				<br><span class="genderText">성별 정보는 모임 참여신청시 공개됩니다.</span>
			</div>
			<div class="foodLikeWrap">
				<div class="foodlikeTitle signTitle">음식 취향</div>
				<span><input type="checkbox" name="foodlike" value="한식"><label for="foodLike">한식</label></span>
				<span><input type="checkbox" name="foodlike" value="중식"><label for="foodLike">중식</label></span>
				<span><input type="checkbox" name="foodLike" value="일식"><label for="foodLike">일식</label></span>
				<span><input type="checkbox" name="foodLike" value="양식"><label for="foodLike">양식</label></span>
			</div>
			<div class="submitWrap">
				<input type="submit" class="signBtn signButton" onclick="insertOK()" value="회원가입">
			</div>	
		</div>
</body>
</html>