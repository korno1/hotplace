<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Home</title>
<link rel="stylesheet" href="/hotplace/resources/css/home/home.css">
<style>
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d326b067d6341afa0b918f0c45297208&libraries=services,clusterer"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script>
    	var linkElement = document.querySelector('link[href$="home.css"]');
    	var cssPath = linkElement.href;
    	console.log("CSS 파일 경로: " + cssPath);
    
   		var isDragging = false;
   		var startX, scrollLeft;
   		
   		getCurrentAddress();
   		
   		function addShop() {
   		    openModal();
   		}
    
        function slideLeft() {
            var container = document.querySelector('.shop-items');
            container.scrollLeft -= 800; // Adjust the sliding distance as needed
        }

        function slideRight() {
            var container = document.querySelector('.shop-items');
            container.scrollLeft += 800; // Adjust the sliding distance as needed
        }
        function selectOne(num) {
            // Redirect to selectOne.do with the provided num parameter
            window.location.href = 'shop/selectOne.do?num=' + num + '&page=1';
        }

        function startDrag(event) {
            isDragging = true;
            startX = event.clientX;
            scrollLeft = document.getElementById('shopItems').scrollLeft;
        }

        function drag(event) {
            if (!isDragging) return;
            var x = event.clientX;
            var walk = (x - startX) * 2; // 슬라이딩 속도 조절을 위해 스칼라 값 조정
            document.getElementById('shopItems').scrollLeft = scrollLeft - walk;
        }

        function endDrag() {
            isDragging = false;
        }
        
        function openModal() {
            // 모달 요소 생성
            var modal = document.createElement('div');
            modal.className = 'modal';

            // insert.jsp 페이지를 모달에 로드합니다
            modal.innerHTML = '<iframe src="shop/insert.do" frameborder="0" width="100%" height="100%"></iframe>';

            // 모달을 body에 추가합니다
            document.body.appendChild(modal);
        }

        function closeModal() {
            // 모달을 body에서 제거합니다
            var modal = document.querySelector('.modal');
            if (modal) {
                modal.parentNode.removeChild(modal);
            }
        }
        
        function getCurrentAddress() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        var lat = position.coords.latitude;
                        var lng = position.coords.longitude;

                        console.log("현재 위치의 위도: " + lat);
                        console.log("현재 위치의 경도: " + lng);

                        // 좌표를 주소로 변환하는 지오코딩 API 요청
                        var geocoder = new kakao.maps.services.Geocoder();
                        geocoder.coord2Address(lng, lat, function(result, status) {
                            if (status === kakao.maps.services.Status.OK) {
                                var address = result[0].address.address_name;
                                var processedAddress = getAddressWithoutDetailedInfo(address);
                                $("#currentAddress").text(processedAddress);

                                // 현재 주소를 서버로 전송하는 AJAX 요청
                                $.ajax({
                                    type: "POST",
                                    url: "home/json/updateAddress.do",
                                    data: {
                                    	currentAddress: processedAddress,
                                    	latitude: lat,
                                    	longitude: lng
                                    },
                                    success: function(response) {
                                        console.log("현재 주소 업데이트 성공");
                                        updateShopItems(processedAddress); // 현재 주소를 기반으로 목록 업데이트
                                    },
                                    error: function(xhr, status) {
                                        console.log("현재 주소 업데이트 실패");
                                    }
                                });
                            } else {
                                console.log("Failed to get the current address.");
                            }
                        });
                    },
                    function(error) {
                        console.log("Error getting current position: ", error);
                    }
                );
            } else {
                console.log("Geolocation is not supported by this browser.");
            }
        }

        function getAddressWithoutDetailedInfo(address) {
            // 주소를 구분자(공백, 쉼표 등)를 기준으로 분리하여 첫 번째 요소만 사용
            var splitAddress = address.split(" ");
            var processedAddress = splitAddress[0] + " " + splitAddress[1] + " " + splitAddress[2] + " " + splitAddress[3];
            return processedAddress;
        }
        
        function handleImageError(image) {
        	image.src = 'resources/ShopSymbol/default.png';
        }
        
        function updateShopItems(currentAddress) {
            // 현재 주소를 기반으로 20km 이내의 정보만 가져와서 목록 업데이트
            $.ajax({
                type: "GET",
                url: "home/json/getNearbyShops.do",
                data: {},
                success: function(response) {
                    console.log(response);
                    var shopList = response; // shopList를 response로 변경

                    // shop-items 목록 초기화
                    var shopItems = document.getElementById("shopItems");
                    shopItems.innerHTML = "";

                    // shopList를 순회하며 목록 추가
                    for (var i = 0; i < shopList.length; i++) {
					    var shop = shopList[i];

					    // shop-item 요소 생성
					    var shopItem = document.createElement("div");
					    shopItem.className = "shop-item";
					    shopItem.onclick = function() {
					        selectOne(shop.num);
						};

					    // 이미지 요소 추가
					    var imageDiv = document.createElement("div");
						var image = document.createElement("img");
					    image.id = "symbol";
						imageDiv.className = "symbolImageContainer";
    
					    image.onerror = function() {
    	    				handleImageError(this);
    					};
    
    					image.src = "resources/ShopSymbol/" + shop.num + ".png";
					    image.draggable = false;
					    image.className = "symbolImage";
					    imageDiv.appendChild(image);

						// 상점 정보를 감싸는 부모 요소 생성
					    var shopInfoDiv = document.createElement("div");
						shopInfoDiv.className = "shopInfo";
					    
					    // 상점 이름 추가
    					var nameDiv = document.createElement("div");
					    nameDiv.textContent = shop.name;
					    nameDiv.className = "shopTitle";
					    shopInfoDiv.appendChild(nameDiv);
					    
						 // 거리 정보 추가
						var distanceDiv = document.createElement("div");
						distanceDiv.textContent = shop.distance.toFixed(1) + " km";
					    distanceDiv.className = "shopDistance";
					    shopInfoDiv.appendChild(distanceDiv);

						// shop-item에 이미지와 이름 추가
    					shopItem.appendChild(imageDiv);
    					shopItem.appendChild(shopInfoDiv);

					    // shopItems에 shop-item 추가
    					shopItems.appendChild(shopItem);
					}
                },
                error: function(xhr, status) {
                    console.log("Failed to get nearby shops.");
                }
            });
        }
    </script>
</head>
<body>
<div>
    <form action="shop/searchList.do">
        <input type="text" name="searchWord" id="searchWord">
        <input type="hidden" name="page" id="page" value="1">
        <input type="submit" value="검색">
    </form>
    <div id="addressContainer">
    		<h2>현재 주소</h2>
    		<p id="currentAddress"></p>
	</div>
</div>
<div>
    <div>
        <div>집 주변에 이런게 있어요</div>
        <div class="shop-container" onmousedown="startDrag(event)" onmousemove="drag(event)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft()">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop-items" id="shopItems"></div>
    		<div class="arrow right-arrow" onclick="slideRight()">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
    </div>
    <div>
    	<c:if test="${Authority eq 'true'}">
   			<input type="button" value="가게 추가" class="addShopButton" onclick="addShop()">
		</c:if>
    </div>
</div>
</body>
</html>