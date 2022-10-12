<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}
table.qa-table{
   width: 1300px;
   text-align:center;
   border : 1px solid #ccc;
   margin-left: auto; 
   margin-right: auto;
   border-collapse: collapse;
   line-height: 1.5;
}
table.qa-table thead{
   border-right: 1px solid #ccc;
   border-left: 1px solid #ccc;
   background: #4886FA;
}
table.qa-table thead th {
   padding: 10px;
   font-weight: bold;
   vertical-align: top;
   color: #fff;
}
table.qa-table tbody tr{;
   font-weight: bold;
   border-bottom: 1px solid #ccc;
   background: #F0F8FF;
   height : 38px;
}
.paging {
    position: fixed;
    bottom: 100px;
    width: 100%;
   text-align : center;
}



</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<script language="JavaScript" type="text/javascript">
function Change(){
 var key = test.value;
 if(key==1){
 document.all["d1"].style.display="block";
 document.all["d2"].style.display="none";
 document.all["d3"].style.display="none"; 
 }
 if(key==2){
 document.all["d1"].style.display="none";
 document.all["d2"].style.display="block";
 document.all["d3"].style.display="none";
 }
 if(key==3){
 document.all["d1"].style.display="none";
 document.all["d2"].style.display="none";
 document.all["d3"].style.display="block";
 }
}

function showWriteForm(){
   //게시원글 쓰기 페이지로 이동 처리
   location.href = "${ pageContext.servletContext.contextPath }/qwform.do";
}

</script>
</head>
<body >
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->

<h1 align="center">Q&A게시판</h1>
<br>
<!-- 
   => 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
<c:if test="${ !empty sessionScope.loginMember }">
   <button radu onclick="showWriteForm();" style="width: 7rem; border-radius: 10px;  height:3rem; background-color:#4b8ef1; color:white; border:3px solid; #f8f9fa;display: block; text-align: center; margin: auto;">글쓰기</button>
</c:if>
<!-- 검색 드롭 다운 영역 -->
 <div align="center"  >
         <select id="test" onchange="Change()" style="width: 6rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:48px;text-align:center; right:308px;">
      <option value="1">제목</option>
      <option value="2">작성자</option>
      <option value="3">날짜</option>
         </select>

      <div id="d1" style="display: block">
         <form action="qnasearchTitle.do" method="post" >
            <input type="search" name="keyword"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"> &nbsp; &nbsp; &nbsp;
            <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d2" style="display: none">
      <form action="qnasearchWriter.do" method="post">   
           <input type="search" name="keyword"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;">  &nbsp; &nbsp; &nbsp;
           <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d3" style="display: none">
         <form action="qnasearchDate.do" method="post"  >
            <input type="date" name="begin" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> <input type="date"
               name="end"  style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> &nbsp; &nbsp; &nbsp; <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>

   </div>

<!-- 목록 출력 영역 -->
<br>
<table class="qa-table" >
   <thead>
   <tr>
      <th scope="cols">번호</th>
      <th scope="cols">제목</th>
      <th scope="cols">작성자</th>
      <th scope="cols">날짜</th>
      <th scope="cols">조회수</th>
      <th scope="cols">첨부파일</th>
   </tr>
   </thead>
   <br>   
   <tbody>
   <c:forEach items="${ requestScope.list }" var="b">
      <tr>
         <td>${ b.q_no }</td>
         <c:url var="bdt" value="/qnadetail.do">
            <c:param name="q_no" value="${ b.q_no }" />
            <c:param name="page" value="${ b.q_no }" />
         </c:url>
         <!-- 게시글제목 클릭시 해당 글의 상세보기로 넘어가게 처리함 -->
         <td>

         <!-- 제목 글자 앞에 댓글과 대댓글 표시 기호 붙임
            들여쓰기 처리 : 원글과 구분지음
          -->

      
         <c:if test="${ !empty sessionScope.loginMember }">
               <a href="${ bdt }" style="color:blue;">${ b.q_title }</a>
         </c:if> 
         <c:if test="${ empty sessionScope.loginMember }">
               ${ b.q_title }
         </c:if> 
         </td>
         <td>${ b.q_writer }</td>
         <td><fmt:formatDate value="${ b.q_date }" pattern="yyyy-MM-dd" /></td>
         <td>${b.q_readcount }</td>
         <td>
            <c:if test="${ !empty b.q_original_filename }">◎</c:if>
            <c:if test="${ empty b.q_original_filename }">&nbsp;</c:if>
         </td>
         
      </tr>
   </c:forEach>
   </tbody>
</table>
<br>
<br>
<!-- 페이징 처리 -->
<div class="paging"> <!-- 페이지 표시 영역 -->
   <!-- 1페이지로 이동 처리 -->
   <c:if test="${ currentPage eq 1 }">
      [맨처음] &nbsp;
   </c:if>
   <c:if test="${ currentPage > 1 }">
      <c:url var="bl" value="/qnaListView.do">
         <c:param name="page" value="1" />
      </c:url>
      <a href="${ bl }">[맨처음]</a> &nbsp;
   </c:if>
   <!-- 이전 페이지그룹으로 이동 처리 -->
   <c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
      <c:url var="bl2" value="/qnaListView.do">
         <c:param name="page" value="${ startPage - 10 }" />
      </c:url>
      <a href="${ bl2 }">[이전그룹]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
      [이전그룹] &nbsp;
   </c:if>
   <!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
   <c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
      <c:if test="${ p eq currentPage }">
         <font size="4" color="red"><b>[${ p }]</b></font>
      </c:if>
      <c:if test="${ p ne currentPage }">
         <c:url var="bl3" value="/qnaListView.do">
         <c:param name="page" value="${ p }" />
      </c:url>
      <a href="${ bl3 }">${ p }</a> 
      </c:if>
   </c:forEach>
   <!-- 다음 페이지그룹으로 이동 처리 -->
   <c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
      <c:url var="bl4" value="/qnaListView.do">
         <c:param name="page" value="${ endPage + 10 }" />
      </c:url>
      <a href="${ bl4 }">[다음그룹]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
      [다음그룹] &nbsp;
   </c:if>
   <!-- 끝페이지로 이동 처리 -->
   <c:if test="${ currentPage eq maxPage }">
      [맨끝] &nbsp; 
   </c:if>
   <c:if test="${ currentPage < maxPage }">
      <c:url var="bl5" value="/qnaListView.do">
         <c:param name="page" value="${ maxPage }" />
      </c:url>
      <a href="${ bl5 }">[맨끝]</a> &nbsp;
   </c:if>
</div>
 
   <br>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>