<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	$('#delButton').click(function(){
		if(confirm("글을 삭제하시겠습니까?")){
			location.href="deleteOK.do?partyNum=${param.partyNum}"
		}
	}); // end click
});

function app_selectAll(applicantsNum=0){
	console.log('app_selectAll()....');
	console.log('writerNum....',${vo2.writerNum});
	console.log(${param.partyNum});

	$.ajax({
		url: "json/AppselectAll.do",
		data:{
			partyNum : ${param.partyNum},
		},
		method: 'GET',	
		dataType: 'json',
		success: function(arr){
			console.log('ajax...',arr);
			let tag_OK = '';
			let tag_NotOK = '';
			
			$.each(arr, function(index, vo){
				console.log('vo...',vo);
				console.log('status...',vo.status);
				if (vo.status===1) { // user_id
// 				<img width="100px" src="../resources/ProfileImage/${vo2.writerNum}"
// 							onerror="this.src='../resources/ProfileImage/default.png'">
					tag_OK +=`
						<div>
							<div>\${vo.userName}</div>
							<div>\${vo.comments}</div>
						</div>
					`;
				}

				if (vo.status===0) { // user_id
// 				<img width="100px" src="../resources/ProfileImage/${vo2.writerNum}"
// 							onerror="this.src='../resources/ProfileImage/default.png'">

					let tag_div = ``;
// 					if(3==vo.userNum){ //'${user_id}'===vo.userNum
// 						tag_div = `<div>
// 							<button type="button" onclick="deleteOK(\${vo.applicantsNum})">신청취소</button>
// 						</div>`;
// 					}

					if(10===${vo2.writerNum}){ //'${user_id}'===vo.userNum
						tag_div = `<div>
							<button type="button" onclick="approveOK(\${vo.applicantsNum})">승인</button>
							<button type="button" onclick="rejectOK(\${vo.applicantsNum})">거절</button>
						</div>`;
					}

					tag_NotOK +=`
						<div>
							<div>\${vo.userName}</div>
							<div>\${vo.comments}</div>
							\${tag_div}
						</div>
					`;
					
				}
				
			}); // end for-each
				
			$('#app_NotOK').html(tag_NotOK);
			$('#app_OK').html(tag_OK);
			
		}, // end success
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		} // end error
	}); // end ajax;
};// end app_selectAll

function insertOK() {
	
	if (confirm("신청하시겠습니까?")) {
		   console.log('insertOK()....');
	       console.log($('#comments').val());
	       $.ajax({
	           url: "json/AppinsertOK.do",
	           data: {
	        		partyNum : ${param.partyNum},
	        		userNum : 3,// ${param.userNum}
	               comments: $('#comments').val()
	           },
	           method: 'POST',
	           dataType: 'json',
	           success: function(obj) {
	               console.log('ajax...success:', obj);
	               if(obj.result==1) {
						let url='selectOne.do?partyNum=${param.partyNum}';
						location.replace(url);
					}
	           },
	           error: function(xhr, status, error) {
	               console.log('xhr.status:', xhr.status);
	           }
	       });
	       confirm("신청이 완료되었습니다")
	       return;
	  }
	
	
	
	
    
}//end insertOK

function deleteOK(applicantsNum=0) {
	
	console.log('deleteOK()....',applicantsNum);
	
	if (confirm("신청 취소하시겠습니까?")) {
		$.ajax({
			url : "json/deleteOK.do",
			data:{
				applicantsNum:applicantsNum
			},
			method:'GET',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				if(obj.result==1) {
					let url='selectOne.do?partyNum=${param.partyNum}';
					location.replace(url);
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				}
			});
		confirm("취소가 완료되었습니다")
		return;
	  }
}//end deleteOK

function approveOK(applicantsNum=0) {
	console.log('approveOK()....',applicantsNum);
	
	if (confirm("승인하시겠습니까?")) {
		$.ajax({
			url : "json/AppapproveOK.do",
			data:{
				applicantsNum:applicantsNum
			},
			method:'POST',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				if(obj.result==1) par_approveOK(applicantsNum='\${vo.applicantsNum}')
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				}
			});
		confirm("승인이 완료되었습니다")
		return;
	  }
}//end approveOK

function par_approveOK(applicantsNum=0) {
	console.log('par_approveOK()....',applicantsNum);
	
	$.ajax({
		url : "approveOK.do",
		data:{
			applicantsNum:applicantsNum
		},
		method:'POST',
		dataType:'json',
		success : function(obj) {
			console.log('ajax...success:', obj);
			if(obj.result==1) {
				let url='selectOne.do?partyNum=${param.partyNum}';
				location.replace(url);
			}
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
			}
		});
}//end approveOK

function rejectOK(applicantsNum=0) {
	console.log('rejectOK()....',applicantsNum);
	
	if (confirm("거절하시겠습니까?")) {
		$.ajax({
			url : "json/ApprejectOK.do",
			data:{
				applicantsNum:applicantsNum
			},
			method:'POST',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				if(obj.result==1) {
					let url='selectOne.do?partyNum=${param.partyNum}';
					location.replace(url);
				}
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				}
			});
		confirm("거절이 완료되었습니다")
		return;
	  }
}//end rejectOK




</script>
</head>
<body onload="app_selectAll()">
	<h1>모임정보</h1>

		<div>(status)</div>
		
		<div>${vo2.title}(제목)</div>
		
		<div>
			<img width="100px" src="../resources/ProfileImage/${vo2.writerNum}"
						onerror="this.src='../resources/ProfileImage/default.png'">
			<div>${vo2.writerName}(작성자)</div>
		</div>

		
		<div>
			<div>${vo2.wdate}(작성일)</div>
			<div>조회수 : ${vo2.views}</div>
		</div>
		<div>
			<div>모집인원 : ${vo2.applicants}/${vo2.max} 명</div>
			<div>모집마감일 : ${vo2.deadLine}</div>
			<div>식당 : ${vo2.place}</div>
			<div>모집날짜 : ${vo2.timeLimit}</div>
		</div>
		
		<div>${vo2.content}(내용)</div>
	<div>
		<button type="button"
			onclick="location.href='update.do?partyNum=${param.partyNum}'">수정</button>
		<button type="button" id="delButton">삭제</button>
	</div>
	
	<div id="app_OK">승인된 구성원</div>
	<hr>
	<div id="app_NotOK">대기중인 구성원</div>
	
	<div>
		<div id="insert_form">
			<textarea name="comments" id="comments" placeholder="간단한 자기소개를 해주세요 (필수)"
			onfocus="this.placeholder=''" onblur="this.placeholder='간단한 자기소개를 해주세요 (필수)'" 
			style="resize: none; width: 80%; height: 100px;"></textarea>
			<button onclick="insertOK()">신청하기</button>
		</div>
	</div>
	
	
	
</body>
</html>