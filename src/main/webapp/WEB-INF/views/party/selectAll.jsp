<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임리스트</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/selectAll.css?after" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
//$(function(){
//	 history.replaceState({}, null, location.pathname); 
//})

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
</script>
</head>
<body>
	<div class="party-body">

		<div class="search-form">
			<form action="searchList.do" method="post">
				<select name="searchKey" class="par-searchKey">
					<option value="title"
						<c:if test="${searchKey == 'title'}"> selected </c:if>>제목</option>
					<option value="place"
						<c:if test="${searchKey =='place'}"> selected </c:if>>장소</option>
				</select>
				<input class="searchWord" type="text" name="searchWord" id="searchWord" value="${searchWord}">
				<input type="hidden" name="page" value=1> 
				<input class="search-input" type="submit" value="검색">
			</form>
		</div>

		<div class="filter">
			<div class="title">모임리스트</div>
			<button class="filter-bt" onclick="location.href='selectAll.do?searchKey=${searchKey}&searchWord=${searchWord}&page=1&status=0'">전체</button>
			<button class="filter-bt" onclick="location.href='selectAll.do?searchKey=${searchKey}&searchWord=${searchWord}&page=1&status=1'">모집중</button>
			<button class="filter-bt" onclick="location.href='selectAll.do?searchKey=${searchKey}&searchWord=${searchWord}&page=1&status=2'">모집완료</button>
		</div>

		<div class="par-selectAll">
			<c:forEach var="vo" items="${vos}">
				<div class="par-post">
					<div class="par-status">${vo.applicants}/${vo.max}</div>
					<div class="par-title">[${vo.place}] ${vo.title}</div>
					<div class="par-container">
						<div class="par-list">
							<div>마감일</div>
							<div>약속일</div>
							<div>주최자</div>
						</div>
						<div class="par-data">
							<div>${vo.deadLine}</div>
							<div>${vo.timeLimit}</div>
							<div>${vo.writerName}</div>
						</div>
					</div>
					<button class="par-bt"
						onclick="location.href='selectOne.do?partyNum=${vo.partyNum}'">MORE
						VIEW</button>
				</div>
			</c:forEach>
		</div>

		<div class="par_paging" id="par_paging">
			<button class="par_back_page" id="par_back_page">이전</button>
			<button class="par_next_page" id="par_next_page">다음</button>
			<button class="par_insert" onclick="location.href='insert.do'">모임글쓰기</button>
		</div>
	</div>

	<script type="text/javascript">
	if(${page}==1){
		$('#par_back_page').click(function(){
			alert('첫번째 페이지입니다.');
			return false;
		});
		$('#par_next_page').click(function(){
			listView('${searchKey}', '${searchWord}', ${page+1});
		});
	}
	else if((${page}*6) >= ${cnt}){
		$('#par_next_page').click(function(){
			alert('마지막 페이지입니다.');
			return false;
		});
		$('#par_back_page').click(function(){
			listView('${searchKey}', '${searchWord}', ${page-1})
		});
	}
	else{
		$('#par_next_page').click(function(){
			listView('${searchKey}', '${searchWord}', ${page+1});
		});
		$('#par_back_page').click(function(){
			listView('${searchKey}', '${searchWord}', ${page-1})
		});
	}
	</script>
	
</body>
</html>