<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저페이지</title>
<link rel="stylesheet" href="/hotplace//resources/css/memberreview/userpage.css" />
<link rel="stylesheet" href="/hotplace/resources/css/memberreview/userpage_json.css" />
<link rel="stylesheet" href="/hotplace/resources/css/party/selectAll.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

let page =1;
let mrePage = 1;
let par_count; // 게시글 개수
let mer_count; // 게시글 개수

$(function(){
	console.log('onload...');
	
	$.ajax({
		url: "party/json/selectAll.do",
		data:{
			writerNum : ${param.num},
			page: page, //${param.page}
		},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			console.log('ajax...',arr);
			let tag_vos = '';
			
			$.each(arr, function(index, vo){
				if (vo.writerNum === ${vo2.num}) { // user_id
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

			$(".par_paging").css("display", "block");
			$(".mre_paging").css("display", "none");
			$('#par_vos').html(tag_vos);
		}, // end success
		
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		} // end error
	}); // end ajax;
	  
	function par_totalCount(){ // 게시글 개수 계산
		console.log('par_totalCount...');
		$.ajax({
			url: "party/json/par_totalCount.do",
			data:{
				writerNum : ${param.num}
			},
			method: 'GET',
			dataType: 'json',
			success: function(cnt){
				console.log('cnt...',cnt);
	            par_count = cnt;
			}, // end success
			
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
				
			} // end error
		}) // end ajax;	
	};
	par_totalCount();
	
	$(document).on('click', '#par_back_page', function(e) { // 이전 버튼 클릭 시 동작
	    e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막음.
		if(page==1){ // 첫번째 페이지에서 팝업 경고창
			alert('첫 페이지입니다.');
			return false;
		}
	    // 이전 페이지 번호 계산
	    let previousPage = parseInt(page) - 1;
	    page = previousPage;
		console.log('par_count',par_count);
	    
	 	// parameter 수정 후 페이지 다시 로드
	    par_selectAll(previousPage);
	});
 
	$(document).on('click', '#par_next_page', function(e) {
// 		console.log('page...',page);
		console.log('par_count',par_count);
		e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막음.
		if((page*6) >= par_count){ // 마지막 페이지에서 팝업 경고창
			alert('마지막 페이지입니다.');
			return false;
		}
		// 다음 페이지 번호 계산
	    let nextPage = parseInt(page) + 1;
		page = nextPage;
		console.log('page...',page);
		
		// parameter 수정 후 페이지 다시 로드
	    par_selectAll(nextPage);
	});	

}); // end onload	


function mre_selectAll(memberreviewNum=0, mrePage){ // ${param.memberreviewNum} 
// 	console.log('mer_selectAll()....userNum:',userNum);
// 	console.log('mer_selectAll()....memverreviewNum:',memberreviewNum);
	
	$('#par_vos').hide(); // 모임리스트 요소를 숨기도록 설정
	$('#memberreview_list').show();
	$('#insertButton').show();

	$.ajax({
		url : "memberreview/json/selectAll.do",
		data:{
			userNum:${vo2.num}, // ${param.userNum}
			page: mrePage, //${param.page}
		},
		method:'GET',
		dataType:'json',
		success : function(vos) {
			console.log('ajax...success:', vos);

			let tag_txt = '';
			
			$.each(vos,function(index,vo){
// 				console.log('ajax...success:', vo);
				let tag_td = `<div class="board-cell">\${vo.content}</div>`;
				
				let ratedValue = parseInt(vo.rated);
// 				console.log('vo.rated:', vo.rated);
// 				console.log('vo.partynum:', vo.partyNum);

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
		       
				// userNum==vo.userNum
				if(memberreviewNum==vo.memberreviewNum) {
					tag_td = `<div class="board-cell"><input type="text" value="\${vo.content}" id="input_content"><button onclick="updateOK(\${vo.memberreviewNum})">수정완료</button></div>`;
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
				if(vo.writerNum==${num}){ //'${user_id}'===vo.writerNum
					tag_div = `<div>
						<button onclick="mre_selectAll(\${vo.userNum},\${vo.memberreviewNum})">수정</button>
						<button type="button" onclick="deleteOK(\${vo.memberreviewNum})">삭제</button>
					</div>`;
				}

				tag_txt += `
					<div class="board">
						<div class="board-row">
							<img id="preview" width="50px" src="${pageContext.request.contextPath}/resources/ProfileImage/\${vo.writerNum}.png"
							onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/ProfileImage/default.png';">
							<div class="board-cell">\${vo.writerName}</div>
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
			
			$(".par_paging").css("display", "none");
			$(".mre_paging").css("display", "block");
			
			// 별점 채우기
			$('.star-rating').each(function() {
			  var ratedValue = parseInt($(this).data('rating'));
			  var stars = $(this).find('.star');
			  for (var i = 0; i < ratedValue; i++) {
			    $(stars[i]).addClass('active');
			  }
			});
			
// 			mre_totalCount();
		},
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		}
	});
}// end mre_selectAll

function mre_totalCount(){ // 게시글 개수 계산
	console.log('mre_totalCount...');
	$.ajax({
		url: "memberreview/json/mre_totalCount.do",
		data:{
			userNum:${vo2.num}
		},
		method: 'GET',
		dataType: 'json',
		success: function(cnt){
			console.log('cnt...',cnt);
            mre_count = cnt;
		}, // end success
		
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
			
		} // end error
	}) // end ajax;	
};
mre_totalCount();

$(document).on('click', '#mre_back_page', function(e) { // 이전 버튼 클릭 시 동작
    e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막음.
	if(mrePage==1){ // 첫번째 페이지에서 팝업 경고창
		alert('첫 페이지입니다.');
		return false;
	}
    // 이전 페이지 번호 계산
    let previousPage = parseInt(mrePage) - 1;
    mrePage = previousPage;
	console.log('mre_count',mre_count);
    
 	// parameter 수정 후 페이지 다시 로드
	mre_selectAll(memberreviewNum=0, mrePage)
});

$(document).on('click', '#mre_next_page', function(e) {
//		console.log('page...',page);
	console.log('mre_count',mre_count);
	e.preventDefault(); // 기본 링크 동작(페이지 다시로드)을 막음.
	if((mrePage*5) >= mre_count){ // 마지막 페이지에서 팝업 경고창
		alert('마지막 페이지입니다.');
		return false;
	}
	// 다음 페이지 번호 계산
    let nextPage = parseInt(mrePage) + 1;
    mrePage = nextPage;
	console.log('mrePage...',mrePage);
	
	// parameter 수정 후 페이지 다시 로드
    mre_selectAll(memberreviewNum=0, mrePage)
});
	

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
                partyNum: 9,//9 ${vo.partyNum}
                userNum: ${vo2.num}, //
                writerNum: ${num},
                rated: $('#mre_rated').val(),
                content: $('#mre_content').val()
            },
            method: 'POST',
            dataType: 'json',
            success: function(obj) {
                console.log('ajax...success:', obj);
                if (obj.result == 1) {
                    mre_selectAll(userNum='\${vo.userNum}');
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


	
	
	function updateOK(memberreviewNum=0){
		console.log('updateOK()....',memberreviewNum);
		console.log($('#starRating').val());
		
		let rated = $('.star-rating .star.active').last().data('rating');
		
		$.ajax({
			url : "memberreview/json/updateOK.do",
			data:{
				memberreviewNum:memberreviewNum,
				content: $('#input_content').val(),
				rated: rated
			},
			method:'POST',
			dataType:'json',
			success : function(obj) {
				console.log('ajax...success:', obj);
				if(obj.result==1) mre_selectAll(userNum='\${vo.userNum}');
			},
			error:function(xhr,status,error){
				console.log('xhr.status:', xhr.status);
			}
		});
		
	}//end updateOK
	
	function deleteOK(memberreviewNum=0){
		console.log('deleteOK()....',memberreviewNum);
		
	  if (confirm("글을 삭제하시겠습니까?")) {
		  $.ajax({
				url : "memberreview/json/deleteOK.do",
				data:{
					memberreviewNum:memberreviewNum
				},
				method:'GET',
				dataType:'json',
				success : function(obj) {
					console.log('ajax...success:', obj);
					if(obj.result==1) mre_selectAll(userNum='\${vo.userNum}');
				},
				error:function(xhr,status,error){
					console.log('xhr.status:', xhr.status);
				}
			});
		    return;
		  }
	}//end deleteOK
	
function par_selectAll(page){
	$('#par_vos').show(); // 모임리스트 요소를 보이도록 설정
	$('#memberreview_list').hide();
// 	console.log('par_selectAll...');
	
	$.ajax({
		url: "party/json/selectAll.do",
		data:{
			writerNum : ${param.num},
			page: page, //${param.page}
		},
		method: 'GET',
		dataType: 'json',
		success: function(arr){
			console.log('ajax...',arr);
			let tag_vos = '';
			
			$.each(arr, function(index, vo){
				if (vo.writerNum === ${vo2.num}) { // user_id
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
			$(".par_paging").css("display", "block");
			$(".mre_paging").css("display", "none");
		}, // end success
		
		error:function(xhr,status,error){
			console.log('xhr.status:', xhr.status);
		} // end error
	}); // end ajax;
}
	
	
</script>
</head>
<body>
	<div class="userImpo">
		<img id="preview" width="80px" src="${pageContext.request.contextPath}/resources/ProfileImage/${vo2.num}.png"
					onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/ProfileImage/default.png';">
		<div class="userName">
			<a href="http://localhost:8088/hotplace/userpage.do?num=${vo2.num}">${vo2.nick_name}</a>
		</div>
		<button class="myPartyBt" onclick="location.href='party/myParty.do?userNum=${num}'">내 신청확인</button>
	</div>
	
	<div class="selectAll">
		<div class="par-selectAll" onclick="par_selectAll()">모임리스트</div>
		<div class="mre-selectAll" onclick="mre_selectAll()" id="reviewLink">후기목록 ${mreCount}</div>
	</div>
<!-- 	<a href="#"  onclick="par_selectAll()">모임리스트</a> -->
<!-- 	<a href="#" onclick="mre_selectAll()" id="reviewLink">후기목록</a> -->
	
	<div id="par_vos"></div>
	<div id="par_page"></div>
	
	<div id="memberreview_list"></div>
	
	<div class="par_paging" id="par_paging">
		<button class="par_back_page" id="par_back_page">모임이전</button>
		<button class="par_next_page" id="par_next_page">모임다음</button>
	</div>

	<div class="mre_paging" id="mre_paging">
		<button class="mre_back_page" id="mre_back_page">이전</button>
		<button class="mre_next_page" id="mre_next_page">다음</button>
		<button class="formContainer" onclick="insert()">작성</button>
	</div>
	
</body>
</html>



