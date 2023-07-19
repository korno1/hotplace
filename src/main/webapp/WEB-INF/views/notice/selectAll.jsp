<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/notice/list.css?after">
<link rel="stylesheet" href="../resources/css/notice/button.css?after">
<script type="text/javascript"> 

	// a 태그로 이동 시 post 전송
	function listView(searchKey, searchWord, page){
	    let f = document.createElement('form');
	    
	    let sKey;
	    sKey = document.createElement('input');
	    sKey.setAttribute('type', 'hidden');
	    sKey.setAttribute('name', 'searchKey');
	    sKey.setAttribute('value', searchKey);
	    
	    let sWord;
	    sWord = document.createElement('input');
	    sWord.setAttribute('type', 'hidden'); 
	    sWord.setAttribute('name', 'searchWord');
	    sWord.setAttribute('value', searchWord);
	    
	    let pg;
	    pg = document.createElement('input');
	    pg.setAttribute('type', 'hidden');
	    pg.setAttribute('name', 'page');
	    pg.setAttribute('value', page);
	    
	    f.appendChild(sKey);
	    f.appendChild(sWord);
	    f.appendChild(pg);
	    f.setAttribute('method', 'post'); // post 전송
	    f.setAttribute('action', 'searchList.do');
	    document.body.appendChild(f);
	    f.submit();
	}
	
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


  
</script> 
</head>
<body>

	<div class="not_top">
		<h1 class="notice_h3">공지사항</h1>
		<button onclick="location.href='insert.do'" class="not_grade_button">글작성</button>
	</div>
	<div class="not_body">
		<div class="not_header">
			<div class="not_title">제목</div>
			<div class="not_writer">작성자</div>
			<div class="not_wdate">작성일</div>
			<div class="not_vcount">조회수</div>
		</div>
		<div class="not_content">
			<c:forEach var="vo" items="${vos}"> 
				<fmt:parseDate var="dateFmt" value="${vo.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
				<fmt:formatDate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd" />
				
				<div class="not_selectOne" onclick="selectOneForm(${vo.num})" style="cursor:pointer">
					<div class="not_content_title">${vo.title}</div>
					<div class="not_content_writer">${vo.writer}</div>
					<div class="not_content_wdate">${fmtwdate}</div>
					<div class="not_content_vcount">${vo.viewCount}</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div class="not_footer">
		<div class="not_search">
			<form action="searchList.do" method="post">
				<select name="searchKey" class="not_searchkey">
					<option value="title" <c:if test="${searchKey == 'title'}"> selected </c:if>>제목</option>
					<option value="content" <c:if test="${searchKey =='content'}"> selected </c:if>>내용</option>
				</select>
				<input type="text" class="not_searchword" name="searchWord" id="searchWord" value="${searchWord}">
				<input type="hidden" name="page" value=1>
				<input type="submit" value="검색" class="not_searchBtn">
			</form>
		</div>
		
		<div class="change_page">
				<button class="pre_page" id="pre_page">이전</button>
				<button class="next_page" id="next_page">다음</button>
				
		</div>
	</div>
	
	
	<script type="text/javascript">
		if(${page}==1){
			$('#pre_page').click(function(){
				alert('첫번째 페이지입니다.');
				return false;
			});
			$('#next_page').click(function(){
				listView('${searchKey}', '${searchWord}', ${page+1});
			});
		}
		else if((${page}*10) >= ${cnt}){
			$('#next_page').click(function(){
				alert('마지막 페이지입니다.');
				return false;
			});
			$('#pre_page').click(function(){
				listView('${searchKey}', '${searchWord}', ${page-1})
			});
		}
		else{
			$('#next_page').click(function(){
				listView('${searchKey}', '${searchWord}', ${page+1});
			});
			$('#pre_page').click(function(){
				listView('${searchKey}', '${searchWord}', ${page-1})
			});
		}
		
		if("${grade}"=="1"){
			$('.not_grade_button').css("display", "block");
		}
	</script>
	
	
	
</body>
</html>