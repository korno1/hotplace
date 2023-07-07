<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectAll</title>

<style type="text/css">
        .large {
            border: 1px solid black;
            padding: 10px;
            margin-bottom: 10px;
        }
    </style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript">
    function selectOne(num) {
    	
        // GET 요청을 통해 selectOne.do로 접근
        window.location.href = "selectOne.do?num=" + num;
    }
    
    $(function() {
        console.log('onload...');

        var page = 1; // 초기 페이지 번호

        // 페이지 로드 시 매장 목록을 가져와 화면에 표시
        searchList();

        function searchList() {
            console.log('searchList()...');
            $.ajax({
                url: "json/selectAll.do",
                data: {
                    searchKey: $("#searchKey").val(),
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
                    vo.symbol +
                    '"></div>'
                );
                listItem.append(
                    '<div><div>' +
                    vo.name +
                    '</div><div>' +
                    vo.avgRated +
                    '</div></div>'
                );

                shopList.append(listItem);
            });
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
	<h1>매장목록</h1>
	
	<div style="padding:5px">
		<form action="searchList.do">
			<select name="searchKey" id="searchKey">
				<option value="name" ${param.searchKey == 'name' ? 'selected' : ''}>name</option>
				<option value="cate" ${param.searchKey == 'cate' ? 'selected' : ''}>cate</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
			<input type="hidden" name="pageNum" id="pageNum" value=1>
			<input type="submit" value="검색">
		</form>
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