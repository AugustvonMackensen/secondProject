<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script type="text/javascript" 
src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<script language="JavaScript" type="text/javascript">
function Change(){
 var key = test.value;
 if(key==1){
 document.all["d1"].style.display="block";
 document.all["d2"].style.display="none";
 }
 if(key==2){
 document.all["d1"].style.display="none";
 document.all["d2"].style.display="block";
 }
}
</script>
</head>
<body>
<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="../common/menubar.jsp" />
<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
<br>
<h1 align="center">공지사항</h1>
<!-- 관리자만 공지글 등록할 수 있도록 처리함
  => 로그인한 회원이 관리자이면 공지글 등록 버튼이 보이게 함 -->
<!-- 검색 항목 영역 -->
 <div align="center"  >
         <select id="test" onchange="Change()" style="width: 6rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:48px;text-align:center; right:308px;">
		<option value="1">제목</option>
		<option value="2">날짜</option>
         </select>

      <div id="d1" style="display: block">
         <form action="nsearchTitle.do" method="get" >
            <input type="search" name="keyword"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"> &nbsp; &nbsp; &nbsp;
            <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d2" style="display: none">
         <form action="nsearchDate.do" method="get"  >
            <input type="date" name="begin" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> <input type="date"
               name="end"  style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> &nbsp; &nbsp; &nbsp;<input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>

  </div>


<!-- 목록 출력 영역 -->
<br>
<center>
	<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/nlist.do';" style="width: 10rem; border-radius: 10px;  height:3rem; background-color:#4b8ef1; color:white; border:3px solid; #f8f9fa;">전체 목록 보기</button> &nbsp; &nbsp; &nbsp; &nbsp;

	<c:if test="${ sessionScope.loginMember.admin eq 'Y' }">
		<button onclick="javascript:location.href='movewrite.do';" style="width: 10rem; border-radius: 10px;  height:3rem; background-color:#4b8ef1; color:white; border:3px solid; #f8f9fa;">
	새 공지글 등록</button>
	</c:if>
</center>
<br>
<table class="qa-table">
	<thead>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>첨부파일</th>
		<th>날짜</th>
		<th>조회수</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${ requestScope.list }" var="n">
		<c:if test="${ n.importance eq 1 }">
			<tr align="center">
		</c:if>
		<c:if test="${ n.importance eq 2 }">
			<tr align="center" bgcolor="gray">
		</c:if>
			<td>${ n.noticeno }</td>
			<!-- 공지제목 클릭시 해당 글의 상세보기로 넘어가게 처리 -->
			<c:url var="ndt" value="/ndetail.do">
				<c:param name="noticeno" value="${ n.noticeno }" />
			</c:url>
			<td><a href="${ ndt }" style="color:blue;">${ n.noticetitle }</a></td>
			<td>${ n.noticewriter }</td>
			<td>
				<c:if test="${ !empty n.original_filepath }">◎</c:if>
				<c:if test="${ empty n.original_filepath }">&nbsp;</c:if>
			</td>
			<td><fmt:formatDate value="${ n.noticedate }" pattern="yyyy-MM-dd" /></td>
			<td>${ n.readcount }</td>
		</tr>
		
	</c:forEach>
	</tbody>
</table>

<c:if test="${ empty action }">
<!-- 전체 목록 페이징 처리 -->

<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="bl" value="/nlist.do">
			<c:param name="page" value="1" />
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:url var="bl2" value="/nlist.do">
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
			<c:url var="bl3" value="/nlist.do">
			<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:url var="bl4" value="/nlist.do">
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
		<c:url var="bl5" value="/nlist.do">
			<c:param name="page" value="${ maxPage }" />
		</c:url>
		<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if> 


<!-- 검색 목록 페이징 처리 -->
<c:if test="${ !empty action }">

<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		 [맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
			<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
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
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[이전그룹]</a> &nbsp;
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
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>

			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
			<a href="${ nsl }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[다음그룹]</a> &nbsp;
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
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if> <!-- 검색 목록 페이징 처리 -->

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







