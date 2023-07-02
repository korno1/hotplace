<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/notice/button.css">

<script type="text/javascript">
	
	$(function(){
		
		$.ajax({
			url: "json/selectOne.do",
			data: {
				num: ${param.num}
			},
			method: 'GET',
			dataType: 'json',
			success: function(vo){
				$('#title').val(vo.title);
				$('#content').val(vo.content);
				$('#deadline').val(vo.deadline);
				
			}, // end success
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		})
	}); // end onload
	
	function updateOK(){
		$.ajax({
			url: "json/updateOK.do",
			data: {
				num: ${param.num},
				title: $('#title').val(),
				content: $('#content').val(),
				deadline: $('#deadline').val()
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
			
		}); // end ajax
		
	} // end updateOK
</script>

</head>

<body>
	<h1>이벤트</h1>

	<div>
		<div>
			<input type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" style="border:0 solid black; outline: none;" value="">
			<span><input type="datetime-local" name="deadline" id="deadline"></span>
		</div>
		<hr>
		<div>
			<textarea name="content" id="content" rows="10" cols="22" placeholder="내용 입력" onfocus="this.placeholder=''" onblur="this.placeholder='내용 입력'" style="border:0 solid black; outline: none"></textarea>
		</div>
		
		
		<div>
			<button onclick="updateOK()" class="myButton">수정</button>
		</div>
	</div>

</body>
</html>