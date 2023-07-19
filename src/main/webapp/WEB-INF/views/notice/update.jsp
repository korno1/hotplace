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
<link rel="stylesheet" href="../resources/css/notice/insert.css">
<link rel="stylesheet" href="../resources/css/notice/button.css">
<script src="https://cdn.ckeditor.com/ckeditor5/38.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>

<style>
  .ck-editor__editable { height: 400px; 
   						width:635px; 
  						word-wrap: break-word;
  					}
  .ck-editor__editable p {margin: 0}
</style>

<script type="text/javascript">
	
	function titleCheckByte(obj, maxByte){
		var str = obj.value;
	    var str_len = str.length;


	    var rbyte = 0;
	    var rlen = 0;
	    var one_char = "";
	    var str2 = "";


	    for(var i=0; i<str_len; i++)
	    {
	        one_char = str.charAt(i);
	        if(escape(one_char).length > 4) {
	            rbyte += 3;                                         //한글3Byte
	        }else{
	            rbyte++;                                            //영문 등 나머지 1Byte
	        }
	        if(rbyte <= maxByte){
	            rlen = i+1;                                          //return할 문자열 갯수
	        }
	     }
	     if(rbyte > maxByte)
	     {
	        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
	        str2 = str.substr(0,rlen);                                  //문자열 자르기
	        obj.value = str2;
	        titlecheckByte(obj, maxByte);
	     }
	     else{
	    	 $('#checkby').html(rbyte);
	     }
	}
	
</script>

</head>
<body>
	<h1>공지사항</h1>
	<form action="updateOK.do" method="post" enctype="multipart/form-data" id="not_updateOK">
	<input type="hidden" name="num" value="${param.num}">
	<fmt:parseDate var="dateFmt" value="${vo2.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
	<fmt:formatDate var="fmtwdate" value="${dateFmt}" pattern="yyyy-MM-dd HH:mm" />
	<div>
		<div class="not_writer_div">
			<div class="not_writer_left">
				작성자
			</div>
			<div  class="not_writer_right">
				<input class="not_title_insert" type="hidden" name="writer" id="writer" value="${nick_name}">
				<span>${nick_name}</span>
			</div>
		</div>	
	
		<div class="not_title_div">
			<div class="not_title_left">제목</div>
			<div class="not_title_right">
				<input class="not_title_input" type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" onkeyup="titleCheckByte(this, 100)" value="${vo2.title}">
			</div>
		</div>
		
		<div class="not_textArea">
			<div class="not_content_left">내용</div>
			<div class="not_content_right">
				<textarea name="content" id="content" rows="10" cols="22">${vo2.content}</textarea>
			</div>
		</div>
		
		<div class="not_check_byte">
			<div class="not_byte_left"></div>
			<div class="not_byte_right" id="checkby">0</div>/4000byte
		</div>
		
		<div class="not_upload_div">
			<div class="not_upload_left">첨부파일</div>
			<div class="not_upload_right">
				<input type="file" id="file" name="file">
				<input type="hidden" id="saveName" name="saveName" value="${vo2.saveName}">
			</div>
		</div>
		
		<div class="not_insert_div">
			<input class="not_button" id="not_click_submit" type="button" value="작성">
		</div>
		
		
	</div>
	</form>
	
	<script type="text/javascript">
		ClassicEditor
	    .create(document.querySelector('#content'), {
	    	language: "ko",
	    	toolbar: [ , 'undo', 'redo', '|', 'heading', '|', 'bold', 'italic', 'link'],
	    })
	    .then(content => {
	    	$('#not_click_submit').click(function(){
				if($('#title').val()==''){
					alert("제목을 입력해주세요.");
					return false;
				}
				
				if(content.getData()==''){
					alert("내용을 입력해주세요.");
					return false;
				}
				
				$('#not_updateOK').submit();
			});
	    	
	    	 content.editing.view.document.on( 'keyup', () => {
	             // 키 이벤트 발생 시 실행될 함수
	            var str = content.getData();
	     	    var str_len = str.length;
	     	    var maxByte = 4000;

	     	    var rbyte = 0;
	     	    var rlen = 0;
	     	    var one_char = "";
	     	    var str2 = "";


	     	    for(var i=0; i<str_len; i++)
	     	    {
	     	        one_char = str.charAt(i);
	     	        if(escape(one_char).length > 4) {
	     	            rbyte += 3;                                         //한글3Byte
	     	        }else{
	     	            rbyte++;                                            //영문 등 나머지 1Byte
	     	        }
	     	        if(rbyte <= maxByte){
	     	            rlen = i+1;                                          //return할 문자열 갯수
	     	        }
	     	     }
	     	     if(rbyte > maxByte)
	     	     {
	     	        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
	     	        str2 = str.substr(0,rlen);                                  //문자열 자르기
	     	        console.log('str2:', str2);
	     	        content.setData(str2);
	     	     }
	     	     else{
	     	    	 $('#checkby').html(rbyte);
	     	     }
	         } );
	    });
		
		
		
		
		</script>
	
</body>
</html>