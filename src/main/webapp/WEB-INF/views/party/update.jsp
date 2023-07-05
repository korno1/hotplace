<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임수정</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<h1>모임수정</h1>

	<form action="updateOK.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="partyNum" value="${param.partyNum}">
		<div>
			<div style="width: 100%;">
				<input type="text" name="title" id="title" placeholder="제목"
					onfocus="this.placeholder=''" onblur="this.placeholder='제목'"
					style="border: 0 solid black; outline: none; width: 100%;" value="${vo2.title}">
			</div>
			<hr>
			<div>
				<h3>모임의 기본 정보를 입력해주세요</h3>
				<div>모집인원 <input type="text" name="max" id="max" value="${vo2.max}"></div>
				<div>모집마감일 <input type="datetime-local" name="deadLine" id="deadLine" value="${vo2.deadLine}"></div>
				<div>식당 <input type="text" name="place" id="place" value="${vo2.place}"></div>
				<div>모임날짜 <input type="datetime-local" name="timeLimit" id="timeLimit" value="${vo2.timeLimit}"></div>
			</div>
			<hr>

			<div>
				<h3>모임에 대해 설명해주세요</h3>
				<textarea name="content" id="content" style="resize: none; width: 100%; height: 300px;">${vo2.content}</textarea>
			</div>
			<div>
				<input type="submit" value="글수정"> 
			</div>
		</div>
	</form>
</body>
</html>