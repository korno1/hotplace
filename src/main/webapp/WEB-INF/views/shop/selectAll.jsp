<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectAll</title>

<link rel="stylesheet" href="../resources/css/shop/selectAll.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d326b067d6341afa0b918f0c45297208&libraries=services,clusterer"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript">
    function selectOne(num) {
    	
        // GET 요청을 통해 selectOne.do로 접근
        window.location.href = "selectOne.do?num=" + num + "&srePage=1&parPage=1";
    }
    
    $(function() {
        console.log('onload...');
        
        getCurrentAddress();

        var page = 1; // 초기 페이지 번호

        // 페이지 로드 시 매장 목록을 가져와 화면에 표시
        searchList();

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
        
        function searchList() {
            console.log('searchList()...');
            $.ajax({
                url: "json/selectAll.do",
                data: {
                    searchWord: $("#searchWord").val(),
                    pageNum: page
                },
                method: 'GET',
                dataType: "json",
                success: function(data) {
                    updateShopList(data.vos);
                    updatePageNavigation(data.isLast);
                },
                error: function(xhr, status, error) {
                    console.log("Error: " + error);
                }
            });
        }

        function updateShopList(vos) {
            var shopList = $("#shopList");
            shopList.empty(); // 기존 데이터 삭제

            // 새로운 데이터로 화면 업데이트
            $.each(vos, function(index, vo) {
                var listItem = $('<div class="large" onclick="selectOne(' +
                    vo.num +
                    ')"></div>');
                listItem.append(
                    '<div><img id="preview" width="100px" src="../resources/ShopSymbol/' +
                    vo.num + '" onerror="this.src=\'../resources/ShopSymbol/default.png\';"></div>'
                );
                var rateHtml = vo.rate === 0 ? '평가없음' : getStarRatingHtml(vo.rate);
                listItem.append(
                    '<div><div>' +
                    vo.name +
                    '</div><div>' +
                    rateHtml +
                    '</div></div>'
                );

                shopList.append(listItem);
            });
        }
        
     	// 별점을 만들어주는 함수
        function getStarRatingHtml(rating) {
            var fullStarCount = Math.floor(rating);
            var emptyStarCount = 5 - Math.ceil(rating);

            var starHtml = '';
            for (var i = 0; i < fullStarCount; i++) {
                starHtml += '<span class="yellowStar">&#9733;</span>';
            }
            for (var j = 0; j < emptyStarCount; j++) {
                starHtml += '<span class="grayStar">&#9734;</span>';
            }

            return starHtml;
        }
        

        function updatePageNavigation(isLast) {
            var prePageLink = $("#pre_page");
            var nextPageLink = $("#next_page");

            // 이전 페이지 링크 표시 여부 설정
            if (page > 1) {
                prePageLink.attr("href", "#");
                prePageLink.show();
            } else {
                prePageLink.hide();
            }

            // 다음 페이지 링크 표시 여부 설정
            if (!isLast) {
                nextPageLink.attr("href", "#");
                nextPageLink.show();
            } else {
                nextPageLink.hide();
            }
        }
        
        $(document).ready(function() {
            // 이미지를 클릭하면 폼 제출 이벤트를 발생시킴
            $(".button").on("click", function() {
                $("#searchForm").submit();
            });
        });
        
        $("input[type='submit']").on("click", function(e) {
            e.preventDefault(); // 기본 동작(폼 제출) 방지
            page = 1; // 페이지 번호 초기화
            searchList(); // 새로운 페이지 데이터 가져오기
        });

        // 이전 버튼 클릭 이벤트 처리
        $("#pre_page").on("click", function(e) {
            e.preventDefault(); // 기본 동작(링크 이동) 방지
            page--; // page 값을 감소시킴
            searchList(); // 새로운 페이지 데이터 가져오기
        });

        // 다음 버튼 클릭 이벤트 처리
        $("#next_page").on("click", function(e) {
            e.preventDefault(); // 기본 동작(링크 이동) 방지
            page++; // page 값을 증가시킴
            searchList(); // 새로운 페이지 데이터 가져오기
        });
    });
</script>
</head>
<body>
	<div style="padding:5px">
		<form action="selectAll.do">
			<div class="searchForm">
				<input type="text" name="searchWord" id="searchWord" class="searchWord" value="${param.searchWord}">
				<input type="hidden" name="pageNum" id="pageNum" value=1>
				<button type="submit" class="button">
                    <img src="../resources/search-normal.svg">
                </button>
			</div>
		</form>
	</div>
<div id="addressContainer">
	<h2>현재 주소</h2>
	<p id="currentAddress"></p>
</div>

<div id="shopList">
        <!-- 동적으로 생성될 매장 목록 -->
</div>
<div>
	<a href="" id="pre_page">이전</a>
	<a href="" id="next_page">다음</a>
</div>
	
</body>
</html>