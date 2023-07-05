<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ACwgwtAHlhvRfxyj_W_F"></script>
<script>
    function openSearchLocation() {
        window.open('searchLocation.do', 'test', 'width=1000, height=1000');
    }
</script>
</head>
<body>
	<form action="insertOK.do" method="get">
		<div>
			<div>가게명</div>
			<div><input type="text" id="name" name="name" value="name1"></div>
		</div>
		<div>
			<div>분류</div>
			<div>
			<select name="cate", id="cate">
				<option value="한식">한식</option>
				<option value="중식">중식</option>
				<option value="일식">일식</option>
				<option value="양식">양식</option>
				<option value="카페">카페</option>
				<option value="햄버거">햄버거</option>
				<option value="치킨">치킨</option>
				<option value="피자">피자</option>
			</select>
			</div>
		</div>
		<div>
			<div>전화번호</div>
			<div><input type="text" id="tel" name="tel" value="010-0000-0000"></div>
		</div>
		<div>
			<div>위치</div>
			<div><input type="text" id="loc" name="loc" value="loc"></div>
			<div><input type="button" value="검색" onclick="openSearchLocation()"></div>
		</div>
		<div><input type="submit" class="addBtn"></div>
	</form>
</body>
</html>