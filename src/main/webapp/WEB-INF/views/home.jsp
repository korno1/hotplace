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

    <script>
   		var isDragging = false;
   		var startX, scrollLeft;
   		
   		getCurrentAddress();
   		
   		function addShop() {
   		    openModal();
   		}
    
        function slideLeft(index) {
            var container = document.querySelector('.shop'+index+'-items');
            container.scrollLeft -= 800; 
        }

        function slideRight(index) {
            var container = document.querySelector('.shop'+index+'-items');
            container.scrollLeft += 800; 
        }
        function selectOne(num) {
            console.log(num);
            window.location.href = 'shop/selectOne.do?num=' + num + '&srePage=1&parPage=1';
        }

        function startDrag(event, index) {
        	  isDragging = true;
        	  startX = event.clientX;
        	  scrollLeft = document.getElementById('shop' + index + 'Items').scrollLeft;
        	}

        function drag(event, index) {
            if (!isDragging) return;
            var x = event.clientX;
            var walk = (x - startX) * 2; // 슬라이딩 속도 조절을 위해 스칼라 값 조정
            document.getElementById('shop' + index + 'Items').scrollLeft = scrollLeft - walk;
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
                                        updateRecommendedShopItems(); // 현재 주소를 기반으로 목록 업데이트
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
                        updateRecommendedShopItems();
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
        
        function updateRecommendedShopItems() {
            $.ajax({
                type: "GET",
                url: "home/json/getRecommendedShops.do",
                data: {},
                success: function(response) {
                    console.log(response);
                    var shopLists = response; // shopList를 response로 변경
                    var index = 1;
                    
                    // 추천 카테고리별로 상점 목록 구성
                    for (var category in shopLists) {
                    	console.log(index);
                    	console.log(category);
                    	console.log("shop"+index+"Items");
                    	
                    	 var categoryTitle = document.querySelector('.cate' + index);
                         categoryTitle.textContent = category;
                    	
                    	// shop-items 목록 초기화
                        var shopItems = document.getElementById("shop"+index+"Items");
                        shopItems.innerHTML = "";
                        
                        var filteredShops = shopLists[category];

                        // 상점 목록 추가
                        for (var j = 0; j < filteredShops.length; j++) {
                            var shop = filteredShops[j];

                            console.log("shop!")
                            console.log(shop);
                            
                            // 상점 아이템 요소 생성
                            var shopItem = document.createElement("div");
                            shopItem.className = "shop-item";
                            
                         // 보이지 않는 div에 num 값을 저장
                            var numDiv = document.createElement("div");
                            numDiv.style.display = "none"; // 숨김 처리
                            numDiv.textContent = shop.num;
                            shopItem.appendChild(numDiv);
                            
                            shopItem.onclick = function () {
                            	var num = this.querySelector("div").textContent;
                                selectOne(num);
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
                            
                            // partyCount 박스 생성
                            var partyCountBox = document.createElement("div");
                            partyCountBox.className = "partyCountBox";

                            // partyIcon 이미지 추가
                            var partyIcon = document.createElement("img");
                            partyIcon.src = "resources/partyIcon.png";
                            partyIcon.className = "partyIcon";
                            partyCountBox.appendChild(partyIcon);

                            // partyCount 텍스트 추가
                            var partyCountText = document.createElement("div");
                            partyCountText.className = "partyCountText";
                            partyCountText.textContent = shop.partyCount;
                            partyCountBox.appendChild(partyCountText);

                            // shop-item에 partyCountBox 추가
                            shopItem.appendChild(partyCountBox);

                            // shopItems에 shop-item 추가
                            shopItems.appendChild(shopItem);

                            // 상점 정보를 감싸는 부모 요소 생성
                            var shopInfoDiv = document.createElement("div");
                            shopInfoDiv.className = "shopInfo";

                            // 상점 이름 추가
                            var nameDiv = document.createElement("div");
                            nameDiv.textContent = truncateShopTitle(shop.name);
                            nameDiv.className = "shopTitle";
                            shopInfoDiv.appendChild(nameDiv);

                            // 거리 정보 추가
                            if (shop.distance != 0) {
                    			var distanceDiv = document.createElement("div");
                    			distanceDiv.textContent = shop.distance.toFixed(1) + " km";
                    			distanceDiv.className = "shopDistance";
                    			shopInfoDiv.appendChild(distanceDiv);
                			}

                            // shop-item에 이미지와 이름 추가
                            shopItem.appendChild(imageDiv);
                            shopItem.appendChild(shopInfoDiv);

                            // shopItems에 shop-item 추가
                            shopItems.appendChild(shopItem);
                        }
                        index++;
                    }
                },
                error: function(xhr, status) {
                    console.log("Failed to get nearby shops.");
                }
            });
        }
        
        function truncateShopTitle(title) {
            const maxTitleLength = 10;
            if (title.length > maxTitleLength) {
                return title.slice(0, maxTitleLength) + "...";
            }
            return title;
        }
    </script>
</head>
<body>
<div>
    <form action="shop/searchList.do"  class="topForm">
        	<div class="searchForm">
				<input type="text" name="searchWord" id="searchWord" class="searchWord" value="${param.searchWord}">
				<input type="hidden" name="page" id="page" value=1>
				<button type="submit" class="button">
                    <img src="resources/search-normal.svg">
                </button>
			</div>
    </form>
</div>
<div>
    <div class="shopList">
        <div class="shop-container" onmousedown="startDrag(event,1)" onmousemove="drag(event,1)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft(1)">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop1Container">
    			<div class="cate1"></div>
    			<div class="shop1-items" id="shop1Items"></div>
    		</div>
    		<div class="arrow right-arrow" onclick="slideRight(1)">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
		
		<div class="shop-container" onmousedown="startDrag(event,2)" onmousemove="drag(event,2)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft(2)">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop1Container">
    			<div class="cate2"></div>
    			<div class="shop2-items" id="shop2Items"></div>
    		</div>
    		<div class="arrow right-arrow" onclick="slideRight(2)">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
		<div class="shop-container" onmousedown="startDrag(event,3)" onmousemove="drag(event,3)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft(3)">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop1Container">
    			<div class="cate3"></div>
    			<div class="shop3-items" id="shop3Items"></div>
    		</div>
    		<div class="arrow right-arrow" onclick="slideRight(3)">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
		<div class="shop-container" onmousedown="startDrag(event,4)" onmousemove="drag(event,4)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft(4)">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop1Container">
    			<div class="cate4"></div>
    			<div class="shop4-items" id="shop4Items"></div>
    		</div>
    		<div class="arrow right-arrow" onclick="slideRight(4)">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
		<div class="shop-container" onmousedown="startDrag(event,5)" onmousemove="drag(event,5)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft(5)">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop1Container">
    			<div class="cate5"></div>
    			<div class="shop5-items" id="shop5Items"></div>
    		</div>
    		<div class="arrow right-arrow" onclick="slideRight(5)">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
    </div>
    <div class="buttonContainer">
    	<c:if test="${Authority eq 'true'}">
   			<input type="button" value="가게 추가" class="addShopButton" onclick="addShop()">
		</c:if>
    </div>
</div>
</body>
</html>