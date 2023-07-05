<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">

	$(function(){
		$('#delButton').click(function(){
			if(confirm("글을 삭제하시겠습니까?")){
				location.href="deleteOK.do?partyNum=${param.partyNum}"
			}
			
		}); // end click
		
	});
	
</script>
</head>
<body>
	<h1>모임정보</h1>

<%-- 		<fmt:parseDate var="dateFmt" value="${vo2.wdate}" --%>
<%-- 			pattern="yyyy-MM-dd HH:mm:ss.SSS" /> --%>
<%-- 		<fmt:formadivate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd" /> --%>


		<div>(status)</div>
		
		<div>${vo2.title}(제목)</div>
		
		<div>
			<img width="100px" src="../resources/ProfileImage/${vo2.writerNum}"
						onerror="this.src='../resources/ProfileImage/default.png'">
			<div>${vo2.writerName}(작성자)</div>
		</div>

		
		<div>
			<div>${vo2.wdate}(작성일)</div>
			<div>조회수 : ${vo2.views}</div>
		</div>
		<div>
			<div>모집인원 : ${vo2.applicants}/${vo2.max} 명</div>
			<div>모집마감일 : ${vo2.deadLine}</div>
			<div>식당 : ${vo2.place}</div>
			<div>모집날짜 : ${vo2.timeLimit}</div>
		</div>
		
		<div>${vo2.content}(내용)</div>
	<div>
		<button type="button"
			onclick="location.href='update.do?partyNum=${param.partyNum}'">수정</button>
		<button type="button" id="delButton">삭제</button>
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