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
    function handleItemInfo(itemInfo) {
        // 부모 페이지에서 아이템 정보를 처리하는 로직을 작성합니다.
        console.log(itemInfo);
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
			<div>
        	    <label><input type="checkbox" name="cate" value="패스트푸드"> 패스트푸드</label>
	            <label><input type="checkbox" name="cate" value="피자"> 피자</label>
    	        <label><input type="checkbox" name="cate" value="분식"> 분식</label>
        	    <label><input type="checkbox" name="cate" value="디저트"> 디저트</label>
            	<label><input type="checkbox" name="cate" value="술집"> 술집</label>
        	</div>
        	<div>
	            <label><input type="checkbox" name="cate" value="해산물"> 해산물</label>
    	        <label><input type="checkbox" name="cate" value="샌드위치"> 샌드위치</label>
        	    <label><input type="checkbox" name="cate" value="샐러드"> 샐러드</label>
            	<label><input type="checkbox" name="cate" value="스테이크"> 스테이크</label>
	            <label><input type="checkbox" name="cate" value="베이커리"> 베이커리</label>
        	</div>
        	<div>
    	        <label><input type="checkbox" name="cate" value="햄버거"> 햄버거</label>
        	    <label><input type="checkbox" name="cate" value="국밥"> 국밥</label>
            	<label><input type="checkbox" name="cate" value="카레"> 카레</label>
		    	<label><input type="checkbox" name="cate" value="스시"> 스시</label>
			    <label><input type="checkbox" name="cate" value="디저트"> 디저트</label>
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