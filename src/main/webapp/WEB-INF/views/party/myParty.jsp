<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 신청 정보</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/myParty.css?after" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

let userNum = ${num}; // userNum 변수의 값을 설정해야 합니다.
let currentPage = ${page}; // currentPage 변수의 값을 설정해야 합니다.
let previousPage;

$(document).on('click', '#par_back_page', function() {
    if(${page}==1){
		alert('첫 페이지입니다.');
		return false;
	}; 
    var previousPage = currentPage - 1;
    
    // 이전 페이지로 이동하는 URL을 생성합니다.
    var url = 'myParty.do?userNum=' + userNum + '&page=' + previousPage;

    // 생성된 URL로 페이지 이동
    location.href = url;
});

$(document).on('click', '#par_next_page', function() {
	if(${page}*5 >= ${myPartyCount}){
		alert('마지막 페이지입니다.');
		return false;
	} 
    var previousPage = currentPage + 1;
    
    // 다음 페이지로 이동하는 URL을 생성합니다.
    var url = 'myParty.do?userNum=' + userNum + '&page=' + previousPage;

    // 생성된 URL로 페이지 이동
    location.href = url;
});


</script>
</head>
<body>

	<div>
		<div class="title">내 신청 정보</div>
		<div class="header">
			<img width="100px" src="../resources/ProfileImage/${num}"
						onerror="this.src='../resources/ProfileImage/default.png'">
			<button class="userPage" onclick="location.href='/hotplace/userpage.do?num=${num}'">내 모임 정보</button>
		</div>
	
		<div>
			<c:forEach var="vo" items="${vos}">
				<div class="board">
					<div class="userImpo">
						<img width="50px" src="../resources/ProfileImage/${vo.writerNum}"
						onerror="this.src='../resources/ProfileImage/default.png'">
						<div class="userName">${vo.writerName}</div>
						<div class="status">
							<c:choose>
				                <c:when test="${vo.status == 0}">대기중</c:when>
				                <c:when test="${vo.status == 1}">승인됨</c:when>
				                <c:when test="${vo.status == 2}">거절됨</c:when>
				                <c:otherwise>알 수 없음</c:otherwise>
			            	</c:choose>
						</div>
						<div class="applicants">${vo.applicants}/${vo.max}</div>
					</div>
					<div class="content">
						<div class="par-title">${vo.title}</div>
						<button class="view" onclick="location.href='selectOne.do?partyNum=${vo.partyNum}'">MORE VIEW</button>
					</div>
				</div>
			</c:forEach>
			
<!-- 			<div class="par_paging" id="par_paging"> -->
<%-- 				<button class="par_back_page" onclick="location.href='myParty.do?userNum=${num}&page=${page-1}'" id="par_back_page">이전</button> --%>
<%-- 				<button class="par_next_page" onclick="location.href='myParty.do?userNum=${num}&page=${page+1}'" id="par_next_page">다음</button> --%>
<!-- 			</div> -->
			<div class="par_paging" id="par_paging">
				<button class="par_back_page" id="par_back_page">이전</button>
				<button class="par_next_page" id="par_next_page">다음</button>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	if(${page}==1){
		$('#par_back_page').click(function(){
			alert('첫번째 페이지입니다.');
			return false;
		});
		$('#par_next_page').click(function(){
			listView(${num}, ${page+1});
		});
	} else if((page)*5 >= ${myPartyCount}){
		$('#par_next_page').click(function(){
			alert('마지막 페이지입니다.');
			return false;
		});
		$('#par_back_page').click(function(){
			listView(${num}, ${page-1});
		});
	}
	</script>
</body>
</html>