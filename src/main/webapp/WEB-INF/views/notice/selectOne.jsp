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
<link rel="stylesheet" href="../resources/css/notice/button.css">
<link rel="stylesheet" href="../resources/css/notice/post.css">
<style type="text/css">
	#contentArea p{
		margin: 0;
	}
</style>
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
	
	<div class="not_body">
		<fmt:parseDate var="dateFmt" value="${vo2.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
		<fmt:formatDate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd HH:mm" />
		<div class="not_title_info">
			<div class="not_title_one">
				${vo2.title}
			</div>
			<div class="not_info_one">
				<span>${vo2.writer}</span>
				<span>${fmtwdate}</span>
				<span>조회 ${vo2.viewCount}</span>
			</div>
		</div>
			
		<div class="not_content_img">
			<div>
				${vo2.content}
			</div>
			
			<c:if test="${vo2.saveName != null}">
			<div>
				<img src="../resources/PostImage/${vo2.saveName}">
			</div>
			</c:if>
		</div>
		
		
		<div class="up_del_button">
			<div>
				<button type="button" onclick="location.href='update.do?num=${param.num}'">수정</button>
				<button type="button" id="delButton">삭제</button>
			</div>
		</div>
	</div>
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