<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 모임 정보</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/selectAll.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js">
$(function(){
	 history.replaceState({}, null, location.pathname); 
})
</script>
</head>
<body>
	<h1>내 모임 정보</h1>
	<hr>
	<button onclick="location.href='myParty.do?searchKey=${searchKey}&searchWord=${searchWord}&page=1'">내모임</button>

	<div class="write-post">
		<a href="insert.do">모임글쓰기</a>
	</div>

	<hr>
	<div>
		<c:forEach var="vo" items="${vos}">
			<div onclick="location.href='selectOne.do?partyNum=${vo.partyNum}'"
				class="post">
				<div>${vo.applicants}/${vo.max}</div>
				<hr>
				<div>마감일 : ${vo.deadLine}</div>
				<div>[${vo.place}] ${vo.title}</div>
				<div>조회수: ${vo.views}</div>
				<hr>
				<div>작성자 : ${vo.writerName}</div>
			</div>
		</c:forEach>
		
		<div>
			<img width="100px" src="../resources/ProfileImage/${vo2.writerNum}"
						onerror="this.src='../resources/ProfileImage/default.png'">
			<div><a href="http://localhost:8088/hotplace/userpage.do?num=${vo2.writerNum}">${vo2.writerName}(작성자)</a></div>
		</div>

		<div class="pagination">
			<div class="pagination-links">
				<a href="myParty.do?writerNum=${writerNum}&page=${page-1}" id="pre_page">이전</a>
				<a href="myParty.do?writerNum=${writerNum}&page=${page-1}" id="next_page">다음</a>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		console.log('${param.page}'.length==0?1:'${param.page}');
		let cpage = '${param.page}'.length==0?1:'${param.page}';
		if(cpage==1){
// 			$('#pre_page').hide();
			$('#pre_page').click(function(){
				return false;
			});
		}
// 		if((${param.page}*6) >= ${cnt}){
// // 			$('#next_page').hide();
// 			$('#next_page').click(function(){
// 				return false;
// 			});
// 		}
	</script>
</body>
</html>