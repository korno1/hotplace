<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">

	$(function(){
		
		$('#delButton').click(function(){
			if(confirm("글을 삭제하시겠습니까?")){
				location.href="deleteOK.do?num=${param.num}"
			}
			
		}); // end click
		
	});
	
</script>
</head>
<body>
	<h1>공지사항</h1>
<%-- 	<jsp:include page="../top_menujm.jsp"></jsp:include> --%>

	
	
	<table border="1" style="border-collapse: collapse">
		<fmt:parseDate var="dateFmt" value="${vo2.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
		<fmt:formatDate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd HH:mm" />
		<thead>
			<tr>
				<td colspan="3">${vo2.title}</td>
			</tr>
			<tr>
				<td>${vo2.writer}</td>
				<td>${fmtwdate}</td>
				<td>조회 ${vo2.viewCount}</td>
			</tr>
		</thead>
			
		<tbody>
			<tr>
				<td colspan="3">${vo2.content}</td>
			</tr>
		</tbody>
		
		<tfoot>
			<tr>
				<td colspan="3">
					<button type="button" onclick="location.href='update.do?num=${param.num}'">수정</button>
					<button type="button" id="delButton">삭제</button>
				</td>
			</tr>
		</tfoot>
	</table>
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