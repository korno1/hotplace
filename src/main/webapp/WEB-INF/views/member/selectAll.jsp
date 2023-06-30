<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
		// 현재 URL에서 쿼리 문자열 가져오기
		let queryString = window.location.search;
		
		// URLSearchParams를 사용하여 쿼리 문자열 파싱
		let searchParams = new URLSearchParams(queryString);
		
		// 페이지 번호 추출
		let pageValue = searchParams.get('page');
		console.log('pageValue',pageValue);
		let page = pageValue ? parseInt(pageValue) : 1;
		console.log('page',page);
	$(function() {
		console.log('onload....');
		

	$.ajax({
		url : "json/selectAll.do",
		data:{
			searchKey:$("#searchKey").val(),
			searchWord:$("#searchWord").val(),
			page:page
			},
		method:'GET',//default get
		dataType:'json', //xml,text도 가능. 미기재시 text
		success : function(arr) {
				console.log('ajax...success:', arr);
			 let msg ="";
			    for (var i = 0; i < arr.length; i++) {
			    	  msg += `
				    	    <tr>
			    		  <td><a href="selectOne.do?num=\${arr[i].num}">\${arr[i].num}</a></td>
	 		    	      <td>\${arr[i].nick_name}</td>
	 		    	      <td>\${arr[i].email}</td>
	 		    	      <td>\${arr[i].address}</td>
	 		    	      <td>\${arr[i].pw}</td>
	 		    	      <td>\${arr[i].grade}</td>
	 		    	      <td>\${arr[i].gender}</td>
	 		    	      <td>\${arr[i].food_like}</td>
	 		    	      <td><button class="gradeBtn\${arr[i].num}" onclick=upgrade(this)>관리자설정</button></td>
	 		    	      <td><button class="deleteBtn\${arr[i].num}" onclick=byeOK(this)>강제탈퇴</button></td>
			    	    </tr>`;
			    }
			$("#vos").html(msg);
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
});
	function searchList(){
		console.log('searchList()...');
		
		$.ajax({
			url : "json/selectAll.do",
			data:{
				searchKey:$("#searchKey").val(),
				searchWord:$("#searchWord").val(),
				page:page
				},
			method:'GET',//default get
			dataType:'json', //xml,text도 가능. 미기재시 text
			success : function(arr) {
					console.log('ajax...success:', arr);
				 let msg ="";
				    for (var i = 0; i < arr.length; i++) {
				    	  msg += `
					    	    <tr>
				    		  <td><a href="selectOne.do?num=\${arr[i].num}">\${arr[i].num}</a></td>
		 		    	      <td>\${arr[i].nick_name}</td>
		 		    	      <td>\${arr[i].email}</td>
		 		    	      <td>\${arr[i].address}</td>
		 		    	      <td>\${arr[i].pw}</td>
		 		    	      <td>\${arr[i].grade}</td>
		 		    	      <td>\${arr[i].gender}</td>
		 		    	      <td>\${arr[i].food_like}</td>
		 		    	      <td><button class="gradeBtn\${arr[i].num}" onclick=upgrade(this)>관리자설정</button></td>
		 		    	      <td><button class="deleteBtn\${arr[i].num}" onclick=byeOK(this)>강제탈퇴</button></td>
				    	    </tr>`;
				    }
				$("#vos").html(msg);
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}
	
function upgrade(button) {
	  let buttonClass = $(button).attr('class');
	  console.log(buttonClass);
	  let num = buttonClass.match(/\d+/)[0];
	  console.log(num);
	  
	  $.ajax({
	    url: 'json/upgradeOK.do',
	    method: 'POST',
	    data: {
	    	num : num,
	    	grade : 1
	    },
	    dataType: 'json',
	    success: function(obj) {
			console.log('ajax...success:', obj);
			console.log('ajax...success:', obj.result);
			let msg = '';
			if (obj.result === 'OK') {
				msg = '관리자 설정이 완료되었습니다.';
				location.reload();
			} else {
				msg = '관리자 설정에 실패했습니다.';
			}
			alert(msg);
		},
	    error: function(xhr, status, error) {
			console.log('xhr.status:', xhr.status);
	    }
	});
};
function byeOK(button) {
	  let buttonClass = $(button).attr('class');
	  let num = buttonClass.match(/\d+/)[0];
	  
	  $.ajax({
	    url: 'json/deleteOK.do',
	    method: 'POST',
	    data: {
	    	num : num
	    },
	    dataType: 'json',
	    success: function(obj) {
			console.log('ajax...success:', obj);
			console.log('ajax...success:', obj.result);
			let msg = '';
			if (obj.result === 'OK') {
				msg = '강제 탈퇴가 완료되었습니다.';
				location.reload();
			} else {
				msg = '강제 탈퇴에 실패했습니다.';
			}
			alert(msg);
		},
	    error: function(xhr, status, error) {
			console.log('xhr.status:', xhr.status);
	    }
	});
};
</script>
</head>
<body>
	<h1>회원목록</h1>
	<select name="searchKey" id="searchKey">
		<option value="NICK_NAME">닉네임</option>
		<option value="EMAIL">이메일</option>
	</select>
	<input type="text" name="searchWord" id="searchWord">
	<button onclick="searchList()">검색</button>

	<table border="1">
		<thead>
			<tr>
				<th>num</th>
				<th>nick_name</th>
				<th>email</th>
				<th>address</th>
				<th>pw</th>
				<th>grade</th>
				<th>gender</th>
				<th>foodlike</th>
				<th>등업</th>
				<th>강탈</th>
			</tr>
		</thead>
		<tbody id="vos">

		</tbody>
		<tfoot>
			<tr>
				<td colspan="10">1 2 3 4 5</td>
			</tr>
		</tfoot>
	</table>
</body>
</html>



