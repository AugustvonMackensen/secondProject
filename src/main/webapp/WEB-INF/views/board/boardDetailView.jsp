<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    


<c:set var="currentPage" value="${ requestScope.currentPage }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br><br><br>
<hr>
<h2 align="center">${ requestScope.board.board_num } 번 공지글 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
   <tr><th>제 목</th><td>${ board.board_title }</td></tr>
   <tr><th>작성자</th><td>${ board.board_writer }</td></tr>
   <tr><th>날 짜</th><td><fmt:formatDate value="${ board.board_date }" type="date" pattern="yyyy-MM-dd"/></td></tr>
   <tr><th>첨부파일</th>
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
   <tr><th>내 용</th><td>${ board.board_content }</td></tr>
   <tr><th colspan="2">
      <%-- <button onclick="javascript:location.herf='blist.do?page=${currentPage}';">목록</button> --%>
      <button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/blist.do';">전체 목록 보기</button>
      &nbsp;
      <!-- 글 작성자 가 아닌 로그인회원 인 경우 댓글 달기 기능 제공  -->
      <c:if test="${ !empty sessionScope.loginMember }">
         <c:if test="${ requestScope.board.board_writer ne sessionScope.loginMember.userid }">
            <c:url var="brf" value="/breplyform.do">
               <c:param name="board_num" value="${ board.board_num }"/>
               <c:param name="page" value="${ currentPage }"/>
            </c:url>
            <a href="${ brf }">[댓글달기]</a>
         </c:if>
      </c:if>
      
      
      <!-- 본인 작성 글 일경우 수정, 삭제 기능 제공 -->
      
      <c:if test="${ requestScope.board.board_writer eq sessionScope.loginMember.userid }">
         <c:url var="bup" value="/bupview.do">
            <c:param name="board_num" value="${ board.board_num }"/>
            <c:param name="page" value="${ currentPage }"/>
         </c:url>
         <a href="${ bup }">[수정하기]</a> &nbsp;
         
         
         
         <c:url var="bdl" value="/bdel.do">
            <c:param name="board_num" value="${ board.board_num }"/>
            <c:param name="board_lev" value="${ board.board_lev }"/>
            <c:param name="baord_rename_filename" value="${ board.board_rename_filename }"/>
         </c:url>
         <a href="${ bdl }">[삭제하기]</a> &nbsp;
      </c:if>
         
         
      
      
   </th></tr>

</table>
<!-- 댓글 출력  -->
<table align="center" width="500" border="1" cellspacing="0" cellpadding="1">
   <tr>
      <th>작성자</th>
      <th>날짜</th>
      <th>내용</th>
   </tr>
   <c:forEach items="${ requestScope.list }" var="b">
         
         <tr>
         <td>${ b.board_writer }</td>
         <td><fmt:formatDate value="${ b.board_date }" pattern="yyyy-MM-dd" /></td>
         <td>${ b.board_content }</td>
      </tr>
      
   </c:forEach>
</table>

<hr>

<c:import url="/WEB-INF/views/common/footer.jsp" />
<br><br><br><br><br><br><br><br><br>
</body>
</html>



