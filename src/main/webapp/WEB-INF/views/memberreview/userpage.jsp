<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저페이지</title>
<link rel="stylesheet" href="/hotplace/resources/css/memberreview/userpage.css"/>
<link rel="stylesheet" href="/hotplace/resources/css/party/selectAll.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">


$(function(){
	console.log('onload...');
	let searchKey = 'title';
	let page = 1;
	
	console.log(page);
	console.log(searchKey);
	
	$('#searchWord').val("${param.searchWord}");
	$.ajax({
		url: "party/json/searchList.do",
		data:{
			searchKey: "title", // ${param.searchKey}
			searchWord: "${param.searchWord}",
			page: 1, //${param.page}
		},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			console.log('ajax...',arr);
			let tag_vos = '';
			
			$.each(arr, function(index, vo){
				if (vo.writerNum === 3) { // user_id
					tag_vos +=`
						<div onclick="location.href='party/selectOne.do?partyNum=\${vo.partyNum}'" class="post">
							<div>\${vo.applicants}/\${vo.max}</div>
							<hr>
							<div>마감일 : \${vo.deadLine}</div>
							<div>[\${vo.place}] \${vo.title}</div>
							<div>조회수: \${vo.views}</div>
							<hr>
							<div>작성자 : ${vo.writerName}</div>
						</div>
					`;
				}
			}); // end for-each
			
			let pr_nx = `
					<button id="back_page">이전</button>
					<button id="next_page">다음</button>
				`;
			
// 			let count = 1;
// 			if(page===1){
// 				$('#back_page').hide();
// 					return false;
// 			}
				
// 			if((page*6) >= count){
// 				 $('#next_page').hide();
// 					return false;
// 			}
// 			$(document).on('click', '#back_page', function(e) {
// 		    e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막습니다.
// 		    // 이전 페이지 번호 계산
// 		    let previousPage = parseInt(page) - 1;
// 		    page = previousPage;
// 		    let searchKey = $('#searchKey').val();
// 		    // 업데이트된 페이지 파라미터로 AJAX 요청 수행
// 		    loadPage(previousPage);
// 		  });
		 
// 			$(document).on('click', '#next_page', function(e) {
// 				 e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막습니다.
// 				    // 다음 페이지 번호 계산
// 			    let nextPage = parseInt(page) + 1;
// 				page = nextPage;
				
// 				let searchKey = $('#searchKey').val();
// 				    // 업데이트된 페이지 파라미터로 AJAX 요청 수행
// 			    loadPage(nextPage);
// 			  });
				
			$('#par_vos').html(tag_vos);
			$('#par_page').html(pr_nx);
			
			
		}, // end success
		
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		} // end error
	}); // end searchList ajax;
	
	  $('#par_vos').show();
	  $('#memberreview_list').hide();
	  document.getElementById("formContainer").style.display = "none";

}); // end onload	

	
// 	function searchList(){
// 		let sKey = $('#searchKey').val();
// 		let sWord = $('#searchWord').val();
// 		console.log('skey:', sKey);
// 		console.log('sWord:', sWord);
// 		let url = 'selectAll.do?searchKey=' + sKey + "&searchWord=" + sWord + "&page=1";
// 		location.replace(url);
// 	}; // end searchList

	function mre_selectAll(user_num=3, memberreview_num=0){ // ${param.memberreview_num}
		console.log('mer_selectAll()....user_num:',user_num);
		console.log('mer_selectAll()....memverreview_num:',memberreview_num);
		
		$('#par_vos').hide(); // 모임리스트 요소를 숨기도록 설정
		$('#memberreview_list').show();
		document.getElementById("formContainer").style.display = "block";
		
		$('#insertButton').show();
		$.ajax({
			url : "memberreview/json/selectAll.do",
			data:{
				user_num:3 // ${param.user_num}
			},
			method:'GET',
			dataType:'json',
			success : function(vos) {
// 				console.log('ajax...success:', vos);
	
				let tag_txt = '';
				
				$.each(vos,function(index,vo){
					console.log('ajax...success:', vo);
					let tag_td = `<div class="board-cell">\${vo.content}</div>`;
					
					let ratedValue = parseInt(vo.rated);
					console.log('vo.rated:', vo.rated);

					let tag_rated = `
				        <div id="starRating" class="board-cell">
			            <ul class="star-rating"  data-rating="\${ratedValue}">
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			            </ul>
			        </div>`;
			       
					// user_num==vo.user_num
					if(memberreview_num==vo.memberreview_num) {
						tag_td = `<div class="board-cell"><input type="text" value="\${vo.content}" id="input_content"><button onclick="updateOK(\${vo.memberreview_num})">수정완료</button></div>`;
						tag_rated = `
					        <div id="starRating">
				            <ul class="star-rating"  data-rating="\${ratedValue}">
				                <li class="star fa fa-star" data-rating="1"></li>
				                <li class="star fa fa-star" data-rating="2"></li>
				                <li class="star fa fa-star" data-rating="3"></li>
				                <li class="star fa fa-star" data-rating="4"></li>
				                <li class="star fa fa-star" data-rating="5"></li>
				            </ul>
				        </div>`;
						$(document).ready(function() {
				            $('.star-rating .star').click(function() {
				              var rating = $(this).attr('data-rating');
				              $('.star-rating .star').removeClass('active');
				              $(this).prevAll().addBack().addClass('active');
				              console.log('별점: ' + rating);
				              $('#mre_rated').val(rating); // input2 폼에 선택한 별점 값 설
				            });
				          });

				        isFormInserted = true;
					}
					
					
					let tag_div = ``;
					if(6==vo.writer_num){ //'${user_id}'===vo.writer_num
						tag_div = `<div>
							<button onclick="mre_selectAll(\${vo.user_num},\${vo.memberreview_num})">수정</button>
							<button type="button" onclick="deleteOK(\${vo.memberreview_num})">삭제</button>
						</div>`;

					}

// 							<img width="20px" src="../resources/ProfileImage/\${vo.writer_num}"
// 							onerror="this.src='../resources/ProfileImage/default.png'">
					tag_txt += `
						<div class="board">
							<div class="board-row">
								<div class="board-cell">\${vo.writer_num}</div>
								<div class="board-cell">\${vo.writer_name}</div>
								\${tag_rated}
								<div class="board-cell">\${vo.wdate}</div>
							</div>
							<div class="board-content">
								\${tag_td}
								<div colspan="3" class="board-content-cell">\${tag_div}</div>
							</div>
						</div>
					`;
				});//end ajax
				
				$('#memberreview_list').html(tag_txt);
				$('#insertButton').show();
				
// 				// 별점 채우기
				$('.star-rating').each(function() {
				  var ratedValue = parseInt($(this).data('rating'));
				  var stars = $(this).find('.star');
				  for (var i = 0; i < ratedValue; i++) {
				    $(stars[i]).addClass('active');
				  }
				});
				
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
	}// end mre_selectAll
	
	
	
	
	
	
	
	
	
	let isFormInserted = false;

	function insert() {
	    if (!isFormInserted) {
			$('#par_vos').hide();
			$('#memberreview_list').hide();
	    	
	        // 폼을 감싸는 부모 요소 생성
	        var formContainer = $('<div id="formContainer"></div>');

	        var form = $(`
	        		  <form class="insert-form">
	        		    <ul class="star-rating">
	        		      <li class="star fa fa-star" data-rating="1"></li>
	        		      <li class="star fa fa-star" data-rating="2"></li>
	        		      <li class="star fa fa-star" data-rating="3"></li>
	        		      <li class="star fa fa-star" data-rating="4"></li>
	        		      <li class="star fa fa-star" data-rating="5"></li>
	        		    </ul>
	        		    <input type="text" name="content" id="mre_content">
	        		    <input type="hidden" name="rated" id="mre_rated">
	        		    <button onclick="insertOK()">작성완료</button>
	        		  </form>
	        		`);

	        formContainer.append(form);
	        formContainer.addClass('show-star-rating');

	        // 기존 폼을 제거하고 새로운 폼으로 교체
	        $('#formContainer').replaceWith(formContainer);
	        
	        $(document).ready(function() {
	            $('.star-rating .star').click(function() {
	              var rating = $(this).attr('data-rating');
	              $('.star-rating .star').removeClass('active');
	              $(this).prevAll().addBack().addClass('active');
	              console.log('별점: ' + rating);
	              $('#mre_rated').val(rating); // input2 폼에 선택한 별점 값 설
	            });
	          });

	        isFormInserted = true;
	    }else {
	    	// 초기화 작업 수행
	    	$('#formContainer').replaceWith(formContainer);
	        $('#par_vos').show();
	        $('#memberreview_list').show();
	        $('.insert-form').remove();
	        isFormInserted = false;
	    }
	}//end insert


// 	let isFormInserted = false;

// 	function insert() {
// 	    if (!isFormInserted) {
// 			$('#par_vos').hide();
// 			$('#memberreview_list').hide();
	    	
// 	        // 폼을 감싸는 부모 요소 생성
// 	        var formContainer = $('<div id="formContainer"></div>');

// 	        var form = $('<form></form>');
// 	        form.attr('class', 'insert-from');

// 	        var starRating = $('<ul class="star-rating">' +
// 	            '<li class="star fa fa-star" data-rating="1"></li>' +
// 	            '<li class="star fa fa-star" data-rating="2"></li>' +
// 	            '<li class="star fa fa-star" data-rating="3"></li>' +
// 	            '<li class="star fa fa-star" data-rating="4"></li>' +
// 	            '<li class="star fa fa-star" data-rating="5"></li>' +
// 	            '</ul>');
	        
// 	        var input1 = $('<input>');
// 	        input1.attr('type', 'text');
// 	        input1.attr('name', 'content');
// 	        input1.attr('id', 'mre_content');

// 	        var input2 = $('<input>');
// 	        input2.attr('type', 'hidden'); // 숨김 필드로 변경
// 	        input2.attr('name', 'rated');
// 	        input2.attr('id', 'mre_rated');


// 	        var button = $('<button></button>');
// 	        button.attr('onclick', "insertOK()");
// 	        button.text('작성완료');

// 	        form.append(input1);
// 	        form.append(input2);
// 	        form.append(starRating);
// 	        form.append(button);

// 	        formContainer.append(form);
// 	        formContainer.addClass('show-star-rating');

// 	        // 기존 폼을 제거하고 새로운 폼으로 교체
// 	        $('#formContainer').replaceWith(formContainer);
	        
// 	        $(document).ready(function() {
// 	            $('.star-rating .star').click(function() {
// 	              var rating = $(this).attr('data-rating');
// 	              $('.star-rating .star').removeClass('active');
// 	              $(this).prevAll().addBack().addClass('active');
// 	              console.log('별점: ' + rating);
// 	              $('#mre_rated').val(rating); // input2 폼에 선택한 별점 값 설
// 	            });
// 	          });

// 	        isFormInserted = true;
// 	    }
// 	}//end insert

	function insertOK() {
	    if (isFormInserted) {
	        $('form').on('submit', function(event) {
	            event.preventDefault();
	        });

	        console.log('insertOK()....');
	        console.log($('#mre_content').val());
	        $.ajax({
	            url: "memberreview/json/insertOK.do",
	            data: {
	                party_num: 9,
	                user_num: 3,
	                writer_num: 6,
	                rated: $('#mre_rated').val(),
	                content: $('#mre_content').val()
	            },
	            method: 'POST',
	            dataType: 'json',
	            success: function(obj) {
	                console.log('ajax...success:', obj);
	                if (obj.result == 1) {
	                    mre_selectAll(user_num='\${vo.user_num}');
	                    isFormInserted = false; // 폼이 초기화되면 false로 설정하여 다시 작성 버튼이 나타날 수 있도록 함
	                    $('#formContainer').replaceWith('<div id="formContainer"></div>');
	                    // 기존 폼으로 돌아감
	                    var insertButton = $('<button></button>');
	                    insertButton.attr('onclick', "insert()");
	                    insertButton.text('작성');
	                    $('#formContainer').append(insertButton);
	                }
	            },
	            error: function(xhr, status, error) {
	                console.log('xhr.status:', xhr.status);
	            }
	        });
	        
		    $('#mre_content').val(''); // input 폼 초기화
		    $('#mre_rated').val(''); // input 폼 초기화
		    
	    }
	}//end insertOK


	
	
	function updateOK(memberreview_num=0){
		console.log('updateOK()....',memberreview_num);
		console.log($('#starRating').val());
		
		let rated = $('.star-rating .star.active').last().data('rating');
		
		$.ajax({
			url : "memberreview/json/updateOK.do",
			data:{
				memberreview_num:memberreview_num,
				content: $('#input_content').val(),
				rated: rated
			},
			method:'POST',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				if(obj.result==1) mre_selectAll(user_num='\${vo.user_num}');
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
		
	}//end updateOK
	
	function deleteOK(memberreview_num=0){
		console.log('deleteOK()....',memberreview_num);
		
	  if (confirm("글을 삭제하시겠습니까?")) {
		  $.ajax({
				url : "memberreview/json/deleteOK.do",
				data:{
					memberreview_num:memberreview_num
				},
				method:'GET',
				dataType:'json',
				success : function(obj) {
					console.log('ajax...success:', obj);
					if(obj.result==1) mre_selectAll(user_num='\${vo.user_num}');
				},
				error:function(xhr,status,error){
					console.log('xhr.status:', xhr.status);
				}
			});
		    return;
		  }
	}//end deleteOK
	
	function par_selectAll(){
		$('#par_vos').show(); // 모임리스트 요소를 보이도록 설정
		$('#memberreview_list').hide();
		document.getElementById("formContainer").style.display = "none";
		
		$(function() {
			console.log('onload...');
			
			let searchKey = 'title';
			let page = 1;
			
			console.log(page);
			console.log(searchKey);
			
			$('#searchWord').val("${param.searchWord}");
			$.ajax({
				url: "party/json/searchList.do",
				data:{
					searchKey: "title", // ${param.searchKey}
					searchWord: "${param.searchWord}",
					page: 1, //${param.page}
				},
				method: 'GET',
				dataType: 'json',
				success: function(arr){
					console.log('ajax...',arr);
					let tag_vos = '';
					
					$.each(arr, function(index, vo){
						if (vo.writerNum === 3) { // user_id
							tag_vos +=`
								<div onclick="location.href='party/selectOne.do?partyNum=\${vo.partyNum}'" class="post">
									<div>\${vo.applicants}/\${vo.max}</div>
									<hr>
									<div>마감일 : \${vo.deadLine}</div>
									<div>[\${vo.place}] \${vo.title}</div>
									<div>조회수: \${vo.views}</div>
									<hr>
									<div>작성자 : ${vo.writerName}</div>
								</div>
							`;
						}
						
					}); // end for-each
					$('#par_vos').html(tag_vos);
					
				}, // end success
				
				error:function(xhr,status,error){
					console.log('xhr.status:', xhr.status);
				} // end error
			}); // end searchList ajax;
			
//		 	$.ajax({
//	 		url: "party/json/selectAll.do",
//	 		data:{
//	 			searchKey: "${param.searchKey}",
//	 			searchWord: "${param.searchWord}",
//	 		},
//	 		method: 'GET',
//	 		dataType: 'json',
//	 		success: function(cnt){
//	 			console.log('ajax...',cnt);
//	 			if(${param.page}==1){
	// //	 			$('#pre_page').hide();
//	 				$('#pre_page').click(function(){
//	 					alert('첫번째 페이지입니다.');
//	 					return false;
//	 				});
//	 			}
//	 			if((${param.page}*5) >= cnt){
	// //	 			$('#next_page').hide();
//	 				$('#next_page').click(function(){
//	 					alert('마지막 페이지입니다.');
//	 					return false;
//	 				});
//	 			}

//	 		}, // end success
			
//	 		error:function(xhr,status,error){
//	 			console.log('xhr.status:', xhr.status);
				
//	 		} // end error
//	 	}); // end selectAll ajax;
			
		  });
	}
	
	
</script>
</head>
<body>
	
	<ul>
		<li><a href="my.do">HOME</a></li>
	</ul>
<!-- 	<div> -->
<!-- 		<img width="20px" src="hotplace/resources/ProfileImage/default.png" onerror="this.src='../resources/ProfileImage/default.png'"> -->
<!-- 	</div> -->
	
	
	<a href="#" onclick="par_selectAll()">모임리스트</a>
	<a href="#" onclick="mre_selectAll()" id="reviewLink">후기목록</a>
		
	<hr>	
<!-- 	<button onclick="myParty">내 모임 확인</button> -->
	
	
	<div id="par_vos"></div>
	<div id="par_page"></div>
	
	<div id="memberreview_list"></div>
	
	
	<div id="formContainer"><button onclick="insert()">작성</button></div>
	<hr>
	
	
</body>
</html>



