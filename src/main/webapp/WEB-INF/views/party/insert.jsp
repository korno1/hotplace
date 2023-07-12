<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임글쓰기</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/insert.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
	<h1>모임글쓰기</h1> 

	<form action="insertOK.do" method="post" enctype="multipart/form-data">
		<div>
			<div class="title">
				<input type="text" name="title" id="title" placeholder="제목"
					onfocus="this.placeholder=''" onblur="this.placeholder='제목'">
			</div>
			
			<div class="form-group">
<!-- 				<h3>모임의 기본 정보를 입력해주세요</h3> -->
				<div>
					<label for="max">모집인원</label>
					<select name="max" id="max">
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
				<div>
					<label for="deadLine">모집마감일</label>
					<input type="datetime-local" name="deadLine" id="deadLine">
				</div>
				<div>
					<label for="place">식당</label>
					<input type="text" name="place" id="place">
				</div>
				<div>
					<label for="timeLimit">모임날짜</label>
					<input type="datetime-local" name="timeLimit" id="timeLimit">
				</div>
			</div>

			<div class="form-group">
				<div class="content">모임에 대해 설명해주세요</div>
				<textarea name="content" id="content"></textarea>
			</div>
			<div class="submit-button">
				<input type="submit" value="작성">
			</div>
		</div>
	</form>
</body>
</html>