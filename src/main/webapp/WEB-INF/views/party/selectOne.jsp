<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임정보</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/selectOne.css?after" >
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
				if (vo.status===1) {
							
					tag_OK +=`
						<div class="app-date">
							<div class="appImpo">
								<img width="50px" src="../resources/ProfileImage/${vo.writerNum}"
								onerror="this.src='../resources/ProfileImage/default.png'">
								<div>
									<div class="app-name">\${vo.userName}</div>
									<div class="app-comments">\${vo.comments}</div>
								</div>
							</div>
						</div>
					`;
				}

				if (vo.status===0) { // user_id
					let tag_div = ``;
					if(${num}==vo.userNum){ //'${user_id}'===vo.userNum
						tag_div = `<div>
							<button class="delete-bt" onclick="deleteOK(\${vo.applicantsNum})">신청취소</button>
						</div>`;
					}

					if(${num}===${vo2.writerNum}){ //'${user_id}'===vo.userNum
						tag_div = `<div>
							<button class="app-ok" type="button" onclick="approveOK(\${vo.applicantsNum})">승인</button>
							<button class="app-no" type="button" onclick="rejectOK(\${vo.applicantsNum})">거절</button>
						</div>`;
					}

					tag_NotOK +=`
						<div class="app-date">
						<div class="appImpo">
							<img width="50px" src="../resources/ProfileImage/${vo.writerNum}"
							onerror="this.src='../resources/ProfileImage/default.png'">
							<div>
								<div class="app-name">\${vo.userName}</div>
								<div class="app-comments">\${vo.comments}</div>
							</div>
							\${tag_div}
						</div>
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
	        		userNum : ${num},// ${param.userNum}
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
				if(obj.result==1) par_approveOK(partyNum='${param.partyNum}')
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				}
			});
		confirm("승인이 완료되었습니다")
		return;
	  }
}//end approveOK

function par_approveOK(partyNum=0) {
	console.log('par_approveOK()....',partyNum);
	$.ajax({
		url : "json/approveOK.do",
		data:{
			partyNum:partyNum
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
	<fmt:parseDate var="newDeadLine" value="${vo2.deadLine}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
	<fmt:formatDate var="deadLine" value="${newDeadLine}" pattern="yyyy-MM-dd HH:mm" />
	<fmt:parseDate var="newTimeLimit" value="${vo2.timeLimit}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
	<fmt:formatDate var="timeLimit" value="${newTimeLimit}" pattern="yyyy-MM-dd HH:mm" />
	<fmt:parseDate var="newWdate" value="${vo2.wdate}"  pattern="yyyy-MM-dd HH:mm:ss.SSS" />
	<fmt:formatDate var="wdate" value="${newWdate}" pattern="yyyy-MM-dd HH:mm" />
	
	<div class="body">
		<div class="application">
			<div class="title">
				<div class="par-title">${vo2.title}</div>
			</div>
			<div class="writerImpo">
				<div><img width="60px" src="../resources/ProfileImage/${vo2.writerNum}" onerror="this.src='../resources/ProfileImage/default.png'"></div>
				<div class="par-name"><a href="/hotplace/userpage.do?num=${vo2.writerNum}">${vo2.writerName}</a></div>
				<div>
					<div class="par-views">${vo2.views}</div>
					<div class="par-wdate">작성일 ${wdate}</div>
				</div>
			</div>
			<div class="par-row">
				<div class="par-cell">모집인원</div>
				<div class="par-date">${vo2.applicants}/${vo2.max}명</div>
			</div>
			<div class="par-row">
				<div class="par-cell">모집마감일</div>
				<div class="par-date">${deadLine}</div>
			</div>
			<div class="par-row">
				<div class="par-cell">식당</div>
				<div class="par-date">${vo2.place}</div>
			</div>
			<div class="par-row">
				<div class="par-cell">모임날짜</div>
				<div class="par-date">${timeLimit}</div>
			</div>
			<div class="par-content">${vo2.content}</div>
			
			<div class="par_button">
				<button class="par-update" onclick="location.href='update.do?partyNum=${param.partyNum}'">수정</button>
				<button class="par-delete" id="delButton">삭제</button>
			</div>
		</div>
		
		<div class="app_title">승인된 구성원</div>
		<div id="app_OK"></div>

		<div class="app_title">대기중인 구성원</div>
		<div id="app_NotOK"></div>
		
		<div>
			<div class="insert_form">
				<textarea name="comments" id="comments" placeholder="간단한 자기소개를 해주세요 (필수)"
				onfocus="this.placeholder=''" onblur="this.placeholder='간단한 자기소개를 해주세요 (필수)'" 
				class="textarea"></textarea>
				<button class="input-bt" onclick="insertOK()">신청하기</button>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		if("${vo2.writerNum}"=="${num}"){
			$('.insert_form').css("display", "none");
		}

		if("${vo2.writerNum}"!="${num}"){
			$('.par_button').css("display", "none");
		}
	</script>
</body>
</html>