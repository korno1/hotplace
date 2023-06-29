<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
		//받은쪽지,보낸쪽지 구분을 위한 전역 변수
		let mailBoxFilter = 'receive';
	function changeBox(button){
		let buttonClass = $(button).attr('class').split(' ')[1];
		if(buttonClass==='receiveBox'){
			mailBoxFilter = 'receive';
		}else if(buttonClass==='sendBox'){
			mailBoxFilter = 'send';
		}
	}	
		// 현재 URL에서 쿼리 문자열 가져오기
		let queryString = window.location.search;
		
		// URLSearchParams를 사용하여 쿼리 문자열 파싱
		let searchParams = new URLSearchParams(queryString);
		
		// 페이지 번호 추출
		let pageValue = searchParams.get('page');
		console.log('pageValue',pageValue);
		let page = pageValue ? parseInt(pageValue) : 1;
		console.log('page',page);
	$(function() {
		console.log('onload....');
		let data = {
	        page: page
	    };

	    if (mailBoxFilter === "send") {
	        data.sender_num = ${param.num};
	        data.recipient_num=0;
	    } else if (mailBoxFilter === "receive") {
	        data.recipient_num = ${param.num};
	        data.sender_num=0;
	    }

	    $.ajax({
        url: "json/selectAll.do",
        data: data,
        method: 'GET',
        dataType: 'json',
		success : function(arr) {
		console.log('ajax...success:', arr);
			 let msg ="";
			    for (var i = 0; i < arr.length; i++) {
			    	  msg += `
			    	<div class="mailList__item mailList__item">
			  			<div class="mailList__itemLine itemLine">
			  				<div class="mailList__itemNum itemNum">{arr[i].title}</div>
			  				<div class="mailList__itemTitle itemTitle">{arr[i].title}</div>
			  				<div class="mailList__itemSender itemSender">{arr[i].sender_name}</div>
			  				<div class="mailList__itemSendDate itemSendDate">{arr[i].send_date}</div>
			  			</div>
			  			<div class="mailList__itemLine--hide itemLine--hide">
			  				<div class="mailList__itemContent itemContent">{arr[i].content}</div>
			  			</div>
			  		</div>
			  		`;
			    }
			$(".mailBoxWrap").html(msg);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
});
</script>
</head>
<body>
	<h1>쪽지함</h1>
	<div class="mailFilterWrap block">
		<div class="mail__receBox receiveBox" onclick="changeBox(this)">받은 쪽지함</div>
		<div class="mail__sendBox sendBox" onclick="changeBox(this)">보낸 쪽지함</div>
	</div>
	<div class="mailBoxWrap block">
	</div>
	<div class="pagegation block">
		<div class="pagegation__prev prev">이전</div>
		<div class="pagegation__next next">다음</div>
	</div>
</body>
</html>



