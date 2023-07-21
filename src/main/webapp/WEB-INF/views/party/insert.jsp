<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임글쓰기</title>
<link rel="stylesheet" href="/hotplace/resources/css/party/insert.css?after" >
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(function(){
	date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, -8);
	$('#deadLine').val(date);
	$('#deadLine').attr('min', date);
	$('#timeLimit').val(date);
	$('#timeLimit').attr('min', date);
});

function setMin(){
	if($('#deadLine').val() < date){
		alert('현재 시간보다 이전의 시간입니다.');
		$('#deadline').val(date);
	}
	if($('#timeLimit').val() < date){
		alert('현재 시간보다 이전의 시간입니다.');
		$('#timeLimit').val(date);
	}
}

function titleCheckByte(obj, maxByte){
	var str = obj.value;
    var str_len = str.length;

    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";

    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
            rbyte += 3;                                         //한글3Byte
        }else{
            rbyte++;                                            //영문 등 나머지 1Byte
        }
        if(rbyte <= maxByte){
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }
     if(rbyte > maxByte)
     {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
        str2 = str.substr(0,rlen);                                  //문자열 자르기
        obj.value = str2;
        titlecheckByte(obj, maxByte);
     }
     else{
    	 $('#checkby').html(rbyte);
     }
}

function placeCheckByte(obj, maxByte){
	var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
            rbyte += 3;                                         //한글3Byte
        }else{
            rbyte++;                                            //영문 등 나머지 1Byte
        }
        if(rbyte <= maxByte){
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }
     if(rbyte > maxByte)
     {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
        str2 = str.substr(0,rlen);                                  //문자열 자르기
        obj.value = str2;
        titlecheckByte(obj, maxByte);
     }
     else{
    	 $('#checkby').html(rbyte);
     }
}

function contentCheckByte(obj, maxByte){
	var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
            rbyte += 3;                                         //한글3Byte
        }else{
            rbyte++;                                            //영문 등 나머지 1Byte
        }
        if(rbyte <= maxByte){
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }
     if(rbyte > maxByte)
     {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
        str2 = str.substr(0,rlen);                                  //문자열 자르기
        obj.value = str2;
        titlecheckByte(obj, maxByte);
     }
     else{
    	 $('#checkby').html(rbyte);
     }
}
</script>
</head>
<body>
	<div class="title">모임글쓰기</div>
	<form action="insertOK.do" method="post" enctype="multipart/form-data">
		<div class="body">
			<input type="hidden" name="writerNum" id="writerNum" value="${num}">
			<div class="par-title">
				<input type="text" name="title" id="title" placeholder="제목" required
					onfocus="this.placeholder=''" onblur="this.placeholder='제목'" onkeyup="titleCheckByte(this, 100)">
			</div>
			<div class="form-group">
				<div class="par-row">
					<div class="par-cell">
						<label for="max">모집인원</label>
					</div>
					<div class="par-cell">
						<select name="max" id="max" class="par-date" required>
							<option value="1">1명</option>
							<option value="2">2명</option>
							<option value="3">3명</option>
							<option value="4">4명</option>
							<option value="5">5명</option>
							<option value="6">6명</option>
							<option value="7">7명</option>
							<option value="8">8명</option>
							<option value="9">9명</option>
							<option value="10">10명</option>
						</select>
					</div>
				</div>
				<div class="par-row">
					<div class="par-cell">
						<label for="deadLine">모집마감일</label>
					</div>
					<div class="par-cell">
						<input class="par-date" type="datetime-local" name="deadLine"
							id="deadLine" onchange="setMin()" required>
					</div>
				</div>
				<div class="par-row">
					<div class="par-cell">
						<label for="place">식당</label>
					</div>
					<div class="par-cell">
						<input class="par-date" type="text" name="place" id="place" onkeyup="placeCheckByte(this, 50)" required>
					</div>
				</div>
				<div class="par-row">
					<div class="par-cell">
						<label for="timeLimit">모임날짜</label>
					</div>
					<div class="par-cell">
						<input class="par-date" type="datetime-local" name="timeLimit"
							id="timeLimit" onchange="setMin()" required>
					</div>
				</div>
			</div>
			<div class="content">
				<div class="content-title">모임에 대해 설명해주세요</div>
				<textarea class="textarea" name="content" id="content" onkeyup="contentCheckByte(this, 1800)" required></textarea>
			</div>
			<div>
				<input class="insertOK-bt" type="submit" value="글등록" required>
			</div>
		</div>
	</form>
</body>
</html>