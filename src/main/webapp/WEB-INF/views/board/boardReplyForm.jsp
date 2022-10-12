<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="board_num" value="${ requestScope.board_num }"/>
<c:set var="currentPage" value="${ requestScope.currentPage }"/>

<!DOCTYPE html>
<html>
<head>
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
.containerr2{
display: static;
align: left;
margin-left : 530px;
}
.replybtn{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 120px;
   height : 40px;
   margin-top : 20px;
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
 height: 250px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<style type="text/css" >
html, body {
      overflow: scroll;
      overflow-x: hidden
   }   
</style>  
<br><br>
<h2 align="center">${ board_num }번 게시글 의 댓글 등록  페이지</h2>

<form action="breply.do" method="post" >
   <!-- 원글 번호도 함께 숨겨서 전송  -->
   <input type="hidden" name="board_ref" value="${ board_num }">
   <input type="hidden" name="page" value="${currentPage }">
<table class="type02" align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
   <tr><th scope="row">제 목</th><td><input class="inputdss" type="text" name="board_title"></td></tr>
   <tr><th scope="row">작성자</th><td><input class="inputdss" type="text" name="board_writer" readonly value="${ loginMember.userid }"></td></tr>
   <tr><th scope="row">내 용</th><td><textarea class="inputdss" rows="5" cols="50" name="board_content"></textarea></td></tr>
   <div class="containerr2">
   <tr><th colspan="2">
      <input class="replybtn" type="submit" value="댓글등록"> &nbsp; 
      <input class="replybtn" type="reset" value="댓글등록취소"> &nbsp; 
      <button class="replybtn" onclick="javascript:history.go(-1);">이전페이지</button>
   </th></tr>
      </div>
</table>
</form>
</body>
</html>