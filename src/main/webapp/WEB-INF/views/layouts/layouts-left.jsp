<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>맛집의 즐거움-HOTPLACE</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/layouts/layouts-tiles2.css">
</head>
<body>
<div class="tilesWrap">
	<div class="tilesHeader">
		<tiles:insertAttribute name="header" />
	</div>
	<div class="tilesMiddleWrap">
		<div class="leftSide">
			<tiles:insertAttribute name="leftSide" />
		</div>
		<div class="tilesContent">
			<tiles:insertAttribute name="content" />
		</div>
	</div>
	<div class="tilesFooter">
		<tiles:insertAttribute name="footer" />
	</div>
</div>
</body>
</html>