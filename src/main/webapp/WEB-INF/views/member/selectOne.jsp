<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectOne</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member/selectOne.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
//닉네임, 이메일 중복처리를 위한 전역 변수 설정
let nickNameCheck = 0;
let emailCheck = 0;

$(function() {
	console.log("onload....");
});
function NickNameCheck() {
	console.log("NickNameCheck....", $('#nickName').val());

	$.ajax({
		url : "${pageContext.request.contextPath}/member/json/nickNameCheck.do",
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
		url : "${pageContext.request.contextPath}/member/json/emailCheck.do",
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

let formData; // formData를 전역 변수로 선언

function uploadFile2() {
	  let fileInput = document.getElementById("imageFile");
	  formData = new FormData();
	  if (fileInput.files.length > 0) {
	    var file = fileInput.files[0];
	    formData.append("multipartFile", file);
	  }
	}

function updateOK() {
	console.log("updateOK....");
	
	let selectedGender = $('input[name="gender"]:checked').val();
	
	// 선택된 음식 선호 값을 가져옴
	let foodLikes = []; // 배열에 넣기
	$('input[name="foodlike"]:checked').each(function() {
	  foodLikes.push($(this).val());
	});
	
	uploadFile2(); // formData 업데이트

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
	
	// 닉네임, 이메일 중복확인 통과 예외 처리
	else if ('${vo2.nick_name}' !== nickName) {
	  if (nickNameCheck !== 1) {
	    alert('닉네임 중복을 확인해주시기 바랍니다.');
	    return; // 요청 중단
	  }
	} else if ('${vo2.email}' !== email) {
	  if (emailCheck !== 1) {
	    alert('이메일 인증을 확인해주시기 바랍니다.');
	    return; // 요청 중단
	  }
	}
	formData.append("num", ${param.num});
	formData.append("nick_name", $('#nickName').val());
	formData.append("email", $('#email').val());
	formData.append("pw", $('#pw').val());
	formData.append("address", $('#address').val());
	formData.append("gender", selectedGender);
	formData.append("food_like", foodLikes.join(','));
	for (let entry of formData.entries()) {
		  console.log(entry[0] + ": " + entry[1]);
		}
	$.ajax({
	 url: "${pageContext.request.contextPath}/member/json/updateOK.do",
	 data: formData,
	 method: 'POST',
	 dataType: 'json',
	 contentType: false, // 기본 contentType을 false로 설정
	 processData: false, // 데이터 처리를 jQuery가 자동으로 하지 않도록 설정
	 success: function(obj) {
	    console.log('ajax...success:', obj);
	    console.log('ajax...success:', obj.result);
	    let msg = '';
	    if (obj.result === 'OK') {
	      msg = '회원정보 수정에 성공했습니다.';
	      location.reload();
	    } else {
	      msg = '회원정보 수정에 실패했습니다.';
	    }
	    alert(msg);
	  },
	  error: function(xhr, status, error) {
	    console.log('xhr.status:', xhr.status);
	  }
	});//end $.ajax()...
	return checkPassword();
}//end updateOK()...

function deleteOK() {
	  let deleteConfirmMsg = "회원탈퇴 시 모든 정보가 삭제되며<br>추후 어떠한 방법으로도 복구가 불가능합니다.";
	  let confirmed = confirm(deleteConfirmMsg);

	  if (confirmed) {
	    $.ajax({
	      url: "${pageContext.request.contextPath}/member/json/deleteOK.do",
	      data: {
	        num: ${param.num},
	      },
	      method: "POST",
	      dataType: "json",
	      success: function (obj) {
	        console.log("ajax...success:", obj);
	        console.log("ajax...success:", obj.result);
	        let msg = "";
	        if (obj.result === "OK") {
	          window.location.href = "account/logout.do";
	          msg = "회원탈퇴에 성공했습니다.";
	        } else {
	          msg = "회원탈퇴에 실패했습니다.";
	        }
	        alert(msg);
	      },
	      error: function (xhr, status, error) {
	        console.log("xhr.status:", xhr.status);
	      },
	    });
	  } else {
	    return;
	  }
	}

//닉네임,이메일 중복체크 후 input태그 선택 시, 중복체크 결과 초기화 시키기
$(document).ready(function() {
	$('#nickName').click(function() {
		//전역변수 초기화
		nickNameCheck = 0;
		// 중복확인 결과 텍스트 초기화
		$('#nickNameCheck').text('');
	});
	//이메일 input 누르면 작동
	$('#email').click(function() {
		//전역변수 초기화
		emailCheck = 0;
		// 중복확인 결과 텍스트 초기화
		$('#emailCheck').text('');
	});
});

function checkPassword() {
	//비밀번호 1번째꺼 가져오기
	let password = document.getElementById("pw").value;
	//비밀번호 2번째꺼 가져오기
	let confirmPassword = document.getElementById("pwCheck");
	
	//1번째=2번째 확인
	if (password !== confirmPassword.value) {
		$('#pwWorng').html('입력된 비밀번호가 일치하지 않습니다.');
		return false;
	} else {
		$('#pwWorng').html('');
		return true;
	}
}
$('#imageFile').change(function(){ uploadFile();});
function uploadFile() {
	var file = event.target.files[0];
    let reader = new FileReader();
    reader.onload = function(e) {
        // 파일명에서 확장자 가져오기
        let ext = file.name.split(".").pop().toLowerCase();
        //확장자 제한 걸기
        if ($.inArray(ext, ["jpg", "jpeg", "png"]) === -1) { 
            alert('"jpg","jpeg","png"확장자의 이미지파일만 업로드가 가능합니다.');
         	// 파일 선택을 초기화
            $("#imageFile").val("");
            // 미리보기 이미지 초기화
            $("#preview").attr("src", "");
            return;
        }

        // 이곳에서 파일 업로드 등의 추가 로직 수행 가능
        let maxSize = 3 * 1024 * 1024; // 3MB로 제한
        if (file.size > maxSize) {
            alert('이미지파일은 3MB이하만 업로드가 가능합니다.');
         	// 파일 선택을 초기화
            $("#imageFile").val("");
            // 미리보기 이미지 초기화
            $("#preview").attr("src", "");
            return;
        }
        //등록한 이미지 프사 이미지칸에 미리보기 교체
        $("#preview").attr("src", e.target.result);
    };
    reader.readAsDataURL(file);
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
	    url: "${pageContext.request.contextPath}/account/json/authCheck.do",
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
</script>
</head>
<body>
	<h1>회원정보</h1>
	<div class="memberInfoWrap block">
			<div class="memberInfo__imageTab__content">
				<div class="memberInfo__image">
					<img id="preview" width="100px" src="${pageContext.request.contextPath}/resources/ProfileImage/${vo2.num}.png"
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/ProfileImage/default.png';">
				</div>
				<div class="memberInfo__imageBtn">
					<label class="imageFileBtn" for="imageFile">찾아보기</label>
					<input type="file" id="imageFile" accept="image/*"
						onchange="uploadFile()"><br>
					<span class="fileUploadText">회원 프로필 사진으로 사용될 이미지를 등록해 주세요. 이미지는 png,jpg,jpeg 확장자만 등록이 가능하며 3mb이하만 허용됩니다.</span>
				</div>
			</div>
		<div class="memberInfo__table">
			<div class="memberInfo__tr1 memberInfo__tr">
				<div class="memberInfo__nickNameTitle myTitle">닉네임</div>
				<div class="memberInfo__nickName__content myContent">
					<input type="text" id="nickName" name="nickName"
						value="${vo2.nick_name}">
					<button type="button" onclick="NickNameCheck()" class="myButton">중복확인</button>
					<span id="nickNameCheck"></span>
				</div>
			</div>
			<div class="memberInfo__trSpan memberInfo__tr">
				<div class="memberInfo__nickNameTitle myTitle">아이디(이메일)</div>
				<div class="memberInfo__email__content myContent">
					<input type="email" id="email" name="email" value="${vo2.email}">
					<button type="button" onclick="EmailCheck()" class="emailBtn myButton">이메일 인증</button>
				</div>
			</div>
			<div class="memberInfo__tr2 memberInfo__tr">
				<div class="memberInfo__nickNameTitle myTitle"></div>
				<div class="memberInfo__email__content myContent">
					<input type="text" id="authNum" name="authNum" placeholder="인증번호 입력">
					<span id="authTime"></span>
					<span id="emailCheck"></span>
				</div>
			</div>
			<div class="memberInfo__tr3 memberInfo__tr">
				<div class="memberInfo__nickNameTitle myTitle">비밀번호</div>
				<div class="memberInfo__pw__content myContent">
					<input type="password" id="pw" name="pw" value="${vo2.pw}">
				</div>
			</div>
			<div class="memberInfo__tr4 memberInfo__tr">
				<div class="memberInfo__pwCheckTitle myTitle">비밀번호 확인</div>
				<div class="memberInfo__pwCheck__content myContent">
					<input type="password" id="pwCheck" name="pwCheck"
						oninput="checkPassword()" value="${vo2.pw}">
					<span id="pwWorng"></span>	
				</div>
			</div>
			<div class="memberInfo__tr5 memberInfo__tr">
				<div class="memberInfo__pwCheckTitle myTitle">주소지</div>
				<div class="memberInfo__address__content myContent">
				<input type="text" id="address" name="address"
					value="${vo2.address}">
				</div>
			</div>
			<div class="memberInfo__tr6 memberInfo__tr">
				<div class="memberInfo__genderTitle myTitle">성별</div>
				<div class="memberInfo__gender__content myContent">
				<div>
					<input type="radio" name="gender" value="0"	${vo2.gender == '0' ? 'checked' : ''}>
					<label for="gender">남자</label>
					<input type="radio" name="gender" value="1" ${vo2.gender == '1' ? 'checked' : ''}>
					<label for="gender">여자</label>
					<input type="radio" name="gender" value="2" ${vo2.gender == '2' ? 'checked' : ''}>
					<label for="gender">비공개</label>
				</div>
				</div>
			</div>
			<div class="memberInfo__tr7 memberInfo__tr">
				<div class="memberInfo__genderTitle myTitle">음식 선호</div>
				<div class="memberInfo__foodLike__content myContent">
				<input type="checkbox" name="foodlike" value="한식" ${vo2.food_like.contains('한식') ? 'checked' : ''}>
				<label for="foodlike">한식</label>
				<input type="checkbox" name="foodlike" value="중식" ${vo2.food_like.contains('중식') ? 'checked' : ''}>
				<label for="foodlike">중식</label>
				<input type="checkbox" name="foodlike" value="일식" ${vo2.food_like.contains('일식') ? 'checked' : ''}>
				<label for="foodlike">일식</label>
				<input type="checkbox" name="foodlike" value="양식" ${vo2.food_like.contains('양식') ? 'checked' : ''}>
				<label for="foodlike">양식</label>
			</div>
			</div>
		</div><!-- end table -->
	</div>
	<div class="memberInfo__btnWrap">
		<div class="myTitle">
		<button class="deleteBtn" onclick="deleteOK()">회원탈퇴</button>
		</div>
		<div class="memberInfo__updateBtn">
		<button class="updatedBtn" onclick="updateOK()">회원수정</button>
		</div>
	</div>
</body>
</html>