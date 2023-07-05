<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member/findId.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<body>
	<div class="form-container">
	<h2>비밀번호 찾기</h2>
		<form action="pwAuth.do" method="POST">
			<div class="textbox">
				<input id="name" name="nick_name" required type="text"
					class="input-field" /> <label for="name" class="label">닉네임</label>
			</div>
			<div class="textbox">
				<input id="email" name="email" required type="text"
					class="input-field" /> <label for="email" class="label">이메일</label>
			</div>
			<br> <br> <input type="submit" id="check" value="비밀번호 찾기"
				class="submit-btn">
		</form>
		<%-- 에러 메시지 출력 --%>
		<c:if test="${not empty errorMessage}">
			<script>
				alert("${errorMessage}");
			</script>
		</c:if>
	</div>
</body>
</html>