<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
        .large {
            border: 1px solid black;
            padding: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="large">
	<!-- <div><img width="35px" src="resources/uploading/shop_${vo.save_name}"></div> -->
	<div>
		<div>${shoVO.name}</div>
		<div>cate:${shoVO.cate}</div>
			<div>
				<div>tel:${shoVO.tel}</div>
				<div>rate:${avgRate}</div>
			</div>
		</div>
	<div>
		<div>위치 예정</div>
		<div>지도 예정</div>
	</div>
</div>
<div>
	<div>
		<div>후기</div>
		<a href="insert.do" id="re_insert">후기등록</a>
	</div>
	<c:forEach var="vo" items="${sreVOS}">
		<div class="large">
			<div>그림예정</div>
			<div>
				<div>
					<div>${vo.content}</div>
					<div>${vo.wdate}</div>
				</div>
				<div>
					<div>${vo.rated}</div>
					<div>${vo.writerName}</div>
				</div>
				<div>
                <!-- 수정, 삭제 링크 -->
                <!-- <a href="update.do?num=${vo.num}" id="update">수정</a> -->
                <!-- <a href="delete.do?num=${vo.num}" id="delete">삭제</a> -->
           		</div>
			</div>
		</div>
	</c:forEach>
</div>


<!-- 파티관련
<div>
	<div>관련 모임</div>
	<c:forEach var="vo" items="${partyList}">
		<div>
			<div>
				<div>
					<div>${vo.title}</div>
					<div></div>
				</div>
				<div>
					<div>${vo.rated}</div>
					<div>${vo.writer}</div>
				</div>
		</div>
	</c:forEach>
-->
</body>
</html>