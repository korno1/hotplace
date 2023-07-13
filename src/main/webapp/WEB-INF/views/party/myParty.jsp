<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 모임 정보</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/myParty.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js">
$(function(){
	 history.replaceState({}, null, location.pathname); 
})
</script>
</head>
<body>
	<h1>내 모임 정보</h1>
	<div>
		<img width="100px" src="../resources/ProfileImage/${num}"
					onerror="this.src='../resources/ProfileImage/default.png'">
		<div><a href="http://localhost:8088/hotplace/userpage.do?num=${num}">${userNum}</a></div>
	</div>

	<div>
		<c:forEach var="vo" items="${vos}">
			<div onclick="location.href='selectOne.do?partyNum=${vo.partyNum}'"
				class="board">
				<div>
					<c:choose>
		                <c:when test="${vo.status == 0}">대기중</c:when>
		                <c:when test="${vo.status == 1}">승인됨</c:when>
		                <c:when test="${vo.status == 2}">거절됨</c:when>
		                <c:otherwise>알 수 없음</c:otherwise>
	            	</c:choose>
				</div>
				<img width="50px" src="../resources/ProfileImage/${vo.writerNum}"
					onerror="this.src='../resources/ProfileImage/default.png'">
				<div>작성자 : ${vo.writerName}</div>
				<div>${vo.title}</div>
				<div>${vo.applicants}/${vo.max}</div>
			</div>
		</c:forEach>
		

		<div class="pagination">
			<div class="pagination-links">
				<a href="myParty.do?userNum=${num}&page=${page-1}" id="pre_page">이전</a>
				<a href="myParty.do?userNum=${num}&page=${page+1}" id="next_page">다음</a>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		console.log('${param.page}'.length==0?1:'${param.page}');
		let page = '${param.page}'.length==0?1:'${param.page}';
		if(page==1){
// 			$('#pre_page').hide();
			$('#pre_page').click(function(){
				alert('첫 페이지입니다.');
				return false;
			});
		}
		if((page)*5 >= ${myPartyCount}){
// 			$('#next_page').hide();
			$('#next_page').click(function(){
				alert('마지막 페이지입니다.');
				return false;
			});
		}
	</script>
</body>
</html>