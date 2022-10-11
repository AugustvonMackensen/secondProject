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
table th { background-color: #99ffff; border-bottom: 1px solid #444444;}
table td {border-bottom: 1px solid #444444;}
table#outer { border: 2px solid navy; }



</style>
<script type="text/javascript" 
src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">



function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}








$(function(){
	
	if(${type == "searchPrice"}) {
		$("input[name=p1]").val(comma(${p1}))
		$("input[name=p2]").val(comma(${p2}))
	}else if(${type == "searchCategory" }) {
		$("input:radio[name=category]:input[value=${category}]").attr("checked", true)
		$("input:radio[name=item]:input[value=category]").attr("checked", true)
	}else if(${type == "searchDate" } ) {
		$("input[name=begin]").val("${begin}")
		$("input[name=end]").val("${end}")
		$("input:radio[name=item]:input[value=date]").attr("checked", true)
	}
	
	showDiv();
	
	
	
	$('input[name=item]').on("change", function(){
		showDiv();
	});

	
	
});


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
<h1 align="center">등록된 지출 목록 ${ count }개</h1>

<br>
<!-- 
	=> 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
<!-- 검색 항목 영역 -->

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
			<td>${ status.count }</td> 
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

<hr>




<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>