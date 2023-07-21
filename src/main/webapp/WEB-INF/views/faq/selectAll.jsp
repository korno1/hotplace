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
<link rel="stylesheet" href="../resources/css/faq/button.css">
<script type="text/javascript">

	let page = 1; // 초기화면을 위한 초기화
	let count; // 게시글 개수
	let searchWord = ''; // 초기화면을 위한 초기화
	let searchKey = 'title'; // 초기화면을 위한 초기화
	
	function countPost(callback){ // 게시글 개수 계산
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
				if (callback) {
			        callback(); // 비동기 작업이 끝난 후에 콜백 함수 호출
			     }
			}, // end success
			
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		}); // end selectAll ajax;	
	
		}
		countPost();
	
	function loadPage(page){
		countPost(function(){
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
	 				let tag_vos = `
	 					<div>
	 						<div class="faq_title">
	 							<div class="faq_seq">번호</div>
	 							<div class="faq_head_title">제목</div>
	 						</div>
	 					</div>
	 				`;
					
	 				$.each(arr, function(index, vo){
	 					tag_vos +=`
	 						<div class="faq_header_size">
	 							<div class="faq_header" onclick="clickPlain(\${vo.num})">
	 								<div class="faq_content_seq">\${count-(vo.rn-1)}</div>
	 								<div class="faq_content_title">\${vo.title}</div>
	 							</div>
	 							<div class="faq_content_background" id="content_bg\${vo.num}">
		 							<div class="faq_con" id="clickNum\${vo.num}">
		 								\${vo.content}
		 							</div>
		 							<div class="faq_content" id="atagNum\${vo.num}">
		 								<button class="faq_grade_button2" onclick="location.href='update.do?num=\${vo.num}'">수정</button>
		 								<button class="faq_grade_button2" id="delButton" onclick="deletePost(\${vo.num})">삭제</button>
		 							</div>
	 							</div>
	 						</div>
	 					`;
	 				});
	 				
	 				
					
	 				$('#faq_div').html(tag_vos);
	
	//	 				if("${grade}"=="1"){
	//	 					$('.faq_grade_button').css("display", "inline-block");
	//	 				}
					let grade = '<%= session.getAttribute("grade") %>';
			        // grade 값이 "1"인 경우 버튼을 표시
			        if (grade && grade === "1") {
			          $('.faq_grade_button2').css("display", "inline-block");
			        }
					
		
	 			}, // end success
				
	 			error:function(xhr,status,error){
	 				console.log('xhr.status:', xhr.status);
	 			} // end error
			}); // end ajax
		}); // end callback(countPost)
	} // end loadPage
	
	$(function(){		
		
		
		
		loadPage(page); // selectAll.do에 처음화면 로드
	
		
		
		$(document).on('click', '#faq_pre_page', function(e) { // 이전 버튼 클릭 시 동작
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
		 
		$(document).on('click', '#faq_next_page', function(e) {
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
			countPost(searchKey);
		    
			// 페이지 1로 초기화하여 첫 번째 페이지를 로드
		    page = 1;
		    loadPage(page); 
		  });
		
		
	
		
	
	}); // end onload
	
	function deletePost(wnum){
		if(confirm("글을 삭제하시겠습니까?")){
			deleteOK(wnum);
		}
	}

	
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

	// 게시글을 부드럽게 내려오게 만듬
	function clickPlain(num){
		let name = '#clickNum' + num;
		let tag = '#atagNum' + num;
		let pp = '#content_bg' + num;
		console.log(name);
// 		let minHeight = $(name).css('min-height');
// 		$(name).css('min-height', 0).slideToggle('slow', function(){
// 			$(this).css('min-height', minHeight);
// 		});
		
// 		$(name).slideToggle();
// 		$(tag).slideToggle();
		$(pp).slideToggle();
	};
	
	
</script>
</head>
<body>

	<div class="faq_top">
		<h1 class="faq_h1">FAQ</h1>
		<button class="faq_grade_button" onclick="location.href='insert.do'" class="faq_grade_button">글작성</button>
	</div>
	
	<div class="faq_div" id="faq_div">
		
	</div>
	
	<div class="faq_search">
		<form id="searchForm">
		<select class="faq_searchkey" id="searchKey" name="searchKey">
			<option value="title" <c:if test="${param.searchKey == 'title'}"> selected </c:if>>제목</option>
			<option value="content" <c:if test="${param.searchKey =='content'}"> selected </c:if>>내용</option>
		</select>
		<input type="text" class="faq_searchword" name="searchWord" id="searchWord" value="${param.searchWord}">
		<input type="hidden" name="page" value=1>
		<button type="submit" class="faq_searchBtn">검색</button>
		</form>
	</div>
	
	<div class="faq_change_page" id="faq_pre_next">
		<button class="faq_pre_button" id="faq_pre_page">이전</button>
	 	<button class="faq_next_button" id="faq_next_page">다음</button>
	 	
	</div>
	
	<script type="text/javascript">
		if("${grade}"=="1"){
			$('.faq_grade_button').css("display", "block");
		}
	</script>

	
</body>
</html>