<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Home</title>
    <style>
        .shop-container {
            width: 1100px; /* Adjust the width as needed */
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        .shop-item {
            flex-shrink: 0;
            width: 200px;
            margin: 10px;
            padding: 10px;
            border: 1px solid black;
            cursor:pointer;
        }

        .shop-items {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: hidden;
            scroll-behavior: smooth;
            -webkit-user-select: none;
    		-moz-user-select: none;
    		-ms-user-select: none;
    		user-select: none;
        }
        .left-arrow,
        .right-arrow {
            display: flex;
            align-items: center;
            justify-content: center;
            cursor:pointer;
        }
        .modal {
    		position: fixed;
    		top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    z-index: 9999;
		}

		.modal iframe {
		    width: 840px; /* 필요에 따라 너비와 높이를 조정합니다 */
		    height: 890px;
		    border: none;
		    background-color: white;
		    border-radius:25px;
		}
    </style>
    <script>
   		var isDragging = false;
   		var startX, scrollLeft;
    
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
            window.location.href = 'shop/selectOne.do?num=' + num;
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
            
         // Close button
            var closeButton = document.createElement('span');
    		closeButton.className = 'close-button';
    		closeButton.innerHTML = 'X';
		    closeButton.onclick = closeModal;
    		modal.appendChild(closeButton);

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
    </script>
</head>
<body>
<div>
    <form action="shop/searchList.do">
        <select name="searchKey" id="searchKey">
            <option value="name">name</option>
            <option value="cate">cate</option>
        </select>
        <input type="text" name="searchWord" id="searchWord">
        <input type="hidden" name="pageNum" id="pageNum" value="1">
        <input type="submit" value="검색">
    </form>
</div>
<div>
    <div>
        <div>집 주변에 이런게 있어요</div>
        <div class="shop-container" onmousedown="startDrag(event)" onmousemove="drag(event)" onmouseup="endDrag()">
    		<div class="arrow left-arrow" onclick="slideLeft()">
        		<img id="prevArrow" width="30px" src="resources/ArrowSource/Left.png">
    		</div>
    		<div class="shop-items" id="shopItems">
        		<c:forEach var="vo" items="${vos}" varStatus="loop">
            		<div class="shop-item" onClick="selectOne('${vo.num}')">
                		<div>
                    		<img id="symbol" width="200px" src="resources/ShopSymbol/${vo.symbol}" draggable="false">
                		</div>
                		<div>${vo.name}</div>
            		</div>
        		</c:forEach>
    		</div>
    		<div class="arrow right-arrow" onclick="slideRight()">
        		<img id="nextArrow" width="30px" src="resources/ArrowSource/Right.png">
    		</div>
		</div>
    </div>
    <div>
    	<div onclick="openModal()">가게 추가</div>
    </div>
</div>
</body>
</html>