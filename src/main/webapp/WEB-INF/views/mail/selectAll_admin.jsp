<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/mail/selectAllAdmin.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
    console.log('onload....');
    // 받은 쪽지함, 보낸 쪽지함을 저장할 전역 변수
    let mailBoxFilter = 'receive';
    
    // 현재 URL에서 쿼리 문자열 가져오기
    let queryString = window.location.search;
    // URLSearchParams를 사용하여 쿼리 문자열 파싱
    let searchParams = new URLSearchParams(queryString);
    // 페이지 번호 추출
    let pageValue = searchParams.get('page');
    console.log('pageValue', pageValue);
    let page = pageValue ? parseInt(pageValue) : 1;
    console.log('page', page);
    
    window.changePage = function(button) {
        let buttonClass = $(button).attr('class').split(' ')[1];
        if (buttonClass === 'prev') {
            page = page - 1;
        } else if (buttonClass === 'next') {
        	page = page + 1;
        }
        // 쪽지 목록 갱신을 위해 Ajax 요청 호출
        refreshMailList();
    }
    $('#searchButton').click(function() {
    	refreshMailList();
	});
    
    function refreshMailList(){
    console.log('onload....');
        $.ajax({
            url: "json/selectAll_admin.do",
            method: 'GET',
            data:{
            	page:page,
            	searchKey: $("#searchKey").val(),
		        searchWord: $("#searchWord").val()	
            },
            dataType: 'json',
            success: function(result) {
                console.log('ajax...success:', result);
                let msg = "";
                for (var i = 0; i < result.vos.length; i++) {
                    msg += `
                    	<div class="mailList__item mailList__item">
                        <div class="mailList__itemLine itemLine">
                            <div style="display:none;" class="mailList__itemNum itemNum">\${result.vos[i].mail_num}</div>
                            <div class="mailList__itemTitle itemTitle">\${result.vos[i].title}</div>
                            <div class="mailList__itemSender itemSender">\${result.vos[i].sender_name}</div>
                            <div class="mailList__itemRecipient itemRecipient">\${result.vos[i].recipient_name}</div>
                            <div class="mailList__itemSendDate itemSendDate">\${new Date(result.vos[i].send_date).toLocaleString()}</div>
                            <div class="mailList__itemReadFlag itemReadFlag">\${result.vos[i].read_flag === 0 ? '읽지 않음' : '읽음'}</div>
                			<div class="mailList__itemDeleteBtn itemDeleteBtn">
                			<button class="DeleteBtn" onclick="deleteOK(\${result.vos[i].mail_num})">삭제</button>
							</div>
                        </div>
                        <div class="mailList__itemLine--hide itemLine--hide">
                            <div class="mailList__itemContent itemContent">\${result.vos[i].content}</div>
                        </div>
                    </div>
                    `;
                }
                $(".mailBoxWrap").html(msg);
                
                // 다음 페이지에 데이터가 없으면 클래스 'next'의 display 속성을 none으로 처리
				if (result.isLast===true) {
				    $(".next").css("display", "none");
				} else {
				    $(".next").css("display", "block");
				}
				// 첫 페이지에서는 .prev 클래스를 숨김
				if (page === 1) {
				    $(".prev").css("display", "none");
				} else {
				    $(".prev").css("display", "block");
				}
            },
            error: function(xhr, status, error) {
                console.log('xhr.status:', xhr.status);
            }
        });
    }
    refreshMailList();
});

function deleteOK(mail_num){
	  confirm("정말로 삭제하시겠습니까?");
        $.ajax({
            url: "json/deleteOK.do",
            method: 'POST',
            data:{mail_num:mail_num},
            dataType: 'json',
            success: function(result) {
				console.log('ajax...success:', result.result);
				let msg = '';
				if (result.result === 'OK') {
					msg = '삭제 되었습니다.';
					location.reload();
				} else {
					msg = '삭제에 실패했습니다.';
				}
				alert(msg);
			},
            error: function(xhr, status, error) {
                console.log('xhr.status:', xhr.status);
            }
        });
    }

$(document).on('click', '.itemLine', function() {
    $(this).toggleClass('active').siblings('.itemLine--hide').slideToggle();
});
</script>
</head>
<body>
	<h1 class="mailBoxName">쪽지함</h1>
		<select name="searchKey" id="searchKey">
		<option value="TITLE">쪽지 제목</option>
		<option value="SENDER_NAME">보낸 사람</option>
		<option value="RECIPIENT_NAME">받는 사람</option>
	</select>
	<input type="text" name="searchWord" id="searchWord">
	<button id="searchButton">검색</button>
	<div class="mailBoxTitle block">
		<div class="mailList__itemHead itemHead">
			<div class="mailList__itemTitle itemTitle">쪽지 제목</div>
			<div class="mailList__itemSender itemSender">보낸 사람</div>
			<div class="mailList__itemRecipient itemRecipient">받는 사람</div>
			<div class="mailList__itemSendDate itemSendDate">보낸 일자</div>
			<div class="mailList__itemReadFlag itemReadFlag">읽음 여부</div>
			<div class="mailList__itemDeleteBtn itemDeleteBtn">강제 삭제</div>
		</div>
	</div>
	<div class="mailBoxWrap block"></div>
	<div class="pagegation block">
		<div class="pagegation__prev prev" onclick="changePage(this)">이전</div>
		<div class="pagegation__next next" onclick="changePage(this)">다음</div>
	</div>
</body>
</html>



