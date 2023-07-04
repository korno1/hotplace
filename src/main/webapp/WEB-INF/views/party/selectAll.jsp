<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임리스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<h1>모임리스트</h1>
	<hr>
	<button onclick="">전체</button>
	<button onclick="">모집중</button>
	<button onclick="">모집완료</button>
	
	
	<div style="width:30%; display:inline-block">
		<form action="selectAll.do">
			<select name="searchKey">
				<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
				<option value="place" <c:if test="${param.searchKey =='place'}"> selected </c:if>>장소</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
			<input type="hidden" name="page" value=1>
			<input type="submit" value="검색">
		</form>
	</div>
	
	<hr>

	<c:forEach var="vo" items="${vos}">
<%-- 		<fmt:parseDate var="dateFmt" value="${vo.wdate}" --%>
<%-- 			pattern="yyyy-MM-dd HH:mm:ss.SSS" /> --%>
<%-- 		<fmt:formadivate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd" /> --%>

		<div onclick="location.href='selectOne.do?partyNum=${vo.partyNum}'"
			style="cursor: pointer">
			<div>${vo.partyNum}</div>
			<div>${vo.applicants}/${vo.max}</div>
			<div>${vo.timeLimit}</div>
			<div>${vo.writerName}</div>
			<div>조회수 : ${vo.views}</div>
		</div>
	</c:forEach>


	<div style="width:45%; display:inline">
		<a href="insert.do">글작성</a>
	</div>
	
	<div>
		<a href="selectAll.do?searchKey=${param.searchKey}&searchWord=${param.searchWord}&page=${param.page-1}" id="pre_page">이전</a>
		<a href="selectAll.do?searchKey=${param.searchKey}&searchWord=${param.searchWord}&page=${param.page+1}" id="next_page">다음</a>
	</div>

	
	<script type="text/javascript">
		if(${param.page}==1){
// 			$('#pre_page').hide();
			$('#pre_page').click(function(){
				return false;
			});
		}
		if((${param.page}*5) >= ${cnt}){
// 			$('#next_page').hide();
			$('#next_page').click(function(){
				return false;
			});
		}
	</script>
	
	
<!-- 		<div> -->
<!-- 			<ul style="list-style:none"> -->
<!-- 				<li> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>제목</span> -->
<!-- 					</div> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>작성자</span> -->
<!-- 					</div> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>작성일</span> -->
<!-- 					</div> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>조회수</span> -->
<!-- 					</div> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
	
</body>
</html>