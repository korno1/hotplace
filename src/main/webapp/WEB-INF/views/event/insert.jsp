<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/38.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<link rel="stylesheet" href="../resources/css/notice/button.css">

<style>
  .ck-editor__editable { height: 400px; 
  						width:800px;
  						word-wrap: break-word;
  }
  .ck-editor__editable p {margin: 0}
</style>

<script type="text/javascript">
	
	let date;
	
	$(function(){
		date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -8);
		$('#deadline').val(date);
		$('#deadline').attr('min', date);
		let eve_content;
		
		
	});
	
	function setMin(){
		if($('#deadline').val() < date){
			alert('현재 시간보다 이전의 시간입니다.');
			$('#deadline').val(date);
		}
	}
	
// 	function insertOK(){
// 		let form = $('#file')[0].files[0];
// 		let formData = new FormData();
		
// 		formData.append('files', form);
		
// 		$.ajax({
// 			url: "json/insertOK.do",
// 			data: {
// 				title: $('#title').val(),
// 				content: $('#content').val(),
// 				writerNum: 1,
// 				deadline: $('#deadline').val()
// 			},
// 			method: 'GET',
// 			dataType: 'json',
// 			success: function(obj){
// 				console.log('ajax...', obj.result);
// 				if(obj.result==1){
// 					let url='selectAll.do?searchKey=title&page=1';
// 					location.replace(url);
// 				}
// 			},
			
// 			error: function(xhr, status, error){
// 				console.log('xhr.status', xhr.status);
// 			}
			
// 		}); // end ajax;
// 	} // end insertOK
	
	function insertOK(){
		
		let formData = new FormData();
// 		alert(eve_content.getData());
		formData.append('title', $('#title').val());
		formData.append('content', eve_content.getData());
		formData.append('writerNum', 1);
		formData.append('deadline', $('#deadline').val());
		if($('#file')[0].files[0] != undefined)
			formData.append('file', $('#file')[0].files[0]);
		console.log(formData);
		
		$.ajax({
			url: "json/insertOK.do",
			data: formData,
			method: 'POST',
			processData: false,
			cache: false,
			contentType: false,
			dataType: 'json',
			enctype : 'multipart/form-data',
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
	} // end insertOK
</script>

</head>

<body>
	<h1>이벤트</h1>

	<div>
		<div>
			<input type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" style="border:0 solid black; outline: none;" value="">
			<span><input type="datetime-local" name="deadline" id="deadline" onchange="setMin()"></span>
		</div>
		<hr>
		<div>
			<textarea name="content" id="content" rows="10" cols="22" placeholder="내용 입력" onfocus="this.placeholder=''" onblur="this.placeholder='내용 입력'" style="border:0 solid black; outline: none"></textarea>
		</div>
		
		<div>
			<input type="file" id="file" name="file">
		</div>
		
		<div>
			<button onclick="insertOK()" class="myButton">작성</button>
		</div>
	</div>
	
	<script type="text/javascript">
		
		ClassicEditor
	    .create(document.querySelector('#content'), {
	    	language: "ko",
 	    	
	    })
	    .then(content => {
	    	eve_content = content;
	    });
		
		
	</script>

</body>
</html>