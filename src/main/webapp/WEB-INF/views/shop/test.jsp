<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 결과 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d326b067d6341afa0b918f0c45297208&libraries=services,clusterer"></script>
<style>
    ul {
        list-style: none;
        padding: 0;
    }
    
   li {
    margin-bottom: 10px;
}

.item {
    display: flex;
    align-items: center;
}

.item img {
    width: 50px;
    height: 50px;
    margin-right: 10px;
}
</style>
</head>
<body>
    <div>
        <form onsubmit="searchPlaces(); return false;">
            키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
            <button type="submit">검색</button> 
        </form>
    </div>
    <div id="currentAddress">주소</div>
    <ul id="placesList"></ul>

    <script>
    var ps = new kakao.maps.services.Places();  

    function searchPlaces() {
        var keyword = document.getElementById('keyword').value;

        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
        }

        ps.keywordSearch(keyword, placesSearchCB); 
    }

    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            var placesList = document.getElementById('placesList');
            placesList.innerHTML = ''; // 기존 목록 초기화

            for (var i = 0; i < data.length; i++) {
                createPlaceItem(data[i], placesList);
            }
        }
    }

    function createPlaceItem(place, placesList) {
        var item = document.createElement('li');
        item.className = 'item';

        var img = document.createElement('img');
        img.src = place.place_url + '?thumbnail=true';
        item.appendChild(img);

        var name = document.createElement('span');
        name.innerText = place.place_name;
        item.appendChild(name);

        var address = document.createElement('span');
        address.innerText = place.address_name;
        item.appendChild(address);

        var distance = document.createElement('span');
        distance.innerText = '거리: 로딩 중...';
        item.appendChild(distance);

        placesList.appendChild(item);

        // 주소 검색 및 거리 계산
        searchAddress(place.y, place.x, distance); // 주소 검색 및 거리 계산 함수 호출
    }
    
    function searchAddress(lat, lng, distanceElement) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var currentLat = position.coords.latitude;
                var currentLng = position.coords.longitude;

                // 현재 위치와 목적지의 거리 계산
                var distance = getDistance(currentLat, currentLng, lat, lng);

                // 거리 정보 출력
                distanceElement.innerText = '거리: ' + distance.toFixed(2) + 'km';
            }, function(error) {
                console.log(error);
            });
        } else {
            console.log('Geolocation is not supported by this browser.');
        }
    }

    // 두 지점 사이의 거리 계산 함수
    function getDistance(lat1, lng1, lat2, lng2) {
        var latDiff = deg2rad(lat2 - lat1);
        var lngDiff = deg2rad(lng2 - lng1);
        var a =
            Math.sin(latDiff / 2) * Math.sin(latDiff / 2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
            Math.sin(lngDiff / 2) * Math.sin(lngDiff / 2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        var distance = 6371 * c; // 지구 반경 (단위: km)
        return distance;
    }

    // 각도를 라디안으로 변환하는 함수
    function deg2rad(deg) {
        return deg * (Math.PI / 180);
    }
    
    </script>
</body>
</html>