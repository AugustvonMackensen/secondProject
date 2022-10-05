<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  

<c:set var="listCount" value= "${listCount}"></c:set>
<c:set var="startPage" value= "${startPage}"></c:set>
<c:set var="endPage" value= "${endPage}"></c:set>
<c:set var="maxPage" value= "${maxPage}"></c:set>
<c:set var="currentPage" value= "${currentPage}"></c:set>
<c:set var="currentDate" value= "${currentDate}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
table th { background-color: #99ffff; }
table#outer { border: 2px solid navy; }
</style>
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
		$("#writerDiv").css("display", "none");
		$("#dateDiv").css("display", "none");
	}
	if($('input[name=item]').eq(1).is(":checked")){
		$("#titleDiv").css("display", "none");
		$("#writerDiv").css("display", "block");
		$("#dateDiv").css("display", "none");
	}
	if($('input[name=item]').eq(2).is(":checked")){
		$("#titleDiv").css("display", "none");
		$("#writerDiv").css("display", "none");
		$("#dateDiv").css("display", "block");
	}
}
//글쓰기 버튼 클릭시 실행되는 함수
function showWriteForm(){
	// 게시 원글 쓰기 페이지로 이동 처리
	location.href = "${pageContext.servletContext.contextPath}/bwform.do";
}


</script>
</head>
<body >
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
<h1 align="center">${ currentDate } 지출 목록</h1>
<h3 align="center">총 목록 수 : ${ listCount } 개</h3>
<br>
<!-- 
	=> 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
<center>
<!-- <c:if test="${ !empty sessionScope.loginMember }">
	
</c:if>-->
<button onclick="showWriteForm;">지출등록(링크바꾸기)</button>
</center>

<!-- 목록 출력 영역 -->
<br>
<table align="center" width="700" border="1" cellspacing="0" cellpadding="1">
	<tr align="center">
		<th>번호</th>
		<th>지출 금액</th>
		<th>결제 시간</th>
		<th>카테고리</th>
	</tr>
	<br>
	<c:forEach items="${ requestScope.list }" var="b" varStatus="status">
		<tr align="center">
			<td>지출id:${ b.id },순서${ status.count+ (currentPage-1) * 10 }</td> 
			<!-- 지출 금액 클릭시 해당 지출의 상세보기로 넘어가게 처리 -->
			<c:url var="bdt" value="/billdetail.do">
				<c:param name="bill_id" value="${ b.id }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<!-- 지출 클릭시 해당 글의 상세보기로 넘어가게 처리함 -->
			<td>
			<a href="${ bdt }">${ b.bill_price }</a>
			</td>
			<td><fmt:formatDate value="${ b.bill_timestamp }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td>${ b.bill_category }</td>
		</tr>
	</c:forEach>
</table>
<br>
<br>
<!-- 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="bl" value="/billListView.do">
			<c:param name="page" value="1" />
			<c:param name="date" value="${ date }"/>
			<c:param name="userid" value="${ loginMember.userid }"/>
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:url var="bl2" value="/billListView.do">
			<c:param name="page" value="${ startPage - 10 }" />
			<c:param name="date" value="${ date }"/>
			<c:param name="userid" value="${ loginMember.userid }"/>
		</c:url>
		<a href="${ bl2 }">[이전그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1" >
		<c:if test="${ p eq currentPage }">
			<font size="4" color="red"><b>[${ p }]</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="bl3" value="/billListView.do">
				<c:param name="page" value="${ p }" />
				<c:param name="date" value="${ date }"/>
				<c:param name="userid" value="${ loginMember.userid }"/>
			</c:url>
			<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:url var="bl4" value="/billListView.do">
			<c:param name="page" value="${ currentPage + 10 }" />
			<c:param name="date" value="${ date }"/>
			<c:param name="userid" value="${ loginMember.userid }"/>
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
		<c:url var="bl5" value="/billListView.do">
			<c:param name="page" value="${ maxPage }" />
			<c:param name="date" value="${ date }"/>
			<c:param name="userid" value="${ loginMember.userid }"/>
		</c:url>
		<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
</div>
<hr>




<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>