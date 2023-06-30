<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/notice/button.css">
</head>
<body>
	<h1>이벤트</h1>

	<table border="1" style="border-collapse: collapse">
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
			
		<tbody>
			<c:forEach var="vo" items="${vos}">
				<fmt:parseDate var="dateFmt" value="${vo.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
				<fmt:formatDate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd" />
				
				<tr onclick="location.href='selectOne.do?num=${vo.num}'" style="cursor:pointer">
					<td>${vo.title}</td>
					<td>${vo.writer}</td>
					<td>${fmtwdate}</td>
					<td>${vo.viewCount}</td>
				</tr>
			</c:forEach>
		</tbody>
		
		<tfoot>
		</tfoot>
	</table>
	
	<div style="width:30%; display:inline-block">
		<form action="selectAll.do">
			<select name="searchKey">
				<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
				<option value="content" <c:if test="${param.searchKey =='content'}"> selected </c:if>>내용</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
			<input type="hidden" name="page" value=1>
			<input type="submit" value="검색">
		</form>
	</div>
	
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