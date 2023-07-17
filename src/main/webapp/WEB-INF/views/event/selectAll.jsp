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
<link rel="stylesheet" href="../resources/css/event/list.css">
<link rel="stylesheet" href="../resources/css/event/button.css">

<script type="text/javascript">
	let page = 1; // 초기화면을 위한 초기화
	let count; // 게시글 개수
	let searchWord = ''; // 초기화면을 위한 초기화
	let searchKey = 'title';  // 초기화면을 위한 초기화
	
	function selectOneForm(num) {
	    var form = document.createElement("form");
	    form.setAttribute("method", "post");
	    form.setAttribute("action", "selectOne.do");

	    var numInput = document.createElement("input");
	    numInput.setAttribute("type", "hidden");
	    numInput.setAttribute("name", "num");
	    numInput.setAttribute("value", num);

	    form.appendChild(numInput);

	    document.body.appendChild(form);
	    form.submit();
	  }
	
	$(function(){
		
		function loadPage(page){
			$('#searchKey').val(searchKey);
			$('#searchWord').val(searchWord);
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
	 				let tag_vos = '';
					
	 				$.each(arr, function(index, vo){
	 					let nwdate = vo.wdate.substring(0,11);
	 					let deadline;
	 					if(vo.deadline != null){
	 						deadline = vo.deadline.substring(0,11);
	 					}
	 					let today = new Date(); // 현재 시스템 시간
	 					
	 					if(new Date(vo.deadline) < today){ // 마감일 < 현재시간 => 종료
	 						tag_vos += `
	 							<div class="eve_selectOne" onclick="selectOneForm(\${vo.num})" style="cursor:pointer">
	 							<div class="eve_content_title">
	 								<span class="event_check">종료</span>
	 								<span class="vo_title">\${vo.title}</span>
	 							</div>
	 						`;
	 					}
	 					else{ // 마감일 >= 현재시간 => 진행중
	 						tag_vos += `
	 							<div class="eve_selectOne" onclick="selectOneForm(\${vo.num})" style="cursor:pointer">
	 							<div class="eve_content_title">
	 								<span class="event_check">진행중</span>
	 								<span class="vo_title">\${vo.title}</span>
	 							</div>
	 						`;
	 					}
	 					
	 					tag_vos +=`
	 							<div class="eve_content_writer">\${vo.writer}</div>
	 							<div class="eve_content_wdate">\${nwdate}</div>
	 							<div class="eve_content_deadline">\${deadline}</div>
	 							<div class="eve_content_vcount">\${vo.viewCount}</div>
	 						</div>
	 					`;
						
	 					
	 				}); // end for-each
	 				
	 				let pr_nx = `
	 					<button id="eve_pre_page" class="eve_pre_button">이전</button>
	 					<button id="eve_next_page" class="eve_next_button">다음</button>
	 					
	 				`;
					
	 				$('#vos').html(tag_vos);
	 				$('#eve_pre_next').html(pr_nx);
					
		
	 			}, // end success
				
	 			error:function(xhr,status,error){
	 				console.log('xhr.status:', xhr.status);
	 			} // end error
			}); // end ajax
		} // end loadPage
		
		loadPage(page); // selectAll.do에 처음화면 로드
		
		
		
		function countPost(){ // 게시글 개수 계산
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
				}, // end success
				
				error:function(xhr,status,error){
					console.log('xhr.status:', xhr.status);
					
				} // end error
			}); // end selectAll ajax;
		}
		countPost();
		
		$(document).on('click', '#eve_pre_page', function(e) { // 이전 버튼 클릭 시 동작
		    e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막음.
			if(page==1){ // 첫번째 페이지에서 팝업 경고창
				alert('첫번째 페이지입니다.');
					return false;
			}
		    // 이전 페이지 번호 계산
		    let previousPage = parseInt(page) - 1;
		    page = previousPage;
		    let searchKey = $('#searchKey').val(); // 페이지-1 로드될 때 현재 searchKey값을 유지 
		    
		    // parameter 수정 후 페이지 다시 로드
		    loadPage(previousPage);
		  });
		 
		$(document).on('click', '#eve_next_page', function(e) {
			 e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막음.
			 if((page*10) >= count){ // 마지막 페이지에서 팝업 경고창
				alert('마지막 페이지입니다.');
					return false;
			 }
			    
			// 다음 페이지 번호 계산
		    let nextPage = parseInt(page) + 1;
			page = nextPage;
			
			let searchKey = $('#searchKey').val(); // 페이지+1 로드될 때 현재 searchKey값을 유지 
			
			// parameter 수정 후 페이지 다시 로드
		    loadPage(nextPage);
		  });
			
		// *중요 아래 코드가 없으면 검색어만 바꾸고 검색을 누르지 않고 이전 다음페이지로 넘어가면 searchWord가 검색창에 있는걸로 바뀜 *
		$('#searchForm').submit(function(e) { // 검색을 눌렀을 때 수행
		    e.preventDefault(); // 폼의 기본 동작(페이지 다시로드)을 막음.
		    searchKey = $('#searchKey').val(); // 현재 searchKey값을 가져와서 저장
		    searchWord = $('#searchWord').val(); // 현재 searchWord값을 가져와서 저장
		    
		    // 검색어에 대한 게시글 개수 계산
			countPost();
		   
		    
			//  페이지 1로 초기화하여 첫 번째 페이지를 로드
		    page = 1;
		    loadPage(page);
		  });
		
		
		
		
	}); // end onload
	
	
</script>
</head>
<body>

	<div class="eve_top">
		<h1 class="event_h1">이벤트</h1>
		<button onclick="location.href='insert.do'" id="event_insert" class="eve_grade_button">글작성</button>
	</div>

	<div class="eve_body">
		<div class="eve_header">
			
			<div class="eve_title">제목</div>
			<div class="eve_writer">작성자</div>
			<div class="eve_wdate">작성일</div>
			<div class="eve_deadline">마감일</div>
			<div class="eve_vcount">조회수</div>
		</div>
			
		<div class="eve_content" id="vos">

		
		</div>
	</div>
	
	<div class="eve_footer">
		<div class="eve_search">
			<form id="searchForm">
				<select class="eve_searchkey" id="searchKey" name="searchKey">
					<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
					<option value="content" <c:if test="${param.searchKey =='content'}"> selected </c:if>>내용</option>
				</select>
				<input class="eve_searchword" type="text" name="searchWord" id="searchWord" value="${param.searchWord}">
				<input type="hidden" name="page" value=1>
				<button class="eve_searchBtn" type="submit">검색</button>
			</form>
		</div>
		
		<div class="eve_change_page">
			<div class="eve_p_n_button" id="eve_pre_next"></div>
			
			
		</div>
		
	</div>
	
	<script type="text/javascript">
	if(${grade}==1){
		$('.eve_grade_button').css("display", "block");
	}
	</script>

	

	
</body>
</html>