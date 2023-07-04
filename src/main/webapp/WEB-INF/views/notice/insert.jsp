<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="../resources/css/notice/button.css">
<script src="https://cdn.ckeditor.com/ckeditor5/38.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>

<style>
  .ck-editor__editable { height: 400px; }
  .ck-editor__editable p {margin: 0}
</style>
</head>
<body>
	<h1>공지사항</h1>
	<form action="insertOK.do" method="post" enctype="multipart/form-data">
	<div>
		<div>
			<input type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" style="border:0 solid black; outline: none;">
		</div>
		<hr>
		<div>
			<textarea name="content" id="content" rows="10" cols="22" placeholder="내용 입력" onfocus="this.placeholder=''" onblur="this.placeholder='내용 입력'" style="border:0 solid black; outline: none"></textarea>
		</div>
		
		<div>
			<input type="file" id="file" name="file">
		</div>
		<div>
			<input type="submit" value="작성" class="myButton">
		</div>
	</div>
	</form>
	
	<script type="text/javascript">
		ClassicEditor
	    .create(document.querySelector('#content'), {
	    	language: "ko",
 	    	
	    });
		
		
	</script>
	
</body>
</html>