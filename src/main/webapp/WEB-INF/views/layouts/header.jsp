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
		<ul class="top_menu_logo">
			<li class="main_logo menu">HOTPLACE</li>
		</ul>
		<ul class="top_menu_post">
			<li class="search_hotplace menu">맛집찾기</li>
			<li class="search_party menu">모임찾기</li>
			<li class="notice_menu menu">공지사항</li>
			<li class="event_menu menu">이벤트</li>
			<li class="faq_menu menu">FAQ</li>
		</ul>
		<ul class="top_menu_member">
			<li id="signUp" class="sign_up_menu menu">회원가입</li>
			<li id="login" class="login_menu menu">로그인</li>
			<li id="logout" class="logout_menu menu">로그아웃</li>
			<li id="myPage" class="mypage_menu menu">${nick_name}님</li>
		</ul>
	</div>
<script type="text/javascript">
	const menuElements = document.querySelectorAll('.menu');

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
        link = '모임_정보_링크';
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
