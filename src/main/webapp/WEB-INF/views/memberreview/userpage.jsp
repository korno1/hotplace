<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userpage</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	console.log('onload...');
});

	function mre_selectAll(user_num=3){
		console.log('mer_selectAll()....user_num:',user_num);
		
		$.ajax({
			url : "memberreview/json/selectAll.do",
			data:{
				user_num:3
			},
			method:'GET',
			dataType:'json',
			success : function(vos) {
				console.log('ajax...success:', vo);
				let tag_txt = '';
				tag_txt += `
					<tr>
						<td>\${vo.writer_name}</td>
						<td>\${vo.wdate}</td>
						<td>\${vo.content}</td>
						<td>\${vo.save_name}</td>
					</tr>
				`;
				$('#memberreview_list').html(tag_txt);
				
// 				$.each(vos,function(index,vo){
// 					let tag_td = `<td>\${vo.content}</td>`;
// 					if(user_num==vo.user_num) tag_td = `<td><input type="text" value="\${vo.content}" id="input_content"><button onclick="updateOK(\${vo.cnum})">수정완료</button></td>`;
// 					let tag_div = ``;
// 					if('${user_num}'===vo.writer){
// 						tag_div = `<div>
// 							<button onclick="selectAll(\${vo.cnum})">댓글수정</button>
// 							<button onclick="deleteOK(\${vo.cnum})">댓글삭제</button>
// 						</div>`;
// 					}
// 				});

			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});

	}

</script>
</head>
<body>
	<a href="#" onclick="par_selectAll()">모임리스트</a>
	<a href="#" onclick="mre_selectAll()">후기목록</a>
		
	<hr>	
	<button onclick="myParty">내 모임 확인</button>
	
	<ul>
		<li><a href="home.do">HOME</a></li>
		<li><a href="memberreview/json/selectAll.do?user_num=3">selectAll.do</a></li>
		<li><a href="memberreview/json/insertOK.do?party_num=9&user_num=3&writer_num=5&content=content33&rated=5">insertOK.do</a></li>
		<li><a href="memberreview/json/updateOK.do?memberreview_num=12&content=후기12&rated=4">updateOK.do</a></li>
		<li><a href="memberreview/json/deleteOK.do?memberreview_num=13">deleteOK.do</a></li>
	</ul>
	
	<table id="memberreview_list"> </table>

</body>
</html>



