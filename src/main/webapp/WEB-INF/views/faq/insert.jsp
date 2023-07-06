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
  .ck-editor__editable { height: 400px; }
  .ck-editor__editable p {margin: 0}
</style>

<script type="text/javascript">

	$(function(){
		let eve_content;
	});
	
	function insertOK(){
		
		$.ajax({
			url: "json/insertOK.do",
			data: {
				title: $('#title').val(),
				content: eve_content.getData(),
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
	} // end insertOK
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