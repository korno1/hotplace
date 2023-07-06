<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member/selectAll.css">
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
			  
			  window.changePage = function(button) {
			    let buttonClass = $(button).attr('class').split(' ')[1];
			    if (buttonClass === 'prev') {
			      page = page - 1;
			      console.log('page is...', page);
			    } else if (buttonClass === 'next') {
			      page = page + 1;
			      console.log('page is...', page);
			    }
			    searchList();
			  }
			  
			  $('#searchButton').click(function() {
				    searchList();
				});

			  function searchList() {
			    console.log('searchList()...');

			    $.ajax({
			      url: "json/selectAll.do",
			      data: {
			        searchKey: $("#searchKey").val(),
			        searchWord: $("#searchWord").val(),
			        page: page
			      },
			      method: 'GET',
			      dataType: 'json',
			      success: function(arr) {
			        console.log('ajax...success:', arr);
			        let msg = "";
			        for (let i = 0; i < arr.vos.length; i++) {
			          msg += `
			            <tr>
			              <td><a href="selectOne.do?num=\${arr.vos[i].num}">\${arr.vos[i].num}</a></td>
			              <td>\${arr.vos[i].nick_name}</td>
			              <td>\${arr.vos[i].email}</td>
			              <td>\${arr.vos[i].address}</td>
			              <td>\${arr.vos[i].pw}</td>
			              <td>\${arr.vos[i].grade === 0 ? '회원' : arr.vos[i].grade === 1 ? '관리자' : arr.vos[i].grade === 2 ?'점주':''}</td>
			              <td>\${arr.vos[i].gender=== 0 ? '남자' : arr.vos[i].gender === 1 ?'여자': arr.vos[i].gender === 2 ?'비공개':''}</td>
			              <td>\${arr.vos[i].food_like}</td>
			              <td><button class="gradeBtn\${arr.vos[i].num}" onclick="openModal(this)">등급 변경</button></td>
			              <td><button class="deleteBtn\${arr.vos[i].num}" onclick="byeOK(this)">강제탈퇴</button></td>
			              <td><button class="insertMailBtn\${arr.vos[i].num}" onclick="insertMail(this)">쪽지발송</button></td>
			            </tr>`;
			        }
			        $("#vos").html(msg);

			        if (arr.isLast === true) {
			          $(".next").css("display", "none");
			        } else {
			          $(".next").css("display", "block");
			        }

			        if (page === 1) {
			          $(".prev").css("display", "none");
			        } else {
			          $(".prev").css("display", "block");
			        }
			      },
			      error: function(xhr, status, error) {
			        console.log('xhr.status:', xhr.status);
			      }
			    });
			  }
			  
			  // 초기 검색 실행
			  searchList();
			});

function insertMail(button) {
	  let buttonClass = $(button).attr('class');
	  let num = buttonClass.match(/\d+/)[0];

	  let width = 840; // 팝업창의 너비
	  let height = 700; // 팝업창의 높이

	  // 브라우저 사이즈 측정
	  let screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
	  let screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

	  // 팝업창 위치 계산
	  let left = (screenWidth - width) / 2;
	  let top = (screenHeight - height) / 2;

	  // 팝업창 열기
	  window.open('../mail/insert.do?num=' + num, 'Popup', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top + ',resizable=no');
}
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
	<button id="searchButton">검색</button>

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
				<th>쪽지</th>
			</tr>
		</thead>
		<tbody id="vos">

		</tbody>
	</table>
	<div class="pagegation block">
		<div class="pagegation__prev prev" onclick="changePage(this)">이전</div>
		<div class="pagegation__next next" onclick="changePage(this)">다음</div>
	</div>

	<!-- 모달 창 -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2>관리자 설정</h2>
			<p>
				<label> <input type="radio" name="userType" value="0">
					일반
				</label> <label> <input type="radio" name="userType" value="1">
					관리자
				</label> <label> <input type="radio" name="userType" value="2">
					점주
				</label>
			</p>
			<button id="confirmBtn">확인</button>
		</div>
	</div>
</body>
<script type="text/javascript">
//모달 열기
function openModal(button) {
  var modal = document.getElementById("myModal");
  var buttonClass = button.getAttribute("class");
  var num = buttonClass.match(/\d+/)[0];
  modal.style.display = "block";

  // 확인 버튼 클릭 이벤트 리스너
  var confirmBtn = document.getElementById("confirmBtn");
  confirmBtn.addEventListener("click", function() {
    var userType = document.querySelector('input[name="userType"]:checked').value;
    upgrade(num, userType);
    closeModal();
  });
}

// 모달 닫기
function closeModal() {
  var modal = document.getElementById("myModal");
  modal.style.display = "none";
}

// 모달 닫기 버튼에 이벤트 리스너 추가
var closeBtn = document.getElementsByClassName("close")[0];
closeBtn.addEventListener("click", closeModal);

function upgrade(num, userType) {
	  $.ajax({
	    url: 'json/upgradeOK.do',
	    method: 'POST',
	    data: {
	    	num : num,
	    	grade : userType
	    },
	    dataType: 'json',
	    success: function(obj) {
			console.log('ajax...success:', obj);
			console.log('ajax...success:', obj.result);
			let msg = '';
			if (obj.result === 'OK') {
				msg = '등급이 변경되었습니다.';
				location.reload();
			} else {
				msg = '등급이 변경을 실패했습니다.';
			}
			alert(msg);
		},
	    error: function(xhr, status, error) {
			console.log('xhr.status:', xhr.status);
	    }
	});
};
</script>
</html>



