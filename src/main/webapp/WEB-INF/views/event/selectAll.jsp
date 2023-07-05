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
// 	let urlStr = window.location.search;
// 	let urlParams = new URLSearchParams(urlStr);
	
// 	let searchKey = "${param.searchKey}";
// 	let searchWord = "${param.searchWord}";
// 	$(function(){
// 		let page;
// 		if(urlParams.get("page")==null){
// 			page=1;
// 		}
// 		else{
// 			page = urlParams.get("page");
			
// 		}
// 		console.log(page);
// 		console.log(window.location.href);
// 		$.ajax({
// 			url: "json/searchList.do",
// 			data:{
// 				searchKey: $('#searchKey').val(),
// 				searchWord: "${param.searchWord}",
// 				page: page
// 			},
// 			method: 'POST',
// 			dataType: 'json',
// 			success: function(arr){
// 				console.log('ajax...',arr);
// 				console.log("p: ", page);
// 				let tag_vos = '';
				
// 				$.each(arr, function(index, vo){
// 					let nwdate = vo.wdate.substring(0,16);
// 					tag_vos +=`
// 						<tr onclick="location.href='selectOne.do?num=\${vo.num}'" style="cursor:pointer">
// 							<td>\${vo.title}</td>
// 							<td>\${vo.writer}</td>
// 							<td>\${nwdate}</td>
// 							<td>\${vo.viewCount}</td>
// 						</tr>
// 					`;
					
// 				}); // end for-each
// // 				let n_page= parseIntpage+1;
// 				let pr_nx = `
// 					<button id="eve_pre_page">이전</button>
// 					<button id="eve_next_page">다음</button>
// 				`;
				
// 				$('#vos').html(tag_vos);
// 				$('#eve_pre_next').html(pr_nx);
				
	
// 			}, // end success
			
// 			error:function(xhr,status,error){
// 				console.log('xhr.status:', xhr.status);
// 			} // end error
// 		}); // end searchList ajax;
	let page = 1;
	let count;
	let isSearchPerformed = false;
	let searchWord = '';
	let searchKey = '';
	$(function(){		
		function loadPage(page){
			$.ajax({
				url: "json/searchList.do",
	 			data:{
	 				searchKey: searchKey,
	 				searchWord: searchWord,
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
	 				
	 				let pr_nx = `
	 					<button id="eve_pre_page">이전</button>
	 					<button id="eve_next_page">다음</button>
	 				`;
					
	 				$('#vos').html(tag_vos);
	 				$('#eve_pre_next').html(pr_nx);
					
		
	 			}, // end success
				
	 			error:function(xhr,status,error){
	 				console.log('xhr.status:', xhr.status);
	 			} // end error
			}); // end ajax
		} // end loadPage
		
		loadPage(page);
		
		function countPost(){
			console.log($('#searchWord').val());
		
			$.ajax({
				url: "json/selectAll.do",
				data:{
					searchKey: searchKey,
	 				searchWord: searchWord,
				},
				method: 'GET',
				dataType: 'json',
				success: function(cnt){
					console.log('ajax...',cnt);
					count = cnt;
					if(page==1){
	//		 			$('#pre_page').hide();
	// 					$('#eve_pre_page').click(function(){
	// 						alert('첫번째 페이지입니다.');
	// 						return false;
	// 					});
					}
					if((page*5) >= cnt){
	//		 			$('#next_page').hide();
	// 					$('#eve_next_page').click(function(){
	// 						alert('마지막 페이지입니다.');
	// 						return false;
	// 					});
					}
	
				}, // end success
				
				error:function(xhr,status,error){
					console.log('xhr.status:', xhr.status);
					
				} // end error
			}); // end selectAll ajax;
		}
		countPost();
		
		$(document).on('click', '#eve_pre_page', function(e) {
		    e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막습니다.
			if(page==1){
				alert('첫번째 페이지입니다.');
					return false;
			}
		    // 이전 페이지 번호 계산
		    let previousPage = parseInt(page) - 1;
		    page = previousPage;
		    let searchKey = $('#searchKey').val();
		    // 업데이트된 페이지 파라미터로 AJAX 요청 수행
		    loadPage(previousPage);
		  });
		 
		$(document).on('click', '#eve_next_page', function(e) {
			 e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막습니다.
			 if((page*5) >= count){
				alert('마지막 페이지입니다.');
					return false;
			 }
			    // 다음 페이지 번호 계산
		    let nextPage = parseInt(page) + 1;
			page = nextPage;
			
			let searchKey = $('#searchKey').val();
			    // 업데이트된 페이지 파라미터로 AJAX 요청 수행
		    loadPage(nextPage);
		  });
			
		$('#searchForm').submit(function(e) {
		    e.preventDefault(); // 폼의 기본 동작(페이지 다시로드)을 막습니다.
		    searchKey = $('#searchKey').val();
		    searchWord = $('#searchWord').val();
			countPost(searchKey);
		    // 업데이트된 검색어로 AJAX 요청 수행
		    
		    page = 1;
		    loadPage(page); // 페이지 1로 초기화하여 첫 번째 페이지를 로드합니다.
		    isSearchPerformed = true;
		  });
		
		
	}); // end onload
	
// 	function searchList(){
// 		let sKey = $('#searchKey').val();
// 		let sWord = $('#searchWord').val();
		
// 		let url = "selectAll.do?searchKey=" + sKey + "&searchWord=" + sWord + "&page=1";
// 		location.replace(url);
// 	}
	
	
	
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
		<form id="searchForm">
		<select id="searchKey" name="searchKey">
			<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
			<option value="content" <c:if test="${param.searchKey =='content'}"> selected </c:if>>내용</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
		<input type="hidden" name="page" value=1>
<!-- 		<button onclick="searchList()">검색</button> -->
		<button type="submit">검색</button>
		</form>
	</div>
	
	<div style="width:45%; display:inline">
		<a href="insert.do" id="notice_insert">글작성</a>
	</div>
	
	<div id="eve_pre_next">
		
	</div>
	
	
	<script type="text/javascript">
		if("${grade}" == null || "${grade}" != 1){
			$('#notice_insert').hide();
		}
		
	</script>

	

	
</body>
</html>