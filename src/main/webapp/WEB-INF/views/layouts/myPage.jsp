<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>마이 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layouts/myPage.css">
</head>
<body>
	<div class="myPage block">
		<div class="myPageTitle">
			<div class="myPageTitle__eng">MY PAGE</div>
			<div class="myPageTitle__kor">마이페이지</div>
		</div>
		<div class="partyWrap leftWrap">
			<div class="partyTitle leftTitle">모임 관리</div>
			<div class="partyInfo leftMenu">내 모임 정보</div>
			<div class="partyAll leftMenu">모임 정보</div>
		</div>
		<div class="memberWrap leftWrap">
			<div class="memberTitle leftTitle">회원 관리</div>
			<div class="memberInfo leftMenu">회원정보 수정</div>
			<div class="memberAll leftMenu">회원정보 조회</div>
		</div>
		<div class="mailWrap leftWrap">
			<div class="mailTitle leftTitle">쪽지 관리</div>
			<div class="mailInfo leftMenu">쪽지함</div>
			<div class="mailAll leftMenu">쪽지 조회</div>
		</div>
	</div>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	if(${grade}==1){
		$(".partyAll").css("display", "block");
		$(".memberAll").css("display", "block");
		$(".mailAll").css("display", "block");
	}
	
	  const menuElements = document.querySelectorAll('.leftMenu');

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
	        case 'partyInfo':
	          link = '/hotplace/party/selectAll.do';
	          break;
	        case 'partyAll':
	          link = '/hotplace/party/selectAll.do';
	          break;
	        case 'memberInfo':
	          link = '/hotplace/member/selectOne.do?num='+${num};
	          break;
	        case 'memberAll':
	          link = '/hotplace/member/selectAll.do';
	          break;
	        case 'mailInfo':
	          link = '/hotplace/mail/selectAll.do';
	          break;
	        case 'mailAll':
	          link = '/hotplace/mail/selectAllAdmin.do';
	          break;
	        default:
	          link = '/hotplace/member/mypage.do'; // 기본 링크
	      }

	      console.log('link...', link);
	      console.log('click...');

	      window.location.href = link;
	    });
	  });
	});
</script>
</body>
</html>
