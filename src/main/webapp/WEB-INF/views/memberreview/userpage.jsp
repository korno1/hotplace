<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userpage</title>
<link rel="stylesheet" href="/hotplace/resources/css/memberreview/userpage.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(function par_selectAll(){
	console.log('onload...');
// 	$('#insertButton').hide(); // 페이지가 로드될 때 작성 버튼 숨김
	
	
});

	function mre_selectAll(user_num=3, memberreview_num=0){ // ${param.memberreview_num}
		console.log('mer_selectAll()....user_num:',user_num);
		console.log('mer_selectAll()....memverreview_num:',memberreview_num);
		
		$('#insertButton').show();
		$.ajax({
			url : "memberreview/json/selectAll.do",
			data:{
				user_num:3 // ${param.user_num}
			},
			method:'GET',
			dataType:'json',
			success : function(vos) {
				console.log('ajax...success:', vos);
	
				let tag_txt = '';
				
				$.each(vos,function(index,vo){
					console.log('ajax...success:', vos);
					let tag_td = `<td>\${vo.content}</td>`;
					
					let ratedValue = parseInt(vo.rated);
					let tag_rated = `
				        <td id="input_rated">
			            <ul class="star-rating" data-rating="\${vo.rated}">
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			                <li class="star fa fa-star"></li>
			            </ul>
			        </td>`;
					
					let stars = $(tag_rated).find('.star');
					for (let i = 0; i < ratedValue; i++) {
					    $(stars[i]).addClass('active');
					}
					
					// user_num==vo.user_num
					if(memberreview_num==vo.memberreview_num) {
						tag_td = `<td><input type="text" value="\${vo.content}" id="input_content"><button onclick="updateOK(\${vo.memberreview_num})">수정완료</button></td>`;
					}
					let tag_div = ``;
					if(6==vo.writer_num){ //'${user_id}'===vo.writer_num
						tag_div = `<div>
							<button onclick="mre_selectAll(\${vo.user_num},\${vo.memberreview_num})">수정</button>
							<button onclick="deleteOK(\${vo.memberreview_num})">삭제</button>
						</div>`;

					}
					
					
					tag_txt += `
						<tr>
							<td>\${vo.save_name}</td>
							<td>\${vo.writer_name}</td>
							\${tag_rated}
							<td>\${vo.wdate}</td>
						</tr>
						<tr>
							\${tag_td}
							<td colspan="3">\${tag_div}</td>
						</tr>
					`;
				});//end ajax
				

				
				$('#memberreview_list').html(tag_txt);
				$('#insertButton').show();
				
	            // 별점 채우기
				$('.star-rating .star').click(function() {
				    var rating = $(this).attr('data-rating');
				    $(this).closest('.star-rating').find('.star').removeClass('active');
				    $(this).closest('.star-rating').find('.star').each(function() {
				        if ($(this).attr('data-rating') <= rating) {
				            $(this).addClass('active');
				        }
				    });
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
	        // 폼을 감싸는 부모 요소 생성
	        var formContainer = $('<div id="formContainer"></div>');

	        var form = $('<form></form>');

	        var starRating = $('<ul class="star-rating">' +
	            '<li class="star fa fa-star" data-rating="1"></li>' +
	            '<li class="star fa fa-star" data-rating="2"></li>' +
	            '<li class="star fa fa-star" data-rating="3"></li>' +
	            '<li class="star fa fa-star" data-rating="4"></li>' +
	            '<li class="star fa fa-star" data-rating="5"></li>' +
	            '</ul>');
	        
	        
	        
	        
	        var input1 = $('<input>');
	        input1.attr('type', 'text');
	        input1.attr('name', 'content');
	        input1.attr('id', 'mre_content');

	        var input2 = $('<input>');
	        input2.attr('type', 'hidden'); // 숨김 필드로 변경
	        input2.attr('name', 'rated');
	        input2.attr('id', 'mre_rated');


	        var button = $('<button></button>');
	        button.attr('onclick', "insertOK()");
	        button.text('작성완료');

	        form.append(input1);
	        form.append(input2);
	        form.append(starRating);
	        form.append(button);

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
		console.log($('#input_content').val());
		
		$.ajax({
			url : "memberreview/json/updateOK.do",
			data:{
				memberreview_num:memberreview_num,
				content: $('#input_content').val(),
	            rated: $('#input_rated').val()
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
		
		$.ajax({
			url : "memberreview/json/deleteOK.do",
			data:{
				memberreview_num:memberreview_num
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
		
	}//end deleteOK

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
	
	<table border="1" id="memberreview_list"> </table>
	
	<div id="formContainer"><button onclick="insert()">작성</button></div>

	<hr>
<!-- <h2>별점주기</h2> -->
<!-- <ul class="star-rating"> -->
<!--   <li class="star fa fa-star" data-rating="1"></li> -->
<!--   <li class="star fa fa-star" data-rating="2"></li> -->
<!--   <li class="star fa fa-star" data-rating="3"></li> -->
<!--   <li class="star fa fa-star" data-rating="4"></li> -->
<!--   <li class="star fa fa-star" data-rating="5"></li> -->
<!-- </ul> -->

<script type="text/javascript">
//   $(document).ready(function() {
//     $('.star-rating .star').click(function() {
//       var rating = $(this).attr('data-rating');
//       $('.star-rating .star').removeClass('active');
//       $(this).prevAll().addBack().addClass('active');
//       console.log('별점: ' + rating);
//       $('#mre_rated').val(rating); // input2 폼에 선택한 별점 값 설
//     });
//   });
</script>


</body>
</html>



