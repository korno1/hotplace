<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>마이 페이지</title>
<link rel="stylesheet" href="resources/css/myPage.css">

</head>
<body>
	<div class="myPage block">
		<div class="myPageTitle">
			<div class="myPageTitle__eng">MY PAGE</div>
			<div class="myPageTitle__kor">마이페이지</div>
		</div>
		<div class="partyWrap wrap">
			<div class="partyTitle title">모임 관리</div>
			<div class="partyInfo menu">내 모임 정보</div>
			<div class="partyAll menu">모임 정보</div>
		</div>
		<div class="memberWrap wrap">
			<div class="memberTitle title">회원 관리</div>
			<div class="memberInfo menu">회원정보 수정</div>
			<div class="memberAll menu">회원정보 조회</div>
		</div>
		<div class="mailWrap wrap">
			<div class="mailTitle title">쪽지 관리</div>
			<div class="mailInfo menu">쪽지함</div>
			<div class="mailAll menu">쪽지 조회</div>
		</div>
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
      case 'partyInfo':
        link = 'party/selectAll.do';
        break;
      case 'partyAll':
        link = '모임_정보_링크';
        break;
      case 'memberInfo':
        link = 'member/selectOne.do';
        break;
      case 'memberAll':
        link = 'member/selectAll.do';
        break;
      case 'mailInfo':
        link = 'mail/selectAll.do';
        break;
      case 'mailAll':
        link = 'mail/selectAll_admin.do';
        break;
      default:
        link = 'myPage.do'; // 기본 링크
    }

    console.log('link...', link);
    console.log('click...');

    window.location.href = link;
  });
});
</script>
</body>
</html>
