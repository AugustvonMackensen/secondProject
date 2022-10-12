<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table {
   width: 1500px;
   height : 500px;
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
 height: 250px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}

</style>
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<h2 align="center">게시글 등록 페이지</h2><br>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
   반드시 enctype 속성을 form 태그에 추가해야 됨
   enctype="multipart/form-data" 값을 지정해야 함
   method="post" 로 지정해야 함
 -->
<form action="qwinsert.do" method="post" enctype="multipart/form-data">
<table class="type02" align="center">
   <tr><th scope="row">제 목</th><td><input class="inputds" type="text" name="q_title"></td></tr>
   <tr><th scope="row">작성자</th>
   <td><input class="inputds" type="text" name="q_writer" readonly value="${ sessionScope.loginMember.userid }"></td></tr>
   <tr><th scope="row">첨부파일</th><td><input type="file" name="upfile"></td></tr>
   <tr><th scope="row">내 용</th><td><textarea class="inputdss"  rows="5" cols="50" name="q_content"></textarea></td></tr>
</table>
<div class="containerr2">
   <tr><th colspan="2">
      <input class="replybtn" type="submit" value="등록하기"> &nbsp; 
      <input class="replybtn" type="reset" value="작성취소"> &nbsp; 
      <button class="replybtn" onclick="javascript:history.go(-1); return false;">목록</button>
   </th></tr>
   </div>
</form>
<br>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







