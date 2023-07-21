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
<link rel="stylesheet" href="../resources/css/event/insert.css">
<link rel="stylesheet" href="../resources/css/event/button.css">

<style>
  .ck-editor__editable { height: 400px; 
   						width:635px; 
  						word-wrap: break-word;
  }
  .ck-editor__editable p {margin: 0}
</style>



<script type="text/javascript">
	
	$(function(){
		date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -8);
		$('#deadline').val(date);
		$('#deadline').attr('min', date);
		let eve_content;
		
		$.ajax({
			url: "json/selectOne.do",
			data: {
				num: ${param.num}
			},
			method: 'GET',
			dataType: 'json',
			success: function(vo){
				$('#title').val(vo.title);
				$('#deadline').val(vo.deadline);
				$('#saveName').val(vo.saveName);
				
				
			}, // end success
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		})
	}); // end onload
	
	function updateOK(){
		if($('#title').val()==''){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if(eve_content.getData()==''){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		let formData = new FormData();
		formData.append('num', ${param.num});
		formData.append('title', $('#title').val());
// 		formData.append('content', $('#content').val());
		formData.append('content', eve_content.getData());
		formData.append('deadline', $('#deadline').val());
		formData.append('saveName', $('#saveName').val());
		if($('#file')[0].files[0] != undefined)
			formData.append('file', $('#file')[0].files[0]);
		$.ajax({
			url: "json/updateOK.do",
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
					let url='selectOne.do?num=' + ${param.num};
					location.replace(url);
				}
			},
			
			error: function(xhr, status, error){
				console.log('xhr.status', xhr.status);
			}
			
		}); // end ajax
		
	} // end updateOK
	
	
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
	
	function setMin(){
		if($('#deadline').val() < date){
			alert('현재 시간보다 이전의 시간입니다.');
			$('#deadline').val(date);
		}
	}
</script>

</head>

<body>
	<h1>이벤트</h1>

	<div>
		<div class="eve_writer_div">
			<div class="eve_writer_left">
				작성자
			</div>
			<div  class="eve_writer_right">
				<input class="eve_title_insert" type="hidden" name="writer" id="writer" value="${nick_name}">
				<span>${nick_name}</span>
			</div>
		</div>
		
		<div class="eve_title_div">
			<div class="eve_title_left">제목</div>
			<div class="eve_title_right">
				<input class="eve_title_input" type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" onkeyup="titleCheckByte(this, 100)">
			</div>
		</div>
	
		<div class="eve_deadline_div">
			<div class="eve_deadline_left">종료일자</div>
			<div class="eve_deadline_right">
				<input class="eve_deadline_time" type="datetime-local" name="deadline" id="deadline" onchange="setMin()">
			</div>
		</div>
		
		<div class="eve_textArea">
			<div class="eve_content_left">내용</div>
			<div class="eve_content_right">
				<textarea name="content" id="content" rows="10" cols="22" placeholder="내용 입력" onfocus="this.placeholder=''" onblur="this.placeholder='내용 입력'"></textarea>
			</div>
		</div>
		
		<div class="eve_check_byte">
			<div class="eve_byte_left"></div>
			<div class="eve_byte_right" id="checkby">0</div>/4000byte
		</div>
		
		<div class="eve_upload_div">
			<div class="eve_upload_left">첨부파일</div>
			<div class="eve_upload_right">
				<input type="file" id="file" name="file">
				<input type="hidden" id="saveName" name="saveName" value="">  
			</div>
		</div>
		
		<div class="eve_insert_div">
			<button class="eve_button" onclick="updateOK()">수정</button>
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
				ClassicEditor
			    .create(document.querySelector('#content'), {
			    	language: "ko",
			    	toolbar: [ , 'undo', 'redo', '|', 'heading', '|', 'bold', 'italic', 'link'],
			    })
			    .then(content => {
			    	eve_content = content;
			    	eve_content.setData(vo.content);
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
				
			}, // end success
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		})
		
	</script>

</body>
</html>