<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectAll</title>

<style type="text/css">
        .large {
            border: 1px solid black;
            padding: 10px;
            margin-bottom: 10px;
        }
    </style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	console.log('onload...');
})

</script>
</head>
<body>
	<h1>매장목록</h1>
	
	<div style="padding:5px">
		<form action="searchList.do">
			<select name="searchKey" id="searchKey">
				<option value="name" ${param.searchKey == 'name' ? 'selected' : ''}>name</option>
				<option value="cate" ${param.searchKey == 'cate' ? 'selected' : ''}>cate</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
			<input type="hidden" name="pageNum" id="pageNum" value=1>
			<input type="submit" value="검색">
		</form>
	</div>


<c:forEach var="vo" items="${vos}">
    <div class="large" onclick="selectOne('${vo.num}')">
        <div><img id="preview" width="100px"
						src="../resources/ShopSymbol/${vo.symbol}""></div>
        <div>
            <div>${vo.name}</div>
            <div>${vo.avgRated}</div>
        </div>
    </div>
</c:forEach>

<script type="text/javascript">
	function selectOne(num) {
		// GET 요청을 통해 selectOne.do로 접근
		window.location.href = "selectOne.do?num=" + num;
	}
</script>

	
	<div>
		<a href="searchList.do?searchKey=${param.searchKey}&searchWord=${param.searchWord}&pageNum=${param.pageNum-1}" id="pre_page">이전</a>
		<a href="searchList.do?searchKey=${param.searchKey}&searchWord=${param.searchWord}&pageNum=${param.pageNum+1}" id="next_page">다음</a>
	</div>
	<script type="text/javascript">
		if(${param.pageNum}==1){
 			$('#pre_page').hide();
		}
		if(${cnt}==0){
			$('#next_page').hide();
		}
</script>
	
</body>
</html>