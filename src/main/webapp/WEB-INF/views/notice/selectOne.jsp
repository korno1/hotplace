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
	
	// update.jsp로 이동
	function updateForm(num){
		var form = document.createElement("form");
	    form.setAttribute("method", "post");
	    form.setAttribute("action", "update.do");

	    var numInput = document.createElement("input");
	    numInput.setAttribute("type", "hidden");
	    numInput.setAttribute("name", "num");
	    numInput.setAttribute("value", num);

	    form.appendChild(numInput);

	    document.body.appendChild(form);
	    form.submit();
	}
	
	
</script>
</head>
<body>
	<div class="notice_h1_list">
		<h1>공지사항</h1>
		<button class="not_button" onclick="location.href='selectAll.do'">목록</button>
	</div>
	<div class="not_body">
		<fmt:parseDate var="dateFmt" value="${vo2.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
		<fmt:formatDate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd HH:mm" />
		<div class="not_title_info">
			<div class="not_title_one">
				${vo2.title}
			</div>
			<div class="not_info_one">
				<span class="not_one_writer">${vo2.writer}</span>
				<span>${fmtwdate}</span>
				<span class="not_one_vcount">조회 ${vo2.viewCount}</span>
			</div>
		</div>
			
		<div class="not_content_img">
			<div class="not_content_div">
				${vo2.content}
			</div>
			
			<c:if test="${vo2.saveName != null}">
			<div class="not_img_div">
				<img src="../resources/PostImage/${vo2.saveName}" class="not_img">
			</div>
			</c:if>
		</div>
		
		
		<div class="up_del_button">
			<div>
				<button type="button" class="not_grade_button" onclick="updateForm(${vo2.num})">수정</button>
				<button type="button" class="not_grade_button" id="delButton">삭제</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	if(${grade}==1){
		$('.not_grade_button').css("display", "inline-block");
	}
	</script>
	
</body>
</html>