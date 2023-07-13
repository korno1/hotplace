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
<link rel="stylesheet" href="../resources/css/faq/insert.css">
<style>
  .ck-editor__editable { height: 400px; 
/*   						width:800px; */
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
		if($('#title').val()==''){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		if(eve_content.getData()==''){
			alert("내용을 입력해주세요.");
			return false;
		}
		
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
	<h1>FAQ</h1>

	<div class="faq_title_div">
		<div>
			<input class="faq_title_insert" type="text" name="title" id="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'" onkeyup="titleCheckByte(this, 100)">
		</div>
		
		<div>
			<textarea name="content" id="content" rows="10" cols="22" placeholder="내용 입력" onfocus="this.placeholder=''" onblur="this.placeholder='내용 입력'" ></textarea>
		</div>
		
		
		<div class="faq_insert_button">
			<button onclick="updateOK()">수정</button>
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