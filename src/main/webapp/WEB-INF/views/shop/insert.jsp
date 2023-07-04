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
		<div id="map"></div>
		<script>
        var mapOptions = {
            center: new naver.maps.LatLng(37.5665, 126.9780), // 지도의 중심 좌표 (서울시 좌표)
            zoom: 12, // 지도의 확대 레벨
            zoomControl: true, // 줌 컨트롤 표시 여부
            zoomControlOptions: {
                style: naver.maps.ZoomControlStyle.SMALL, // 줌 컨트롤 스타일 (SMALL, LARGE)
                position: naver.maps.Position.TOP_RIGHT // 줌 컨트롤 위치 (TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT)
            },
            mapTypeId: naver.maps.MapTypeId.NORMAL // 지도 타입 (NORMAL, TERRAIN, SATELLITE, HYBRID)
        };

        var map = new naver.maps.Map('map', mapOptions); // map 요소와 옵션을 사용하여 지도 객체 생성
    </script>
		<div><input type="submit" class="addBtn"></div>
	</form>
</body>
</html>