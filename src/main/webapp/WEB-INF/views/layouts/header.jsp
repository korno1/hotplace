<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/layouts/header.css">
<body>
	<div class="top_menu_div">
		<div class="top_menu_logo headerWrap">
			<div class="main_logo headerMenu"><img style="width:200px;"src="${pageContext.request.contextPath}/resources/hotLogo.png"></div>
		</div>
		<div class="top_menu_post headerWrap">
			<div class="search_hotplace headerMenu">맛집찾기</div>
			<div class="search_party headerMenu">모임찾기</div>
			<div class="notice_menu headerMenu">공지사항</div>
			<div class="event_menu headerMenu">이벤트</div>
			<div class="faq_menu headerMenu">FAQ</div>
		</div>
		<div class="top_menu_member headerWrap">
			<div id="signUp" class="sign_up_menu headerMenu">회원가입</div>
			<div id="login" class="login_menu headerMenu">로그인</div>
			<div id="myPage" class="mypage_menu headerMenu">${nick_name}님</div>
			<div id="logout" class="logout_menu headerMenu">로그아웃</div>
<!-- 			<div id="newMail"class="newMail">N</div> -->
		</div>
	</div>
<script type="text/javascript">
	const menuElements = document.querySelectorAll('.headerMenu');

	menuElements.forEach((element) => {
	element.addEventListener('click', function() {
    // 클릭한 요소에 selected 클래스 추가
    menuElements.forEach((menuElement) => {
      menuElement.classList.remove('selected');
    });
    this.classList.add('selected');
    
    const menuClass = this.classList[0];
    let link;

    switch (menuClass) {
      case 'search_hotplace':
        link = '/hotplace/shop/selectAll.do?saerchKey=&searchWord=&pageNum=1';
        break;
      case 'search_party':
        link = '/hotplace/party/selectAll.do';
        break;
      case 'notice_menu':
    	link = '/hotplace/notice/selectAll.do';
        break;
      case 'event_menu':
        link = '/hotplace/event/selectAll.do';
        break;
      case 'faq_menu':
        link = '/hotplace/faq/selectAll.do';
        break;
      case 'sign_up_menu':
        link = '/hotplace/account/insert.do';
        break;
      case 'login_menu':
        link = '/hotplace/account/login.do';
        break;
      case 'logout_menu':
        link = '/hotplace/account/logout.do';
        break;
      case 'mypage_menu':
        link = '/hotplace/member/mypage.do';
        break;
      default:
        link = '/hotplace/home'; // 기본 링크
    }

    console.log('link...', link);
    console.log('click...');

    window.location.href = link;
  });
});
// document.addEventListener('DOMContentLoaded', function() {
// 	$.ajax({
// 	      url: "/mail/json/newMailCnt.do",
// 	      data: {
<%-- 	        recipient_num:'<%= session.getAttribute("num") %>'; --%>
// 	      },
// 	      method: 'GET',
// 	      dataType: 'json',
// 	      success: function(result) {
// 	        console.log('ajax...success:', result);
// 	        if(result.reslut==="OK"){
// 			document.getElementById("newMail").style.display = "block";
// 	        }else{
// 			document.getElementById("newMail").style.display = "none";
// 	        }
// 	      },
// 	      error: function(xhr, status, error) {
// 	        console.log('xhr.status:', xhr.status);
// 	      }
// 	    });
// 	  }
let nickName = '<%= session.getAttribute("nick_name") %>';
	if (nickName == 'null' || nickName == "") {
	    // 비로그인 상태인 경우
	    document.getElementById("myPage").style.display = "none";
	    document.getElementById("logout").style.display = "none";
	    document.getElementById("signUp").style.display = "block";
	    document.getElementById("login").style.display = "block";
	} else {
	    // 로그인 상태인 경우
	    document.getElementById("myPage").style.display = "block";
	    document.getElementById("logout").style.display = "block";
	    document.getElementById("signUp").style.display = "none";
	    document.getElementById("login").style.display = "none";
	}
</script>
</body>
</html>
