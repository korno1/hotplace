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
        }
        .left-arrow,
        .right-arrow {
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
    <script>
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
        <div class="shop-container">
            <div class="arrow left-arrow" onclick="slideLeft()">
                <img id="prevArrow" width="30px" src="../resources/ArrowSource/Left.png">
            </div>
            <div class="shop-items">
                <c:forEach var="vo" items="${vos}" varStatus="loop">
                    <div class="shop-item" onClick="selectOne('${vo.num}')">
                        <div>
                            <img id="symbol" width="200px" src="../resource/ShopSymbol/${vo.symbol}">
                        </div>
                        <div>${vo.name}</div>
                    </div>
                </c:forEach>
            </div>
            <div class="arrow right-arrow" onclick="slideRight()">
                <img id="nextArrow" width="30px" src="../resource/ArrowSource/Right.png">
            </div>
        </div>
    </div>
</div>
</body>
</html>