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

	function mre_selectAll(user_num=3, memberreview_num=0){ // ${param.memberreview_num}
		console.log('mer_selectAll()....user_num:',user_num);
		console.log('mer_selectAll()....memverreview_num:',memberreview_num);
		
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
							<td>\${vo.rated}</td>
							<td>\${vo.wdate}</td>
						</tr>
						<tr>
							\${tag_td}
							<td colspan="3">\${tag_div}</td>
						</tr>
					`;
				});//end ajax
				

				
				$('#memberreview_list').html(tag_txt);
				

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

	        var input1 = $('<input>');
	        input1.attr('type', 'text');
	        input1.attr('name', 'content');
	        input1.attr('id', 'mre_content');

	        var input2 = $('<input>');
	        input2.attr('type', 'text');
	        input2.attr('name', 'rated');
	        input2.attr('id', 'mre_rated');

	        var button = $('<button></button>');
	        button.attr('onclick', "insertOK()");
	        button.text('작성완료');

	        form.append(input1);
	        form.append(input2);
	        form.append(button);

	        formContainer.append(form);

	        // 기존 폼을 제거하고 새로운 폼으로 교체
	        $('#formContainer').replaceWith(formContainer);
	        
	        
	        isFormInserted = true;
// 	        $('#insertButton').hide();
// 	        $('#insertOKButton').show();
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
				content:$('#input_content').val()
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
	
<script>
// 	let isFormInserted = false; // 변수 추가
//     function insert() {
//         if (!isFormInserted) { // form이 삽입되지 않았을 경우에만 실행
//             // <form> 태그 생성
//             var form = $('<form></form>');

//             // <input> 태그 생성 및 속성 설정
//             var input1 = $('<input>');
//             input1.attr('type', 'text');
//             input1.attr('name', 'content');
//             input1.attr('id', 'mre_content');

//             var input2 = $('<input>');
//             input2.attr('type', 'text');
//             input2.attr('name', 'rated');
//             input2.attr('id', 'mre_rated');

//             // <button> 태그 생성 및 속성 설정
//             var button = $('<button></button>');
//             button.attr('onclick', "insertOK()");
//             button.text('작성완료');

//             // <form> 태그에 <input> 태그와 <button> 태그 삽입
//             form.append(input1);
//             form.append(input2);
//             form.append(button);

//             // <form> 태그를 문서의 특정 요소에 추가
//             form.appendTo('#formContainer');

//             isFormInserted = true; // form이 삽입되었음을 표시
//             $('#insertButton').hide(); // '작성' 버튼 숨김
            
//         }
//     }// end insert()

//     let isFormInserted = false; // 변수 추가
//     function insert() {    	
//     		$.ajax({
//     			data:{
//     				user_num:3 // ${param.user_num}
//     			},
//     			method:'GET',
//     			dataType:'json',
//     			success : function(vos) {
//     				console.log('ajax...success:', vos);
    	
//     				let tag_txt = '';
    				
//     				$.each(vos,function(index,vo){
//     					console.log('ajax...success:', vos);
//     					let tag_td = `<td>\${vo.content}</td>`;
    					
//     					// user_num==vo.user_num
//     					if(memberreview_num==vo.memberreview_num) {
//     						tag_td = `<td><input type="text" value="\${vo.content}" id="input_content"><button onclick="updateOK(\${vo.memberreview_num})">수정완료</button></td>`;
//     					}
//     					let tag_div = ``;
//     					if(6==vo.writer_num){ //'${user_id}'===vo.writer_num
//     						tag_div = `<div>
//     							<button onclick="mre_selectAll(\${vo.user_num},\${vo.memberreview_num})">수정</button>
//     							<button onclick="deleteOK(\${vo.memberreview_num})">삭제</button>
//     						</div>`;
//     					}
    					
    					
//     					tag_txt += `
//     						<tr>
//     							<td>\${vo.save_name}</td>
//     							<td>\${vo.writer_name}</td>
//     							<td>\${vo.rated}</td>
//     							<td>\${vo.wdate}</td>
//     						</tr>
//     						<tr>
//     							\${tag_td}
//     							<td>\${tag_div}</td>
//     						</tr>
//     					`;
//     				});
//     }
    	
    	
    	
//         if (!isFormInserted) { // form이 삽입되지 않았을 경우에만 실행
//             // <form> 태그 생성
//             var form = $('<form></form>');

//             // <input> 태그 생성 및 속성 설정
//             var input1 = $('<input>');
//             input1.attr('type', 'text');
//             input1.attr('name', 'content');
//             input1.attr('id', 'mre_content');

//             var input2 = $('<input>');
//             input2.attr('type', 'text');
//             input2.attr('name', 'rated');
//             input2.attr('id', 'mre_rated');

//             // <button> 태그 생성 및 속성 설정
//             var button = $('<button></button>');
//             button.attr('onclick', "insertOK()");
//             button.text('작성완료');

//             // <form> 태그에 <input> 태그와 <button> 태그 삽입
//             form.append(input1);
//             form.append(input2);
//             form.append(button);

//             // <form> 태그를 문서의 특정 요소에 추가
//             form.appendTo('#formContainer');

//             isFormInserted = true; // form이 삽입되었음을 표시
//             $('#insertButton').hide(); // '작성' 버튼 숨김
//         }
//     }// end insert()
    
    

 </script>
	

</body>
</html>



