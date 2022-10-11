<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" 
src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	showDiv();
	
	$('input[name=item]').on("change", function(){
		showDiv();
	});
});

function showDiv(){
	if($('input[name=item]').eq(0).is(":checked")){
		$("#titleDiv").css("display", "block");
		$("#dateDiv").css("display", "none");
	}
	if($('input[name=item]').eq(1).is(":checked")){
		$("#titleDiv").css("display", "none");
		$("#dateDiv").css("display", "block");
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
<center>
<br>
<c:if test="${ sessionScope.loginMember.admin eq 'Y' }">
	<button onclick="javascript:location.href='movewrite.do';">
	새 공지글 등록</button>
</c:if>
</center>

<hr>
<!-- 검색 항목 영역 -->
<center>
<div>
	<h3>검색할 항목을 선택하세요.</h3><br>
	<input type="radio" name="item" value="title" checked> 제목 &nbsp; &nbsp;
	<input type="radio" name="item" value="date"> 날짜 
</div>
<div id="titleDiv">
	<form action="nsearchTitle.do" method="get">
		<label>검색할 제목 키워드를 입력하세요 : 
			<input type="search" name="keyword">
		</label>
		<input type="submit" value="검색">
	</form>
</div>
<div id="dateDiv">
	<form action="nsearchDate.do" method="get">
		<label>검색할 등록날짜를 입력하세요 : 
			<input type="date" name="begin"> ~ 
			<input type="date" name="end">
		</label>
		<input type="submit" value="검색">
	</form>
</div>
</center>


<!-- 목록 출력 영역 -->
<br>
<center>
	<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/nlist.do';">전체 목록 보기</button>
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
			<td><a href="${ ndt }">${ n.noticetitle }</a></td>
			<td>${ n.noticewriter }</td>
			<td>
				<c:if test="${ !empty n.original_filepath }">◎</c:if>
				<c:if test="${ empty n.original_filepath }">&nbsp;</c:if>
			</td>
			<td><fmt:formatDate value="${ n.noticedate }" pattern="yyyy-MM-dd" /></td>
			<td>${ n.readcount }</td>
		</tr>
		
	</c:forEach>
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







