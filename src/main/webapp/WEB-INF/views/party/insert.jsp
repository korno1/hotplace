<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임글쓰기</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/insert.css?after" >
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<div class="title">모임글쓰기</div>
	<form action="insertOK.do" method="post" enctype="multipart/form-data">
		<div class="body">
			<input type="hidden" name="writerNum" id="writerNum" value="${num}">
			<div class="par-title">
				<input type="text" name="title" id="title" placeholder="제목" required
					onfocus="this.placeholder=''" onblur="this.placeholder='제목'">
			</div>
			<div class="form-group">
				<div class="par-row">
					<div class="par-cell">
						<label for="max">모집인원</label>
					</div>
					<div class="par-cell">
						<select name="max" id="max" class="par-date" required>
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
				</div>
				<div class="par-row">
					<div class="par-cell">
						<label for="deadLine">모집마감일</label>
					</div>
					<div class="par-cell">
						<input class="par-date" type="datetime-local" name="deadLine"
							id="deadLine" required>
					</div>
				</div>
				<div class="par-row">
					<div class="par-cell">
						<label for="place">식당</label>
					</div>
					<div class="par-cell">
						<input class="par-date" type="text" name="place" id="place" required>
					</div>
				</div>
				<div class="par-row">
					<div class="par-cell">
						<label for="timeLimit">모임날짜</label>
					</div>
					<div class="par-cell">
						<input class="par-date" type="datetime-local" name="timeLimit"
							id="timeLimit" required>
					</div>
				</div>
			</div>
			<div class="content">
				<div class="content-title">모임에 대해 설명해주세요</div>
				<textarea class="textarea" name="content" id="content" required></textarea>
			</div>
			<div>
				<input class="insertOK-bt" type="submit" value="글등록" required>
			</div>
		</div>
	</form>
</body>
</html>