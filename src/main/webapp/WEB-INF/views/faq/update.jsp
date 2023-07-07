<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
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
	
	$(function(){
		let eve_content;
// 		$.ajax({
// 			url: "json/selectOne.do",
// 			data: {
// 				num: ${param.num}
// 			},
// 			method: 'GET',
// 			dataType: 'json',
// 			success: function(vo){
// 				$('#title').val(vo.title);
// 				$('#content').val(vo.content);
				
// 			}, // end success
// 			error:function(xhr,status,error){
// 				console.log('xhr.status:', xhr.status);
				
// 			} // end error
// 		}) // end ajax
	}); // end onload
	
	function updateOK(){
		$.ajax({
			url: "json/updateOK.do",
			data: {
				num: ${param.num},
				title: $('#title').val(),
// 				content: $('#content').val(),
				content: eve_content.getData()

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
	<h1>FAQ</h1>

	<div>
		<div>
			<input type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" style="border:0 solid black; outline: none;" value="">
		</div>
		<hr>
		<div>
			<textarea name="content" id="content" rows="10" cols="22" placeholder="내용 입력" onfocus="this.placeholder=''" onblur="this.placeholder='내용 입력'" style="border:0 solid black; outline: none"></textarea>
		</div>
		
		
		<div>
			<button onclick="updateOK()" class="myButton">수정</button>
		</div>
	</div>

	<script type="text/javascript">
		
		$.ajax({
			url: "json/selectOne.do",
			data: {
				num: ${param.num}
			},
			method: 'GET',
			dataType: 'json',
			success: function(vo){
				$('#title').val(vo.title);
				ClassicEditor
			    .create(document.querySelector('#content'), {
			    	language: "ko",
		 	    	
			    })
			    .then(content => {
			    	eve_content = content;
			    	eve_content.setData(vo.content);
			    });
				
			}, // end success
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		})
		
	</script>
</body>
</html>