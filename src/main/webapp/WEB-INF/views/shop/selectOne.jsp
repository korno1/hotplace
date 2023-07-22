<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/shop/selectOne.css">
<style>
    
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

	
<script>

	var linkElement = document.querySelector('link[href$="selectOne.css"]');
	var cssPath = linkElement.href;
	console.log("CSS 파일 경로: " + cssPath);

	function Paginate(srePage, parPage) {
		window.location.href = "selectOne.do?num=${shoVO.num}&srePage=" + srePage + "&parPage=" + parPage;
	}
	//모달 열기
	function openModal() {
		document.getElementById("modal").style.display = "block";
	}

	// 모달 닫기
	function closeModal() {
	    document.getElementById("modal").style.display = "none";
	}
	
	function openReviewInsertForm(shopNum, writerName) {
    	// 사용자 nickname 가져오기
	    var nickName = '<%= session.getAttribute("nick_name") %>';
		
	    if (writerName == null) {
	        alert("로그인이 필요합니다.");
	        return;
	    }
	    
	    // 모달 열기
	    openModal();
	    
	    // iframe에 update.jsp 로드하기
	    var iframe = document.getElementById("modal-iframe");
	    iframe.src = "review/insert.do?nickName=" + nickName + "&shopNum=" + shopNum;
	}
	
	function openReviewUpdateForm(num, shopNum, writerName) {
    	// 사용자 nickname 가져오기
	    var nickName = '<%= session.getAttribute("nick_name") %>';
		
	    if (writerName !== nickName) {
	        alert("작성자가 아닙니다.");
	        return;
	    }
	    
	    // 모달 열기
	    openModal();
	    
	    // iframe에 update.jsp 로드하기
	    var iframe = document.getElementById("modal-iframe");
	    iframe.src = "review/update.do?nickName=" + nickName + "&shopNum=" + shopNum + "&num=" + num;
	}

    function deleteReview(num, shopNum, writerName) {
    	 var nickName = '<%= session.getAttribute("nick_name") %>';
    	 
    	 if (writerName !== nickName) {
 	        alert("작성자가 아닙니다.");
 	        return;
 	    }
 	    
 	   var confirmation = confirm("정말로 삭제하시겠습니까?");
 	    
 	    if (confirmation) {
 	        $.ajax({
 	            url: "review/json/delete.do",
 	            type: "POST",
 	            data: {
 	            	num: num,
 	            	shopNum: shopNum
 	            	
 	            },
 	            success: function(response) {
 	                alert("리뷰가 삭제되었습니다.");
 	                // 삭제 성공 시
 	                window.location.reload();
 	            },
 	            error: function(xhr, status, error) {
 	                // 삭제 실패 시
 	                alert("삭제에 실패했습니다. 다시 시도해주세요.");
 	            }
 	        });
 	    }
    }
</script>

<body>
<div class="page">
<div class="upperForm">
	<div><img width="420px" height="420px" class="img" src="../resources/ShopSymbol/${shoVO.num}.png" onerror="src='../resources/ShopReviewImage/default.png'"></div>
	<div class="informForm">
		<div class="title">${shoVO.name}</div>
		<div class="inform">${shoVO.cate}</div>
		<div class="inform">${shoVO.tel}</div>
		<div class="rate">
    		<span class="star-rating" data-rated="${shoVO.rate}">
        		<span class="star ${(shoVO.rate >= 1) ? 'selected' : ''}">&#9733;</span>
        		<span class="star ${(shoVO.rate >= 2) ? 'selected' : ''}">&#9733;</span>
        		<span class="star ${(shoVO.rate >= 3) ? 'selected' : ''}">&#9733;</span>
        		<span class="star ${(shoVO.rate >= 4) ? 'selected' : ''}">&#9733;</span>
        		<span class="star ${(shoVO.rate >= 5) ? 'selected' : ''}">&#9733;</span>
    		</span>
		</div>
		<div class="inform">${shoVO.address}</div>
	</div>
		
</div>
<div id="map" class="map"></div>
<div class="reviewForm">
	<div class="reviewTitle">
		<div class="mainTitle">후기</div>
    	<c:if test="${not empty sessionScope.nick_name}">
        	<!-- 로그인된 경우 -->
        	<div class="reviewButtonContainer">
        		<input type="button" value="후기등록" class="reviewButton" onclick="openReviewInsertForm(${shoVO.num}, '${sessionScope.nick_name}')">
        	</div>
    	</c:if>
	</div>
    <c:forEach var="vo" items="${sreVOS}">
        <div class="reviewContentForm">
            <div class="imageContainer"><img id="symbol" class="symbol" src="../resources/ShopReviewImage/${vo.num}.png" onerror="this.src='../resources/ShopReviewImage/default.png';"></div>
            <div class="writerForm">
            	<div class="writerInform">
                	<img id="profile" width="70px" height="70px" src="../resources/ProfileImage/${vo.writer}.png" onerror="src='../resources/ProfileImage/default.png'">
    	            <div class="writerReview">
        	            <div class="writerName">
        	            	<c:choose>
                            	<c:when test="${vo.anonymous eq 1 && vo.writerName ne sessionScope.nick_name}">비공개</c:when>
                            	<c:otherwise>${vo.writerName}</c:otherwise>
                        	</c:choose>
        	            </div>
            	        <div class="writerRate">
                			<c:if test="${vo.rated == 0}">
                    			평가없음
                			</c:if>
			                <c:if test="${vo.rated > 0}">
            			        <div class="star-rating" data-rated="${vo.rated}">
                        			<c:forEach var="i" begin="1" end="5">
                            			<c:choose>
			                                <c:when test="${i <= vo.rated}">
            			                        <span class="star selected" data-value="${i}">&#9733;</span>
                        			        </c:when>
		                	                <c:otherwise>
        		        	                    <span class="star" data-value="${i}">&#9733;</span>
                			                </c:otherwise>
                        			    </c:choose>
		                        	</c:forEach>
        			            </div>
			                </c:if>
            			</div>
                	</div>
                </div>
            	<div class="writeContent">${vo.content}</div>     
            </div>
            <div class="rightContainer">
            	<div class="writeDate"><fmt:formatDate value="${vo.wdate}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
            	<div class="buttonList">
                	<input type="button" value="수정" class="update" onclick="openReviewUpdateForm(${vo.num}, ${shoVO.num}, '${vo.writerName}')">
                	<input type="button" value="삭제" class="delete"  onclick="deleteReview(${vo.num}, ${vo.shopNum}, '${vo.writerName}')">
                </div>
            </div>
        </div>
    </c:forEach>
	
	
	<!-- 페이징 -->
	<div class="pagination">
    	<c:choose>
        	<c:when test="${srePage > 1}">
        	    <button class="pagination-button" onclick="Paginate(${srePage - 1}, ${parPage})">이전</button>
    	    </c:when>
	    </c:choose>

    	<c:choose>
        	<c:when test="${srePage < totalSrePages}">
        	    <button class="pagination-button" onclick="Paginate(${srePage + 1}, ${parPage})">다음</button>
        	</c:when>
    	</c:choose>
	</div>
	
	<c:forEach var="vo" items="${prtVOS}">
        
    </c:forEach>
</div>
<div class="partyForm">
	<div class="partyCollection">관련 모임</div>
	<c:forEach var="vo" items="${parVOS}">
		<div class="partyItem">
			<div class="partyLeft">
				<div class="partyTitle">${vo.title}</div>
				<div class="partyMaster">${vo.writerName}</div>
			</div>
			<div Class="partyRight">
				<div class="partyRemain">${vo.applicants + 1} / ${vo.max + 1}</div>
                <div class="partyDate">
                    <fmt:parseDate value="${vo.deadLine}" pattern="yyyy-MM-dd HH:mm:ss.S" var="deadlineDate" />
                    <fmt:formatDate value="${deadlineDate}" pattern="yyyy년 MM월 dd일" />
                </div>
			</div>
		</div>
	</c:forEach>
	<div class="pagination">
    	<c:choose>
        	<c:when test="${parPage > 1}">
        	    <button class="pagination-button" onclick="Paginate(${srePage}, ${parPage - 1})">이전</button>
    	    </c:when>
	    </c:choose>

    	<c:choose>
        	<c:when test="${parPage < totalParPages}">
        	    <button class="pagination-button" onclick="Paginate(${srePage}, ${parPage + 1})">다음</button>
        	</c:when>
    	</c:choose>
	</div>
</div>

<!-- 모달 창 -->
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <iframe id="modal-iframe" src="review/insert.do?nickName=<%= session.getAttribute("nick_name") %>&shopNum=${shoVO.num}" width="100%" height="100%"></iframe>
    </div>
</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d326b067d6341afa0b918f0c45297208&libraries=services,clusterer"></script>
<script>

const latitude = ${shoVO.loc_x};
const longitude = ${shoVO.loc_y};

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(longitude, latitude), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(longitude, latitude); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>

</body>
</html>