<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 보내기</title>
<link rel="stylesheet" href="../resources/css/mail/insert.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
// 현재 URL에서 쿼리 문자열 가져오기
let queryString = window.location.search;

// URLSearchParams를 사용하여 쿼리 문자열 파싱
let searchParams = new URLSearchParams(queryString);

// num 번호 추출
let paramNum = searchParams.get('num');
let user_num = ${num};

$(function() {
	console.log("onload....");
	
	function selectOne() {
		console.log("selectOne....");
		console.log("paramNum....",paramNum);
		
		$.ajax({
			url : "../member/json/selectOne.do",
			data : {
				num:paramNum
			},
			method : 'POST',
			dataType : 'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				$("#recipientName").val(obj.nick_name);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});//end $.ajax()...
	}//end selectOne()...

	selectOne(); // selectOne() 함수 호출
});
function insertOK() {
	  console.log("insertOK....");
	  let title = $('#title').val();
	  let recipient_num = paramNum;
	  let content = $('#Content').val();
	  let sender_num = user_num;
	  if (title === "") {
	    alert('쪽지의 제목을 입력해주시기 바랍니다.');
	  } else if (content === "") {
	    alert('쪽지 내용을 입력해주시기 바랍니다.');
	  } else {
	    // 데이터 전송 로직
	    $.ajax({
	      url: "json/insertOK.do",
	      data: {
	        title: title,
	        recipient_num: recipient_num,
	        content: content,
	        sender_num: sender_num
	      },
	      method: 'POST',
	      dataType: 'json',
	      success: function (obj) {
	        console.log('ajax...success:', obj.result);
	        let msg = '';
	        if (obj.result === 'OK') {
	          msg = '쪽지가 성공적으로 전송되었습니다.';
	          window.close()
	          } else {
	          msg = '쪽지 전송에 실패했습니다.';
	        }
	        alert(msg);
	      },
	      error: function (xhr, status, error) {
	        console.log('xhr.status:', xhr.status);
	      }
	    });
	  }
	}

</script>
</head>
<body>
	<div class="mailInsertWrap block">
		<div class="mailInsertHead">쪽지 보내기</div>
		<div class="mailInsertTitle mailInsert">
			<div class="mailInsertLeft"> 제목</div>
			<input type="text" id="title" name="title" placeholder="쪽지 제목">
		</div>
		<div class="mailInsertRecipientName mailInsert">
			<div class="mailInsertLeft"> 받는 사람</div>
			<input type="text" id="recipientName" name="recipientName" readonly>
		</div>
		<div class="mailInsertContent mailInsert">
			<div class="mailInsertLeft"> 내용</div>
			<input type="text" id="Content" name="Content" placeholder="내용">
		</div>
		<div class="mailInsert__bottomWrap">
			<div class="mailInsertBtn InsertBtn" onclick="insertOK()">전송</div>
		</div>
	</div>
</body>
</html>