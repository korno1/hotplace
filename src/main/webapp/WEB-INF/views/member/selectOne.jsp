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
	
	// 닉네임, 이메일 중복확인 통과 예외 처리
	if ('${vo2.nick_name}' !== nickName) {
	  if (nickNameCheck !== 1) {
	    alert('닉네임 중복을 확인해주시기 바랍니다.');
	    return; // 요청 중단
	  }
	}
	
	if ('${vo2.email}' !== email) {
	  if (emailCheck !== 1) {
	    alert('이메일 중복을 확인해주시기 바랍니다.');
	    return; // 요청 중단
	  }
	}
	formData.append("num", ${param.num});
	formData.append("nick_name", $('#nick_name').val());
	formData.append("email", $('#email').val());
	formData.append("pw", $('#pw').val());
	formData.append("address", $('#address').val());
	formData.append("gender", selectedGender);
	formData.append("food_like", foodLikes.join(','));
	for (let entry of formData.entries()) {
		  console.log(entry[0] + ": " + entry[1]);
		}
	$.ajax({
	 url: "json/updateOK.do",
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
	$.ajax({
		url : "json/deleteOK.do",
		data : {
			num : ${param.num},
		},
		method : 'POST',
		dataType : 'json',
		success : function(obj) {
			console.log('ajax...success:', obj);
			console.log('ajax...success:', obj.result);
			let msg = '';
			if (obj.result === 'OK') {
				msg = '회원탈퇴에 성공했습니다.';
				location.reload();
			} else {
				msg = '회원탈퇴에 실패했습니다.';
			}
			alert(msg);
		},
		error : function(xhr, status, error) {
			console.log('xhr.status:', xhr.status);
		}
	});//end $.ajax()...
}//end deleteeOK()...

//닉네임,이메일 중복체크 후 input태그 선택 시, 중복체크 결과 초기화 시키기
$(document).ready(function() {
	$('#nick_name').click(function() {
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
		//CSS error 클래스 등록
		confirmPassword.classList.add("error");
		return false;
	} else {
		//CSS error 클래스 제거
		confirmPassword.classList.remove("error");
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
</script>
</head>
<body>
	<h1>회원정보</h1>
	<div class="memberInfoWrap block">
		<div class="memberInfo__leftTab">
			<div class="memberInfo__profile myTitle">프로필 사진</div>
			<div class="memberInfo__nickName myTitle">닉네임</div>
			<div class="memberInfo__email myTitle">이메일 주소</div>
			<div class="memberInfo__pw myTitle">비밀 번호</div>
			<div class="memberInfo__address myTitle">사는 지역</div>
			<div class="memberInfo__gender myTitle">성별</div>
			<div class="memberInfo__foodLike myTitle">음식 취향</div>
		</div>
		<div class="memberInfo__rightTab">
			<div class="memberInfo__imageTab__content myContent">
				<div class="memberInfo__image">
					<img id="preview" width="100px"
						src="../resources/ProfileImage/${vo2.num}"
						onerror="this.src='../resources/ProfileImage/default.png'">
				</div>
				<div class="memberInfo__imageBtn">
					<input type="file" id="imageFile" accept="image/*"
						onchange="uploadFile()">
				</div>
			</div>
			<div class="memberInfo__nickName__content myContent">
				<input type="text" id="nick_name" name="nick_name"
					value="${vo2.nick_name}">
				<button type="button" onclick="NickNameCheck()" class="myButton">닉네임
					중복체크</button>
				<span id="nickNameCheck"></span>
			</div>
			<div class="memberInfo__email__content myContent">
				<input type="email" id="email" name="email" value="${vo2.email}">
				<button type="button" onclick="EmailCheck()" class="myButton">이메일
					중복체크</button>
				<span id="emailCheck"></span>
			</div>
			<div class="memberInfo__pw__content myContent">
				<input type="password" id="pw" name="pw" value="${vo2.pw}">
				<input type="password" id="pwCheck" name="pwCheck"
					oninput="checkPassword()" value="${vo2.pw}"> <span>
					특수문자(예: !@#$ 등) 1자 이상을 포함한 10~16 글자의 비밀번호로 설정해주세요. </span>
			</div>
			<div class="memberInfo__address__content myContent">
				<input type="text" id="address" name="address"
					value="${vo2.address}">
			</div>
			<div class="memberInfo__gender__content myContent">
				<div>
					<input type="radio" name="gender" value="0"
						${vo2.gender == '0' ? 'checked' : ''}> 남자 <input
						type="radio" name="gender" value="1"
						${vo2.gender == '1' ? 'checked' : ''}> 여자 <input
						type="radio" name="gender" value="2"
						${vo2.gender == '2' ? 'checked' : ''}> 비공개
				</div>
			</div>
			<div class="memberInfo__foodLike__content myContent">
				<input type="checkbox" name="foodlike" value="한식"
					${vo2.food_like.contains('한식') ? 'checked' : ''}> 한식 <input
					type="checkbox" name="foodlike" value="중식"
					${vo2.food_like.contains('중식') ? 'checked' : ''}> 중식 <input
					type="checkbox" name="foodlike" value="일식"
					${vo2.food_like.contains('일식') ? 'checked' : ''}> 일식 <input
					type="checkbox" name="foodlike" value="양식"
					${vo2.food_like.contains('양식') ? 'checked' : ''}> 양식
			</div>
		</div>
	</div>
	<div class="memberInfo__btnWrap">
		<button onclick="updateOK()">회원수정</button>
		<button onclick="deleteOK()">회원삭제</button>
	</div>
</body>
</html>