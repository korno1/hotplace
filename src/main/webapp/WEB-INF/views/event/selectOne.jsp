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
<style type="text/css">
	#contentArea p{
		margin: 0;
	}
</style>
<script type="text/javascript">

	$(function(){
		$.ajax({
			url: "json/selectOne.do",
			data: {
				num: ${param.num},
			},
			method: 'GET',
			dataType: 'json',
			success: function(vo2){
				console.log(vo2);
				let nwdate = vo2.wdate.substring(0,16);
				let deadline = vo2.deadline.substring(0,16);
				let hvo = `
					<tr>
						<td colspan="4">\${vo2.title}</td>
					</tr>
					<tr>
						<td>\${vo2.writer}</td>
						<td>\${nwdate}</td>
						<td>\${deadline}</td>
						<td>조회 \${vo2.viewCount}</td>
					</tr>
				`;
				let bvo = `
					<tr>
						<td id="contentArea" colspan="4">\${vo2.content}</td>
					</tr>	
				`;
				
				if(vo2.saveName != null){
					bvo += `
					<tr>
						<td colspan="4">
							<img src="../resources/PostImage/\${vo2.saveName}">
						</td>
					</tr>
					`;
				}
				
				$('#vo_head').html(hvo);
				$('#vo_body').html(bvo);
				
			}, // end success
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			} // end error
		}); //end ajax
		
		$('#delButton').click(function(){
			if(confirm("글을 삭제하시겠습니까?")){
				deleteOK();
			}
			
		}); // end click
		
		
		
	}); // end onload
	
	function deleteOK(){
		$.ajax({
			url: "json/deleteOK.do",
			data: {
				num: ${param.num},
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
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			} // end error
		}); // end ajax
	} // end deleteOK
	
</script>
</head>
<body>
	<h1>공지사항</h1>
<%-- 	<jsp:include page="../top_menujm.jsp"></jsp:include> --%>

	
	
	<table border="1" style="border-collapse: collapse">
		<thead id="vo_head">
			
		</thead>
			
		<tbody id="vo_body">
			
		</tbody>
		
		<tfoot>
			<tr>
				<td colspan="4">
					<button type="button" onclick="location.href='update.do?num=${param.num}'">수정</button>
					<button type="button" id="delButton">삭제</button>
				</td>
			</tr>
		</tfoot>
	</table>
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