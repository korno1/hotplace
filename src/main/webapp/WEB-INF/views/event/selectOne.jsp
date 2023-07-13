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
<link rel="stylesheet" href="../resources/css/event/post.css">
<link rel="stylesheet" href="../resources/css/event/button.css">

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
					<div class="eve_title_one">
						<div>\${vo2.title}</div>
					</div>
					<div class="eve_info_one">
						<span class="eve_one_writer">\${vo2.writer}</span>
						<span>작성일: \${nwdate}</span>
						<span class="eve_one_deadline">종료일: \${deadline}</span>
						<span class="eve_one_vcount">조회 \${vo2.viewCount}</span>
					</div>
				`;
				let bvo = `
					<div class="eve_content_div">
						<div>\${vo2.content}</div>
					</div>	
				`;
				
				if(vo2.saveName != null){
					bvo += `
						<div class="eve_img_div"> 
							<img src="../resources/PostImage/\${vo2.saveName}" class="eve_img">
						</div>
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
	<h3>이벤트</h3>
<%-- 	<jsp:include page="../top_menujm.jsp"></jsp:include> --%>

	
	
	<div class="eve_body">
		<div class="eve_title_info" id="vo_head">
			
		</div>
			
		<div class="eve_content_img" id="vo_body">
			
		</div>


		<div class="up_del_button">
			<div>
				<button type="button" class="eve_grade_button" onclick="location.href='update.do?num=${param.num}'">수정</button>
				<button type="button" class="eve_grade_button" id="delButton">삭제</button>
			</div>
		</div>
		
	</div>
	
	<script type="text/javascript">
	if(${grade}==1){
		$('.eve_grade_button').css("display", "inline-block");
	}
	</script>

	
</body>
</html>