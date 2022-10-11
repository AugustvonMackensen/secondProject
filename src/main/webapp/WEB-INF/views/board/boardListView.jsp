<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />


<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"
   src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
   $(function() {
      showDiv();

      $('input[name=item]').on("change", function() {
         showDiv();
      });
   });

   function showDiv() {
      if ($('input[name=item]').eq(0).is(":checked")) {
         $("#titleDiv").css("display", "block");
         $("#writerDiv").css("display", "none");
         $("#dateDiv").css("display", "none");
      }
      if ($('input[name=item]').eq(1).is(":checked")) {
         $("#titleDiv").css("display", "none");
         $("#writerDiv").css("display", "block");
         $("#dateDiv").css("display", "none");
      }
      if ($('input[name=item]').eq(2).is(":checked")) {
         $("#titleDiv").css("display", "none");
         $("#writerDiv").css("display", "none");
         $("#dateDiv").css("display", "block");
      }
   }

   // 글쓰기 버튼 클릭시 실행되는 함수 
   function showWriteForm() {
      //게시원글 쓰기 페이지로 이동 처리 
      location.href = "${pageContext.servletContext.contextPath}/bwform.do";
   }
</script>


</head>
<body>
   <!--상대경로로 대상 파일의 위치를 지정한 경우  -->
   <c:import url="../common/menubar.jsp" />
   <!-- jstl의 절대 경로 표기 : /WEB-INF/views/common/menubar.jsp  -->
   <hr>
   <h1 align="center">게시글 목록</h1>
   <h3 align="center">총 목록 수 : ${ listCount } 개</h3>
   <!--    로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함. -->
   <center>
         <c:if test="${ !empty sessionScope.loginMember }">   
         
            <button onclick="showWriteForm();">글쓰기</button> 
       </c:if>
   </center>
   
   <!-- 검색 항목 영역  -->
   <center>
      <div>
         <h2>검색할 항목을 선택하세요.</h2>
         <input type="radio" name="item" value="title" checked>제목
         &nbsp; &nbsp; <input type="radio" name="item" value="writer">작성자
         &nbsp; &nbsp; <input type="radio" name="item" value="date">날짜
      </div>
      <div id="titleDiv">
         <form action="searchTitle.do" method="get">
            <label>검색할 제목 키워드를 입력하세요 : <input type="search"
               name="keyword">
            </label> <input type="submit" value="검색">
         </form>
      </div>
      <div id="writerDiv">
         <form action="searchWriter.do" method="get">
            <label>검색할 작성자 아이디를 입력하세요 : <input type="search"
               name="keyword" >
            </label> <input type="submit" value="검색">
         </form>
      </div>
      <div id="dateDiv">
         <form action="searchDate.do" method="get">
            <label>검색할 등록날짜를 입력하세요 : <input type="date" name="begin">
               ~ <input type="date" name="end" >
            </label> <input type="submit" value="검색">
         </form>
      </div>
   </center>



   <!-- 목록 출력 영역 -->
   <br>
<center>
   <button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/blist.do';">전체 목록 보기</button>
</center>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="1">
   <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>첨부파일</th>
      <th>날짜</th>
      <th>조회수</th>
   </tr>
   <c:forEach items="${ requestScope.list }" var="b">
         <!-- 공지제목 클릭시 해당 글의 상세보기로 넘어가게 처리 -->
         <c:url var="bdt" value="/bdetail.do">
            <c:param name="board_num" value="${ b.board_num }" />
            <c:param name ="page" value="${currentPage }" />
         </c:url>
         
         <td align="left">
               <!-- 제목 글자 앞에 댓글과 대댓글 표시 기호 붙임
               들여쓰기 처리 : 원글과 구분지음 --> <c:if test="${ b.board_lev eq 2 }">&nbsp; &nbsp; ▶</c:if>
               <c:if test="${ b.board_lev eq 3 }">&nbsp; &nbsp; &nbsp; &nbsp; ▶▶</c:if>
         
         
         <td>${ b.board_num }</td>
         <td><a href="${ bdt }">${ b.board_title }</a></td>
         <td>${ b.board_writer }</td>
         <td>
            <c:if test="${ !empty b.board_original_filename }">◎</c:if>
            <c:if test="${ empty b.board_original_filename }">&nbsp;</c:if>
         </td>
         <td><fmt:formatDate value="${ b.board_date }" pattern="yyyy-MM-dd" /></td>
         <td>${ b.board_readcount }</td>
      </tr>
      
   </c:forEach>
</table>

<!-- 전체 목록 페이징 처리 -->
<c:if test="${ empty action }">

<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
   <!-- 1페이지로 이동 처리 -->
   <c:if test="${ currentPage eq 1 }">
      [맨처음] &nbsp;
   </c:if>
   <c:if test="${ currentPage > 1 }">
      <c:url var="bl" value="/blist.do">
         <c:param name="page" value="1" />
      </c:url>
      <a href="${ bl }">[맨처음]</a> &nbsp;
   </c:if>
   <!-- 이전 페이지그룹으로 이동 처리 -->
   <c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
      <c:url var="bl2" value="/blist.do">
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
         <c:url var="bl3" value="/blist.do">
         <c:param name="page" value="${ p }" />
      </c:url>
      <a href="${ bl3 }">${ p }</a> 
      </c:if>
   </c:forEach>
   <!-- 다음 페이지그룹으로 이동 처리 -->
   <c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
      <c:url var="bl4" value="/blist.do">
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
      <c:url var="bl5" value="/blist.do">
         <c:param name="page" value="${ maxPage }" />
      </c:url>
      <a href="${ bl5 }">[맨끝]</a> &nbsp;
   </c:if>
</div>
</c:if> <!-- 전체 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<!-- 검색 목록 페이징 처리 -->
<c:if test="${ !empty action }">
<!-- 검색 목록 페이징 처리 -->


<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
   <!-- 1페이지로 이동 처리 -->
   <c:if test="${ currentPage eq 1 }">
       [맨처음] &nbsp;
   </c:if>
   <c:if test="${ currentPage > 1 }">
         <c:if test="${ action eq 'title' }">
            <c:url var="nsl" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="1" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="1" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="1" />
            </c:url>
         </c:if>
      <a href="${ nsl }">[맨처음]</a> &nbsp;
   </c:if>
   <!-- 이전 페이지그룹으로 이동 처리 -->
   <c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
      <c:if test="${ action eq 'title' }">
            <c:url var="nsl2" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ startPage - 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl2" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ startPage - 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl2" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ startPage - 10 }" />
            </c:url>
         </c:if>
      <a href="${ nsl2 }">[이전그룹]</a> &nbsp;
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
         <c:if test="${ action eq 'title' }">
            <c:url var="nsl3" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ p }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl3" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ p }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl3" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ p }" />
            </c:url>
         </c:if>
         <a href="${ nsl3 }">${ p }</a> 
      </c:if>
   </c:forEach>
   <!-- 다음 페이지그룹으로 이동 처리 -->
   <c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
      <c:if test="${ action eq 'title' }">
            <c:url var="nsl4" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ endPage + 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl4" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ endPage + 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl4" value="nsearchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ endPage + 10 }" />
            </c:url>
         </c:if>
      <a href="${ nsl4 }">[다음그룹]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
      [다음그룹] &nbsp;
   </c:if>
   <!-- 끝페이지로 이동 처리 -->
   <c:if test="${ currentPage eq maxPage }">
      [맨끝] &nbsp; 
   </c:if>
   <c:if test="${ currentPage < maxPage }">
      <c:if test="${ action eq 'title' }">
            <c:url var="nsl5" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ maxPage }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl5" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ maxPage }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl5" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ maxPage }" />
            </c:url>
         </c:if>
      <a href="${ nsl5 }">[맨끝]</a> &nbsp;
   </c:if>
</div>
</c:if> <!-- 검색 목록 페이징 처리 -->
</body>
</html>






