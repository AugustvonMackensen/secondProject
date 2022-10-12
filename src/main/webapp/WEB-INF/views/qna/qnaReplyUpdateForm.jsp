<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 댓글 수정 페이지</title>
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
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: #eee;
}
table.type02 td {
  width: 350px;
  padding: 10px;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
.containerr2{
	text-align : center;
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
 height: 200px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" /><br>
<form action="areplyup.do" method="post" >	
	<input type="hidden" name="a_ref" value="${ answer.a_ref }">
	<input type="hidden" name="page" value="${ page }">
	<input type="hidden" name="a_id" value="${ answer.a_id }">
<table class="type02" align="center">
	<tr><th scope="row">제 목</th><td><input class="inputds"   type="text" name="a_title" value="${ answer.a_title }"></td></tr>
	<tr><th scope="row">작성자</th>
	<td><input class="inputds" type="text" name="a_writer" readonly value="${ answer.a_writer }"></td></tr>
	
	<tr><th scope="row">내 용</th><td><textarea class="inputdss" rows="5" cols="50" name="a_content">${ answer.a_content }</textarea></td></tr>
	   </table>
	   <div class="containerr2"> 
	<tr><th colspan="2">
		<input class="replybtn" type="submit" value="수정하기"> &nbsp; 
		<input class="replybtn" type="reset" value="수정취소"> &nbsp; 
		<button class="replybtn" onclick="javascript:history.go(-1); return false;">이전페이지</button>
 </th></tr>
   </div>
</form>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>