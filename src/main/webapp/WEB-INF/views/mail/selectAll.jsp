<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/mail/selectAll.css">
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
    window.changeBox = function(button) {
        let buttonClass = $(button).attr('class').split(' ')[1];
        if (buttonClass === 'receiveBox') {
        	page=1;
            $(".sendBox").removeClass("boxSelect").addClass("boxNotSelect");
            mailBoxFilter = 'receive';
            $(button).addClass("boxSelect");
            $(".mailBoxName").text('받은 쪽지함');
        } else if (buttonClass === 'sendBox') {
        	page=1;
            $(".receiveBox").removeClass("boxSelect").addClass("boxNotSelect");
            mailBoxFilter = 'send';
            $(button).addClass("boxSelect");
            $(".mailBoxName").text('보낸 쪽지함');
        }
        // 쪽지 목록 갱신을 위해 Ajax 요청 호출
        refreshMailList();
    }
    function refreshMailList() {
        let data = {
            page: page
        };
        if (mailBoxFilter === "send") {
            data.sender_num = ${num};
            data.recipient_num = 0;
        } else if (mailBoxFilter === "receive") {
            data.recipient_num = ${num};
            data.sender_num = 0;
        }
        $.ajax({
            url: "json/selectAll.do",
            data: data,
            method: 'GET',
            dataType: 'json',
            success: function(result) {
                console.log('ajax...success:', result);
                let msg = "";
                for (var i = 0; i < result.vos.length; i++) {
                    msg += `
                    	<div class="mailList__item mailList__item">
                        <div class="mailList__itemLine itemLine">
                        	<div style="display: none;" class="mailList__itemRead readFlag" data-read-flag="\${result.vos[i].read_flag}"></div>
                            <div style="display:none;" class="mailList__itemNum itemNum">\${result.vos[i].mail_num}</div>
                            <div class="mailList__itemTitle itemTitle">\${result.vos[i].title}</div>
                            <div class="mailList__itemSender itemSender">\${result.vos[i].sender_name}</div>
                            <div class="mailList__itemSendDate itemSendDate">\${new Date(result.vos[i].send_date).toLocaleString()}</div>
                        </div>
                        <div class="mailList__itemLine--hide itemLine--hide">
                            <div class="mailList__itemContent itemContent">\${result.vos[i].content}</div>
                            <div class="mailList__replyBtnWrap replyBtnWrap">
                            <button class="insertMailBtn\${result.vos[i].sender_num} replyBtn" onclick="insertMail(this)">답장 보내기</button>
                            </div>
                        </div>
                    </div>
                    `;
                }
				$(".mailBoxWrap").html(msg);
                if (mailBoxFilter === "receive") {
                    $('.readFlag[data-read-flag="0"]').parent().find('.itemTitle').css('font-weight', 'bold');
                }

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
    // 페이지 로드 시 쪽지 목록 갱신
    refreshMailList();
});

function insertMail(button) {
	  let buttonClass = $(button).attr('class');
	  let num = buttonClass.match(/\d+/)[0];

	  let width = 840; // 팝업창의 너비
	  let height = 700; // 팝업창의 높이

	  // 브라우저 사이즈 측정
	  let screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
	  let screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

	  // 팝업창 위치 계산
	  let left = (screenWidth - width) / 2;
	  let top = (screenHeight - height) / 2;

	  // 팝업창 열기
	  window.open('../mail/insert.do?num=' + num, 'Popup', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top + ',resizable=no');
}

$(document).on('click', '.itemLine', function() {
    $(this).toggleClass('active').siblings('.itemLine--hide').slideToggle();
    
    // 받은 쪽지함에서 눌렀을 때만 읽음 처리를 위한 분기 처리
    let readOnRecieve = $(".receiveBox").attr('class').split(' ')[2];
    if (readOnRecieve == 'boxSelect') {
        let mail_num = $(this).children('.itemNum').text();
        console.log('mail_num', mail_num);
        let data = {
            mail_num: mail_num
        };
        
        // 'this' 변수에 저장
        let self = this;
        
        $.ajax({
            url: "json/readOK.do",
            data: data,
            method: 'GET',
            dataType: 'json',
            success: function(result) {
                console.log('ajax...success:', result);
                
                // 'self' 변수를 사용하여 요소 선택
                $(self).children('.itemTitle').css('font-weight', 'normal');
            },
            error: function(xhr, status, error) {
                console.log('xhr.status:', xhr.status);
            }
        });
    }
});
</script>
</head>
<body>
	<h1 class="mailBoxName">쪽지함</h1>
	<div class="mailFilterWrap block">
		<div class="mail__receBox receiveBox boxSelect" onclick="changeBox(this)">받은 쪽지함</div>
		<div class="mail__sendBox sendBox boxNotSelect" onclick="changeBox(this)">보낸 쪽지함</div>
	</div>
	<div class="mailBoxTitle block">
		<div class="itemTitle headTitle">제목</div>
		<div class="itemSender headTitle">작성자</div>
		<div class="itemSendDate headTitle">작성일자</div>
	</div>
	<div class="mailBoxWrap block">
	</div>
	<div class="pagegation block">
		<div class="pagegation__prev prev" onclick="changePage(this)">이전</div>
		<div class="pagegation__next next" onclick="changePage(this)">다음</div>
	</div>
</body>
</html>



