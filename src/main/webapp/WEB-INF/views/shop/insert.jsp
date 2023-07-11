<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {
	position:relative;
	width:729px;
	height:340px;
	padding-top: 35px;
}
#menu_wrap {
	position:absolute;
	top:0;
	left:0;
	bottom:0;
	width:250px;
	margin:40px 0 30px 10px;
	padding-top:20px;
	overflow-y:auto;
	background:rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size:12px;
	border-radius: 10px;
}
.bg_white {
	background:#fff;
}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
.close-button {
    position: absolute;
    top: 45px;
    right: 57px;
    width: 18px;
    height: 18px;
    font-size: 18px;
    background-color: white;
    text-align: center;
    cursor: pointer;
}
.form-row .tagName {
    /* UI Properties */
	text-align: left;
	width: 80px;
	font: normal normal bold 18px/21px Pretendard;
	letter-spacing: -0.45px;
	margin-right: 108px;
	margin-left: 0;
	color: #323232;
	opacity: 1;
}
.form-row .inputInformation {
	border: 1px solid var(---c7c7c7-표테두리);
	border: 1px solid #C7C7C7;
	display: inline-block;
	width: 433px;
    height: 40px;
    font: normal normal normal 18px/21px Pretendard;
	opacity: 1;
}

.form-row {
	display: flex;
	align-items: center;
	padding-top: 13px;
	padding-bottom: 13px;
	border-top: 1px solid #ccc;
}

.big-form {
	margin: 100px 50px 100px 50px
}

.form-row:last-child {
	border-bottom: 1px solid #ccc;
}

.form-row .tagName {
  display: inline-block;
  width: 80px;
  text-align: right;
  margin-right: 10px;
  vertical-align: middle;
}

.form-row input {
  vertical-align: middle;
}
.searchImage {
	margin-left: 15px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
    function handleItemInfo(itemInfo) {
    	console.log(itemInfo);
        document.getElementById('name').value = itemInfo.placeName;
        document.getElementById('tel').value = itemInfo.phone;
        document.getElementById('keyword').value = itemInfo.address;
        var cateValue = itemInfo.cate.replace(/\s*>\s*/g, ',');
        document.getElementById('cate').value = cateValue;
    }
    
    function closeModal() {
        // Close the modal by sending a message to the parent window
        window.parent.closeModal();
    }
    
    window.addEventListener('message', function(event) {
        if (event.data === 'closeModal') {
            closeModal();
        }
    });
    
    $(document).ready(function() {
        $('#searchForm').submit(function(e) {
            e.preventDefault(); // 폼 제출 동작을 취소합니다
            searchPlaces(); // 장소 검색 함수 호출
        });

        $('#searchImage').click(function(e) {
            e.preventDefault(); // 이미지 클릭 동작을 취소합니다
            $('#searchForm').submit(); // 폼 제출 이벤트를 발생시킵니다
        });
    });
    
    function showImagePreview(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var imagePreview = document.getElementById("imagePreview");
                imagePreview.src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</head>
<body>
	<div class="close-button" onclick="closeModal()">X</div>
		<div class="big-form">
			<div class="form-img">
				<div>
    				<label for="image">Image:</label>
    				<input type="file" name="multipartFile" accept="image/*" onchange="showImagePreview(this)">
				</div>
				<div>
    				<img id="imagePreview" src="#" alt="Image Preview" style="max-width: 200px; max-height: 200px;">
				</div>
			</div>
			<div class="form-date">
			<div class="form-row">
				<div class="tagName">가게명</div>
				<div><input type="text" id="name" name="name" class="inputInformation"></div>
			</div>
			<div class="form-row">
				<div class="tagName">분류</div>
				<div><input type="text" id="cate" name="cate" class="inputInformation"></div>
			</div>
			<div class="form-row">
				<div class="tagName">전화번호</div>
				<div><input type="text" id="tel" name="tel" class="inputInformation"></div>
			</div>
			<form id="searchForm" onsubmit="searchPlaces(); return false;">
				<div class="form-row">
    				<div class="tagName">위치</div>
		    		<div><input type="text" id="keyword" value="맛집" size="15" class="inputInformation"></div>
	    			<div><button type="submit" style="display: none;"></button></div>
    		    	<div><img src="../resources/ArrowSource/search-normal.svg" alt="Search" id="searchImage" class="searchImage"></div>
        		</div>
			</form>
			</div>>
			<div class="map_wrap">
    			<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

	    		<div id="menu_wrap" class="bg_white">
        			<hr>
        			<ul id="placesList"></ul>
        			<div id="pagination"></div>
   				</div>
			</div>
		</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d326b067d6341afa0b918f0c45297208&libraries=services,clusterer"></script>
 <script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            kakao.maps.event.addListener(marker, 'click', function() {
            	window.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
            
            itemEl.onclick =  function () {
            	var selectedPlace = null;
                for (var i = 0; i < places.length; i++) {
                    if (places[i].place_name === title) {
                        selectedPlace = places[i];
                        break;
                    }
                }

                if (selectedPlace) {
                    var itemInfo = {
                        placeName: selectedPlace.place_name,
                        roadAddress: selectedPlace.road_address_name,
                        address: selectedPlace.address_name,
                        phone: selectedPlace.phone,
                        cate: selectedPlace.category_name,
                        locX: selectedPlace.x,
                        locY: selectedPlace.y
                    };
                    handleItemInfo(itemInfo);
                }
            };
            
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>
</body>
</html>