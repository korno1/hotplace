<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectAll</title>
</head>
<body>
	<h1>매장목록</h1>
	
	<div style="padding:5px">
		<form action="searchList.do">
			<select name="searchKey" id="searchKey">
				<option value="title">name</option>
				<option value="content">cate</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" value="tit">
			<input type="submit" value="검색">
		</form>
	</div>

	<table id="boardList">
	<thead>
		<tr>
			<th>num</th>
			<th>name</th>
			<th>cate</th>
			<th>tel</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td><a href="b_selectOne.do?num=${vo.num}">${vo.num}</a></td>
				<td>${vo.name}</td>
				<td>${vo.cate}</td>
				<td>${vo.tel}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="6">1 2 3 4 5</td>
		</tr>
	</tfoot>
	</table>
</body>
</html>