<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table {
   width: 1500px;
   height : 300px;

}
table.type02 {
  border-collapse: separate;
  border-spacing: 0;
  text-align: center;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;

}
table.type02 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: #eee;
}
table.type02 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
.updel:link {
  color : white;
}
.updel:visited {
  color : white;
}
.updel:hover {
  color : white;
}
.updel:active {
  color : white;
}
.updel{
   width: 200px;
    height: 60px;
    text-align: center;
    line-height: 60px;
   background : #0d6efd;
	padding: 10px 40px;
}
.containerr{
	text-align: center;
}
.containerr button.list{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 150px;
   height : 40px;
   margin-top : 20px;
   margin-bottom : 20px;
}
.inputds {
  width: 500px;
  height: 32px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
.inputdss {
 width: 500px;
 height: 200px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
.containerr2{
display: static;
align: left;
margin-left : 515px;
}

.replybtn{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 120px;
   height : 40px;
   margin-top : 20px;
}
.reply2{
   width: 120px;
    height: 40px;
     border: 0;
     outline: none;
     padding-left: 10px;
     color : white;
     background : #0d6efd;
}


table {
   width: 1500px;
   height : 300px;

}
table.type03 {
  border-collapse: separate;
  border-spacing: 0;
  text-align: center;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;
  margin-left : 515px;

}
table.type03 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: #eee;
}
table.type03 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

.replybtn2 {
   width: 200px;
    height: 60px;
    text-align: center;
    line-height: 60px;
   background : #0d6efd;
   padding: 8px 25px;

}
.replybtn2:link {
  color : white;
}
.replybtn2:visited {
  color : white;
}
.replybtn2:hover {
  color : white;
}
.replybtn2:active {
  color : white;
}
.rereply{
   margin-left : 515px;
}


</style>
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h2 style="margin-top : 20px;" align="center">새 공지글 등록 페이지</h2>
<br>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
	반드시 enctype 속성을 form 태그에 추가해야 됨
	enctype="multipart/form-data" 값을 지정해야 함
	method="post" 로 지정해야 함
 -->
<form action="ninsert.do" method="post" enctype="multipart/form-data">
<table class="type02" align="center">
	<tr><th scope="row">제 목</th><td><input type="text" name="noticetitle"></td></tr>
	<tr><th scope="row">작성자</th>
	<td><input type="text" name="noticewriter" readonly value="${ sessionScope.loginMember.userid }">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="importance" value="2"> 중요도</td></tr>
	<tr><th scope="row">첨부파일</th><td><input type="file" name="upfile"></td></tr>
	<tr><th scope="row">내 용</th><td><textarea rows="5" cols="50" name="noticecontent"></textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="등록하기"> &nbsp; 
		<input type="reset" value="작성취소"> &nbsp; 
		<button onclick="javascript:history.go(-1);">목록</button>
	</th></tr>
</table>
</form>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>








