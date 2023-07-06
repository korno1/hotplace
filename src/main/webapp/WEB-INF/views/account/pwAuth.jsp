<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member/findId.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
let authResult=0;
	function authNumCheck() {
		let inputNum = $("#authNum").val(); // 입력한 인증번호
		let message = ''; // 메시지 변수 초기화
		$.ajax({
			url: "json/authCheck.do",
		    data: {
		    	num : inputNum
		      },
		      method: 'POST',
		      dataType: 'json',
		      success: function(result) {
		        console.log('ajax...success:', result);
		
			if (result.result === "OK") {
				// 인증번호가 일치하는 경우
				authResult=1;
				message= `
				<span class="pwReset__title">비밀번호 변경</span><br>
				<div class="pwWrap">
				<input type="hidden" id="num" name="num" value="${vo2Num}">
	            <label for="pw">비밀번호</label>
	            <input type="password" class="input-field" id="pw" name="pw">
	            </div>
	            <div class="pwCheckWrap">
	            <label for="pwCheck">비밀번호 확인</label>
	            <input type="password" id="pwCheck" name="pwCheck" class="input-field" oninput="checkPassword()">
	            </div>
	            <span class="pwReset__text">특수문자(예: !@#$ 등) 1자 이상을 포함한 10~16 글자의 비밀번호로 설정해주세요.</span><br>
	            <div class="pwReset__btnWrap">
	            <button class="pwReset__btn" onclick="pwReset()">변경</button>
	            </div>
	        	 </div>`;
			} else if(result.result === "NotOK") {
				// 인증번호가 일치하지 않는 경우
				message = "인증번호가 일치하지 않습니다.";
			}
			showAlertModal(message);
			},
			error: function(xhr, status, error) {
			  console.log('xhr.status:', xhr.status);
			}
		})
	function showAlertModal(message) {
		  $("#errorMessage").html(message); // 모달 창에 메시지 설정
		  $("#errorModal").modal("show"); // 모달 창 열기

		  // 모달 창이 닫힌 후 페이지 이동
		  $('#errorModal').on('hidden.bs.modal', function (e) {
		    if (authResult === 1) {
		      // 인증번호가 일치하는 경우
		      window.location.href = '/hotplace/account/login.do';
		    } else {
		      // 인증번호가 일치하지 않는 경우
		      window.location.href = '/hotplace/account/findPw.do';
		    }
		  });
		}
	}

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
	
	function pwReset(){
		let password = document.getElementById("pw").value;
		let confirmPassword = document.getElementById("pwCheck").value;
		console.log('password',password);
		console.log('confirmPassword',confirmPassword);
		
		if(password===confirmPassword){
		console.log('pwReset()...');
		$.ajax({
			url : "json/pwResetOK.do",
			data : {
				pw : $('#pw').val(),
				num : $('#num').val()
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				console.log('ajax...success:', obj.result);
				let msg = '';
				if (obj.result === 'OK') {
					msg = '비밀번호를 변경했습니다.';
				    window.location.href = '/hotplace/account/login.do';
				} else {
					msg = '비밀번호 변경이 실패되었습니다.';
				}
				alert(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
		}else{
			alert('입력한 비밀번호를 확인해주시기 바랍니다.')
		}
	}//end insertOK()...
</script>
</head>
<body>
	<div class=form-container>
		<div class="textbox">
			<label class="label">비밀번호 찾기 인증번호</label> <input type="text" id="authNum"
				name="authNum" class="input-field" placeholder="인증번호를 입력하세요">
		</div>
		<br> <br> <input type="submit" id="check"
			onclick="authNumCheck()" class="submit-btn" value="확인">
	</div>
	<div class="modal fade" id="errorModal" tabindex="-1" role="dialog"
		aria-labelledby="errorModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="errorModalLabel">HOTPLACE</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p id="errorMessage"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>