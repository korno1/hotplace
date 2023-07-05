<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/notice/button.css">

<script type="text/javascript">
	let urlStr = window.location.search;
	let urlParams = new URLSearchParams(urlStr);
	
	let searchKey = "${param.searchKey}";
	let searchWord = "${param.searchWord}";
	$(function(){
		
		let page;
		if(urlParams.get("page")==null){
			page=1;
		}
		else{
			page = urlParams.get("page");
			
		}
		console.log(page);
		console.log(window.location.href);
		$.ajax({
			url: "json/searchList.do",
			data:{
				searchKey: "${param.searchKey}",
				searchWord: "${param.searchWord}",
				page: page
			},
			method: 'GET',
			dataType: 'json',
			success: function(arr){
				console.log('ajax...',arr);
				console.log("p: ", page);
				let tag_vos = '';
				
				$.each(arr, function(index, vo){
					let nwdate = vo.wdate.substring(0,16);
					tag_vos +=`
						<tr onclick="location.href='selectOne.do?num=\${vo.num}'" style="cursor:pointer">
							<td>\${vo.title}</td>
							<td>\${vo.writer}</td>
							<td>\${nwdate}</td>
							<td>\${vo.viewCount}</td>
						</tr>
					`;
					
				}); // end for-each
// 				let n_page= parseIntpage+1;
				let pr_nx = `
					<a href="selectAll.do?searchKey=\${searchKey}&searchWord=\${searchWord}&page=\${page-1}" id="pre_page">이전</a>
					<a href="selectAll.do?searchKey=\${searchKey}&searchWord=\${searchWord}&page=\${parseInt(page)+1}" id="next_page">다음</a>
				`;
				
				$('#vos').html(tag_vos);
				$('#pre_next').html(pr_nx);
				
	
			}, // end success
			
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			} // end error
		}); // end searchList ajax;
		
		$.ajax({
			url: "json/selectAll.do",
			data:{
				searchKey: "${param.searchKey}",
				searchWord: "${param.searchWord}",
			},
			method: 'GET',
			dataType: 'json',
			success: function(cnt){
				console.log('ajax...',cnt);
				if(page==1){
//		 			$('#pre_page').hide();
					$('#pre_page').click(function(){
						alert('첫번째 페이지입니다.');
						return false;
					});
				}
				if((page*5) >= cnt){
//		 			$('#next_page').hide();
					$('#next_page').click(function(){
						alert('마지막 페이지입니다.');
						return false;
					});
				}

			}, // end success
			
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		}); // end selectAll ajax;
		
		
		
	}); // end onload
	
	function searchList(){
		let sKey = $('#searchKey').val();
		let sWord = $('#searchWord').val();
		
		let url = "selectAll.do?searchKey=" + sKey + "&searchWord=" + sWord + "&page=1";
		location.replace(url);
	}
	
</script>
</head>
<body>
	<h1>이벤트</h1>

	<table border="1" style="border-collapse: collapse">
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
			
		<tbody id="vos">

		
		</tbody>
		
		<tfoot>
		</tfoot>
	</table>
	
	<div style="width:30%; display:inline-block">
		<select id="searchKey" name="searchKey">
			<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
			<option value="content" <c:if test="${param.searchKey =='content'}"> selected </c:if>>내용</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
		<input type="hidden" name="page" value=1>
		<button onclick="searchList()">검색</button>
	</div>
	
	<div style="width:45%; display:inline">
		<a href="insert.do">글작성</a>
	</div>
	
	<div id="pre_next">
		
	</div>
	
	
	

	
	
<!-- 		<div> -->
<!-- 			<ul style="list-style:none"> -->
<!-- 				<li> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>제목</span> -->
<!-- 					</div> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>작성자</span> -->
<!-- 					</div> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>작성일</span> -->
<!-- 					</div> -->
<!-- 					<div style="display:table-cell"> -->
<!-- 						<span>조회수</span> -->
<!-- 					</div> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
	
</body>
</html>