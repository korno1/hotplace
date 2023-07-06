<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
	function openReviewInsertForm() {
	  // 사용자 nickname 가져오기
	  var nickName = '<%= session.getAttribute("nick_name") %>';

	  // shoVO의 num 값 가져오기
	  var num = '${shoVO.num}';
	  
	  if (nickName) {
	        // 새 창 열기
	        window.open('review/insert.do?nickName=' + nickName + '&shopNum=' + num, 'test', 'width=1000, height=1000');
	    } else {
	        // 로그인되지 않은 경우 처리 (예: 경고 메시지 표시)
	        alert("로그인이 필요합니다.");
	    }
	}
	
	function openReviewUpdateForm(num, content, rated) {
    	// 사용자 nickname 가져오기
	    var nickName = '<%= session.getAttribute("nick_name") %>';

	    // 새 창 열기
    	window.open('review/update.do?nickName=' + nickName + '&num=' + num, 'test', 'width=1000, height=1000');
	}
	
	function confirmDelete(num) {
        var confirmation = confirm("정말로 삭제하시겠습니까?");

        if (confirmation) {
            deleteReview(num);
        }
    }

    function deleteReview(num) {
        $.ajax({
            url: "review/json/delete.do",
            type: "POST",
            data: { num: num },
            success: function(response) {
                // 삭제 성공 시
                window.location.reload();
            },
            error: function(xhr, status, error) {
                // 삭제 실패 시
                alert("삭제에 실패했습니다. 다시 시도해주세요.");
            }
        });
    }
</script>

<style type="text/css">
        .large {
            border: 1px solid black;
            padding: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="large">
	<!-- <div><img width="35px" src="resources/uploading/shop_${vo.save_name}"></div> -->
	<div>
		<div>${shoVO.name}</div>
		<div>cate:${shoVO.cate}</div>
			<div>
				<div>tel:${shoVO.tel}</div>
				<div>rate:${avgRate}</div>
			</div>
		</div>
	<div>
		<div>위치 예정</div>
		<div>지도 예정</div>
	</div>
</div>
<div>
	<div>
		<div>후기</div>
    	<c:if test="${not empty sessionScope.nick_name}">
        	<!-- 로그인된 경우 -->
        	<div><input type="button" value="후기작성" onclick="openReviewInsertForm()"></div>
    	</c:if>
	</div>
	<c:forEach var="vo" items="${sreVOS}">
		<div class="large">
			<div><img id="reviewImg" src="../resources/ShopReviewImage/${vo.saveName}"></div>
			<div>
				<div>
					<div>${vo.content}</div>
					<div>${vo.wdate}</div>
				</div>
				<div>
					<div>${vo.rated}</div>
					<div>
                    	<c:choose>
                        	<c:when test="${sessionScope.nick_name eq vo.writerName}">
                            	<a href="#" onclick="openReviewUpdateForm('${vo.num}', '${vo.content}', '${vo.rated}')">수정</a>
	                             <a href="#" onclick="confirmDelete(${vo.num})">삭제</a>
    	                    </c:when>
        	                <c:otherwise>
            	                ${vo.writerName}
                	        </c:otherwise>
                    	</c:choose>
	                </div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>


<!-- 파티관련
<div>
	<div>관련 모임</div>
	<c:forEach var="vo" items="${partyList}">
		<div>
			<div>
				<div>
					<div>${vo.title}</div>
					<div></div>
				</div>
				<div>
					<div>${vo.rated}</div>
					<div>${vo.writer}</div>
				</div>
		</div>
	</c:forEach>
-->
</body>
</html>