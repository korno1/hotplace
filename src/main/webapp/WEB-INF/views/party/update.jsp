<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임수정</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/update.css?after" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<form action="updateOK.do" method="post" enctype="multipart/form-data">
		<div class="body">
			<input type="hidden" name="partyNum" value="${param.partyNum}">
			
			<div class="par-title">
				<input type="text" name="title" id="title" value="${vo2.title}">
			</div>
			
			<div class="writerImpo">
				<div>
					<img width="60px" src="../resources/ProfileImage/${vo2.writerNum}" onerror="this.src='../resources/ProfileImage/default.png'">
				</div>
				<div class="par-name">
					<a href="/hotplace/userpage.do?num=${vo2.writerNum}">${vo2.writerName}</a>
				</div>
				<div>
					<div class="par-views">${vo2.views}</div>
					<div class="par-wdate">${vo2.wdate}</div>
				</div>
			</div>
			
			<div class="par-row">
				<div class="par-cell">모집인원</div>
				<select name="max" id="max" class="par-date">
							<option hidden="" value="${vo2.max}" selected>${vo2.max}명</option>
							<option value="1">1명</option>
							<option value="2">2명</option>
							<option value="3">3명</option>
							<option value="4">4명</option>
							<option value="5">5명</option>
							<option value="6">6명</option>
							<option value="7">7명</option>
							<option value="8">8명</option>
							<option value="9">9명</option>
							<option value="10">10명</option>
				</select>
			</div>
			<div class="par-row">
				<div class="par-cell">모집마감일</div>
				<input class="par-date" type="datetime-local" name="deadLine" id="deadLine" value="${vo2.deadLine}">
			</div>
			<div class="par-row">
				<div class="par-cell">식당</div>
				<input class="par-date" type="text" name="place" id="place" value="${vo2.place}">
			</div>
			<div class="par-row">
				<div class="par-cell">모임날짜</div>
				<input class="par-date" type="datetime-local" name="timeLimit" id="timeLimit" value="${vo2.timeLimit}">
			</div>
			
			<div class="par-content">
				<textarea class="textarea" name="content" id="content">${vo2.content}</textarea>
			</div>
			<div>
				<input class="updateOK-bt" type="submit" value="글수정"> 
			</div>
		</div>
	</form>
</body>
</html>