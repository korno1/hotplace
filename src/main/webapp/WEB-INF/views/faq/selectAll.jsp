<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/faq/list.css">
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
		
// 		$('#searchWord').val("${param.searchWord}");
// 		$.ajax({
// 			url: "json/searchList.do",
// 			data:{
// 				searchKey: "${param.searchKey}",
// 				searchWord: "${param.searchWord}",
// 				page: page,
// 			},
// 			method: 'GET',
// 			dataType: 'json',
// 			success: function(arr){
// 				console.log('ajax...',arr);
// 				let tag_vos = `
// 					<div>
// 						<div class="faq_title">
// 							<span>제목</span>
// 						</div>
// 					</div>
// 				`;
				
// 				$.each(arr, function(index, vo){
// 					tag_vos +=`
// 						<div style="width:100%">
// 							<div class="faq_header" onclick="clickPlain(\${vo.num})">
// 								<span>\${vo.title}</span>
// 							</div>
// 							<div id="clickNum\${vo.num}" style="display:none;">
// 								\${vo.content}
// 							</div>
// 							<div class="faq_content" id="atagNum\${vo.num}" style="display:none; text-align:right">
// 								<a href="update.do?num=\${vo.num}">수정</a>
// 								<a href="javascript:void(0);" onclick="deleteOK(\${vo.num})">삭제</a>
// 							</div>
// 						</div>
// 					`;
					
// 				}); // end for-each
				
// 				let pr_nx = `
// 					<a href="selectAll.do?searchKey=\${searchKey}&searchWord=\${searchWord}&page=\${page-1}" id="faq_pre_page">이전</a>
// 					<a href="selectAll.do?searchKey=\${searchKey}&searchWord=\${searchWord}&page=\${parseInt(page)+1}" id="faq_next_page">다음</a>
// 				`;
// 				$('#faq_div').html(tag_vos);
// 				$('#faq_pre_next').html(pr_nx);

// 			}, // end success
			
// 			error:function(xhr,status,error){
// 				console.log('xhr.status:', xhr.status);
// 			} // end error
// 		}); // end searchList ajax;

// 		$.ajax({
// 			url: "json/selectAll.do",
// 			data:{
// 				searchKey: "${param.searchKey}",
// 				searchWord: "${param.searchWord}",
// 			},
// 			method: 'GET',
// 			dataType: 'json',
// 			success: function(cnt){
// 				console.log('ajax...',cnt);
// 				if(page==1){
// 	//	 			$('#pre_page').hide();
// 					$('#faq_pre_page').click(function(){
// 						alert('첫번째 페이지입니다.');
// 						return false;
// 					});
// 				}
// 				if((page*5) >= cnt){
// 	//	 			$('#next_page').hide();
// 					$('#faq_next_page').click(function(){
// 						alert('마지막 페이지입니다.');
// 						return false;
// 					});
// 				}
	
// 			}, // end success
			
// 			error:function(xhr,status,error){
// 				console.log('xhr.status:', xhr.status);
				
// 			} // end error
// 		}); // end selectAll ajax;	

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
	 				let tag_vos = `
	 					<div>
	 						<div class="faq_title">
	 							<span>제목</span>
	 						</div>
	 					</div>
	 				`;
					
	 				$.each(arr, function(index, vo){
	 					tag_vos +=`
	 						<div style="width:100%">
	 							<div class="faq_header" onclick="clickPlain(\${vo.num})">
	 								<span>\${vo.title}</span>
	 							</div>
	 							<div id="clickNum\${vo.num}" style="display:none;">
	 								\${vo.content}
	 							</div>
	 							<div class="faq_content" id="atagNum\${vo.num}" style="display:none; text-align:right">
	 								<a href="update.do?num=\${vo.num}">수정</a>
	 								<a href="javascript:void(0);" onclick="deleteOK(\${vo.num})">삭제</a>
	 							</div>
	 						</div>
	 					`;
	 				});
	 				
	 				let pr_nx = `
	 					<button id="faq_pre_page">이전</button>
	 					<button id="faq_next_page">다음</button>
	 				`;
					
	 				$('#faq_div').html(tag_vos);
					$('#faq_pre_next').html(pr_nx);
					
		
	 			}, // end success
				
	 			error:function(xhr,status,error){
	 				console.log('xhr.status:', xhr.status);
	 			} // end error
			}); // end ajax
		} // end loadPage
		
		loadPage(page);
	
		function countPost(){
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
	
			}, // end success
			
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		}); // end selectAll ajax;	
	
		}
		countPost();
		
		$(document).on('click', '#faq_pre_page', function(e) {
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
		 
		$(document).on('click', '#faq_next_page', function(e) {
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
// 		console.log('skey:', sKey);
// 		console.log('sWord:', sWord);
// 		let url = 'selectAll.do?searchKey=' + sKey + "&searchWord=" + sWord + "&page=1";
// 		location.replace(url);
// 	}; // end searchList
	
	function deleteOK(wnum){
		console.log('wnum:', wnum);
		$.ajax({
			url: "json/deleteOK.do",
			data: {
				num: wnum
			},
			method: 'GET',
			dataType: 'json',
			success: function(obj){
				console.log('ajax...', obj.result);
				if(obj.result==1){
					let url='selectAll.do?searchKey=title&page=1';
					location.replace(url);
				}
			},
			
			error: function(xhr, status, error){
				console.log('xhr.status', xhr.status);
			}
			
		}); // end ajax;
	}

	
	function clickPlain(num){
		let name = '#clickNum' + num;
		let tag = '#atagNum' + num;
		console.log(name);
// 		if($(name).css("display") == 'none'){
// 			$(name).css("display", '');
// 			$(tag).css("display", '');
// 		}
// 		else{
// 			$(name).css("display", 'none');
// 			$(tag).css("display", 'none');
// 		}
		$(name).slideToggle();
		$(tag).slideToggle();
	};
	
</script>
</head>
<body>
	<h1>FAQ</h1>

	
	
	<div class="faq_div" id="faq_div">
		
	</div>
	
	<div style="width:100%; display:inline-block; text-align: center">
		<form id="searchForm">
		<select id="searchKey" name="searchKey">
			<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
			<option value="content" <c:if test="${param.searchKey =='content'}"> selected </c:if>>내용</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
		<input type="hidden" name="page" value=1>
		<button type="submit">검색</button>
		</form>
	</div>
	
	<div class="faq_pre_next" id="faq_pre_next">
	</div>
	
	<div class="faq_insert">
		<a href="insert.do">글작성</a>
	</div>
	
	
	
	
	

	
	
		
	
</body>
</html>