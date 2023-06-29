<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>매장등록</h1>
	
	<form action="insertOK.do" method="post">
		<table id="boardList">
			<tr>
				<td><label for="name">name:</label></td>
				<td><input type="text" id="name" name="name" value="name1">
				</td>
			</tr>
			<tr>
				<td><label for="cate">cate:</label></td>
				<td><textarea rows="10" cols="20" name="cate">cate1</textarea></td>
			</tr>
			<tr>
				<td><label for="writer">tel:</label></td>
				<td><input type="text" id="tel" name="tel" value="010-0000-0000"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" class="myButton"></td>
			</tr>
		</table>
	</form>
</body>
</html>