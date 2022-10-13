<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    


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
.containerr{
	 text-align : center;

}
.containerr button.list{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 120px;
   height : 40px;
   margin-top : 20px;
   margin-bottom : 20px;
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

table {
   width: 1500px;
   height : 300px;

}
table.type03 {
  border-collapse: separate;
  border-spacing: 0;
  text-align: center;
  line-height: 10;
  border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;

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
	}	
</style>
<br><br><br>
<h2 align="center">${ requestScope.board.board_num } 번 자유게시글 상세보기</h2>
<br>
<table class="type02" align="center">
   <tr>
   		<th scope="row">제 목 : </th>
   		<td>${ board.board_title }</td>
   </tr>
   <tr>
	   <th scope="row">작성자 : </th>
	   <td>${ board.board_writer }</td>
   </tr>
   <tr>
	   <th scope="row">날 짜 : </th>
	   <td><fmt:formatDate value="${ board.board_date }" type="date" pattern="yyyy-MM-dd"/></td>
   </tr>
   <tr>
   <th scope="row">첨부파일 : </th>
      <td>
         <!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
         <c:if test="${ !empty board.board_original_filename }">
            <c:url var="bfd" value="/bfdown.do">
               <c:param name="ofile" value="${ board.board_original_filename }"/>
               <c:param name="rfile" value="${ board.board_rename_filename }"/>
            </c:url>
            <a href="${ bfd }">${ board.board_original_filename }</a>
         </c:if>
         <!-- 첨부파일이 없다면 공백으로 처리함 -->
         <c:if test="${ empty board.board_original_filename }">
            &nbsp;
         </c:if>
      </td>
   </tr>
   <tr><th scope="row">내 용 : </th><td>${ board.board_content }</td></tr>
   </table>
	<div class="containerr">
      <button class="list" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/blist.do';">전체 목록 보기</button>
      &nbsp;
      <!-- 글 작성자 가 아닌 로그인회원 인 경우 댓글 달기 기능 제공  -->
      <c:if test="${ !empty sessionScope.loginMember }">
         <c:if test="${ requestScope.board.board_writer ne sessionScope.loginMember.userid }">
            <c:url var="brf" value="/breplyform.do">
               <c:param name="board_num" value="${ board.board_num }"/>
               <c:param name="page" value="${ currentPage }"/>
            </c:url>
            <a class="updel" href="${ brf }">댓글달기</a>
         </c:if>
      </c:if>
      &nbsp;
      
      <!-- 본인 작성 글 일경우 수정, 삭제 기능 제공 -->

      <c:if test="${ requestScope.board.board_writer eq sessionScope.loginMember.userid }">
         <c:url var="bup" value="/bupview.do">
            <c:param name="board_num" value="${ board.board_num }"/>
            <c:param name="page" value="${ currentPage }"/>
         </c:url>
               <a class="updel"  href="${ bup }">수정</a> &nbsp;

         
         

         <c:url var="bdl" value="/bdel.do">
            <c:param name="board_num" value="${ board.board_num }"/>
            <c:param name="board_lev" value="${ board.board_lev }"/>
            <c:param name="baord_rename_filename" value="${ board.board_rename_filename }"/>
         </c:url>
         		<a  class="updel" href="${ bdl }">삭제</a> &nbsp;
      </c:if>
 </div>


<!-- 댓글 출력  -->
 <c:forEach items="${ requestScope.list }" var="b">
<div style="text-align : center;">
<table class="type03" align="center">
  <tr><th scope="row">제목</th>
      <td>${ b.board_title }</td>
   </tr>
   <tr><br>
      <th scope="row">작성자</th>
     <td>${ b.board_writer }</td>
      </tr>
    <tr>  <th scope="row">날짜</th>
      <td><fmt:formatDate value="${ b.board_date }" pattern="yyyy-MM-dd" /></td>
    </tr>
      <tr><th scope="row">내용</th>
      <td>${ b.board_content }</td>
   </tr>
   </c:forEach>
</table>
</div>
</body>
</html>



