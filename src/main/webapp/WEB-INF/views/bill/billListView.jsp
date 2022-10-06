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

function removeChar(event) {

    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) {
    
        return;
        
    } else {
    
        //숫자만 입력
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
    
    }
    
}

function comma(obj) {

    var regx = new RegExp(/(-?\d+)(\d{3})/);
    var bExists = obj.indexOf(".", 0);
    var strArr = obj.split('.');
    
    while (regx.test(strArr[0])) {
    
        strArr[0] = strArr[0].replace(regx, "$1,$2");
    }
    
    if (bExists > -1) {
        
        obj = strArr[0] + "." + strArr[1];
        
    } else { 
    
        obj = strArr[0];
        
    }
    
    return obj;
    
}

function inputNumberFormat(obj) {

    obj.value = comma(obj.value);
    
}

checkPrice = () => {
	
	if( searchPFrom.p2.value == ""  ) {
		alert("금액을 입력해주세요")
		
		return false;
	} else if( searchPFrom.p1.value > searchPFrom.p2.value ){
		alert("가격을 확인해주십시오.\n시작가격은 마지막 가격보다 클 수 없습니다.")
		return false;
	} else if( searchPFrom.p1.value=="" && searchPFrom.p2.value != ""){
		searchPFrom.p1.value=0;
	}

}

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

$(function(){
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
<h1 align="center">${ currentDate } 지출 목록</h1>
<h3 align="center">총 목록 수 : ${ listCount } 개</h3>
<br>
<!-- 
	=> 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
<!-- 검색 항목 영역 -->
<center>
<div>
	<h2>검색할 항목을 선택하세요.</h2>
	<input type="radio" name="item" value="title" checked> 금액 &nbsp; &nbsp;
	<input type="radio" name="item" value="writer"> 날짜 &nbsp; &nbsp;
	<input type="radio" name="item" value="date"> 카테고리 &nbsp; &nbsp;
</div>
<div id="titleDiv">
	<form name="searchPFrom" action="billListView.do" method="post" onSubmit="return checkPrice()">
		<input type="hidden" name="type" value="searchPrice">
		<input type="text" name="p1" class="input--text-item start_price" placeholder="0" onkeyup="removeChar(event);inputNumberFormat(this);">
		 ~ 
		<input type="text" name="p2" class="input--text-item end_price" placeholder="999,999,999" onkeyup="removeChar(event);inputNumberFormat(this);">
		<input type="submit" value="검색">
	</form>
</div>
<div id="dateDiv">
	<form action="billListView.do" method="post">
	<input type="hidden" name="type" value="searchCategory">
	<input type="hidden" name="date" value="${ date }">
	<input type="hidden" name="userid" value="${ loginMember.userid }">
		<label>검색할 카테고리를 입력하세요 :
			<input type="radio" name="category" value="식비">식비
	&nbsp; <input type="radio" name="category" value="문화/여가">문화/여가
	&nbsp; <input type="radio" name="category" value="교통비">교통비
	&nbsp; <input type="radio" name="category" value="기타">기타
		</label>
		<input type="submit" value="검색">
	</form>
</div>
<div id="writerDiv">
	<form action="billListView.do" method="post">
	<input type="hidden" name="type" value="searchDate">
		<label>검색할 결제날짜를 입력하세요 :
			<input type="date" name="begin"> ~
			<input type="date" name="end">
		</label>
		<input type="submit" value="검색">
	</form>
</div>
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
			<td>${ status.count+ (currentPage-1) * 10 }</td> 
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
							<c:param name="p1" value="${ p1 }"/>
				<c:param name="p2" value="${ p2 }"/>
				<c:param name="category" value="${ category }"/>
				<c:param name="begin" value="${ begin }"/>
				<c:param name="end" value="${ end }"/>
				<c:param name="type" value="${ type }"/>
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) <= startPage and (currentPage - 10) >= 1 }">
		<c:url var="bl2" value="/billListView.do">
			<c:param name="page" value="${ startPage - 1 }" />
			<c:param name="date" value="${ date }"/>
			<c:param name="userid" value="${ loginMember.userid }"/>
							<c:param name="p1" value="${ p1 }"/>
				<c:param name="p2" value="${ p2 }"/>
				<c:param name="category" value="${ category }"/>
				<c:param name="begin" value="${ begin }"/>
				<c:param name="end" value="${ end }"/>
				<c:param name="type" value="${ type }"/>
		</c:url>
		<a href="${ bl2 }">[이전그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) <= startPage and (currentPage - 10) >= 1) }">
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
				<c:param name="p1" value="${ p1 }"/>
				<c:param name="p2" value="${ p2 }"/>
				<c:param name="category" value="${ category }"/>
				<c:param name="begin" value="${ begin }"/>
				<c:param name="end" value="${ end }"/>
				<c:param name="type" value="${ type }"/>
			</c:url>
			<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (endPage + 1 ) < maxPage }">
		<c:url var="bl4" value="/billListView.do">
			<c:param name="page" value="${ endPage+1 }" />
			<c:param name="date" value="${ date }"/>
			<c:param name="userid" value="${ loginMember.userid }"/>
							<c:param name="p1" value="${ p1 }"/>
				<c:param name="p2" value="${ p2 }"/>
				<c:param name="category" value="${ category }"/>
				<c:param name="begin" value="${ begin }"/>
				<c:param name="end" value="${ end }"/>
				<c:param name="type" value="${ type }"/>
		</c:url>
		<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage + 10) > endPage and (endPage + 1) < maxPage) }">
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
							<c:param name="p1" value="${ p1 }"/>
				<c:param name="p2" value="${ p2 }"/>
				<c:param name="category" value="${ category }"/>
				<c:param name="begin" value="${ begin }"/>
				<c:param name="end" value="${ end }"/>
				<c:param name="type" value="${ type }"/>
		</c:url>
		<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
</div>
<hr>




<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>