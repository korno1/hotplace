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
	        authResult=1;
	        message = "회원님의 가입된 이메일은 " + result.email + " 입니다.";
	      } else if(result.result === "NotOK") {
	        // 인증번호가 일치하지 않는 경우
	        message = "인증번호가 일치하지 않습니다.";
	      }

	      showAlertModal(message); // 메시지를 전달하여 모달 창 열기
	    },
	    error: function(xhr, status, error) {
	      console.log('xhr.status:', xhr.status);
	    }
	  });
	}

	function showAlertModal(message) {
	  $("#errorMessage").text(message); // 모달 창에 메시지 설정
	  $("#errorModal").modal("show"); // 모달 창 열기

	  // 모달 창이 닫힌 후 페이지 이동
	  $('#errorModal').on('hidden.bs.modal', function (e) {
	    if (authResult === 1) {
	      // 인증번호가 일치하는 경우
	      window.location.href = '/hotplace/account/login.do';
	    } else {
	      // 인증번호가 일치하지 않는 경우
	      window.location.href = '/hotplace/account/findId.do';
	    }
	  });
	}

</script>
</head>
<body>
	<div class="form-container">
		<div class="textbox">
			<label class="label">이메일 찾기 인증번호</label> <input type="text" id="authNum"
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