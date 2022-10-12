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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
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

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function inputNumberFormat(obj) {

    obj.value = comma(uncomma(obj.value));
    
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

checkPrice = () => {
	var m1 = parseInt(uncomma(searchPFrom.p1.value));
	var m2 = parseInt(uncomma(searchPFrom.p2.value));
	console.log(m1);
	console.log(m2);
	
	
	if( searchPFrom.p2.value == ""  ) {
		Swal.fire({
      	  icon: 'warning',
      	  title:"금액을 입력해주세요.", 
        })
		return false;
	} else if( m1 > m2 ){
		Swal.fire({
	      	  icon: 'warning',
	      	  title:"가격을 확인해주십시오.",
	      	  text: "시작가격은 마지막 가격보다 클 수 없습니다.",
	        })
		return false;
	} else if( searchPFrom.p1.value=="" && searchPFrom.p2.value != ""){
		searchPFrom.p1.value=0;
	}
	searchPFrom.p1.value = m1;
	searchPFrom.p2.value = m2;
}
checkCategory = () => {
	
}
checkDate = () => {
	
	
	
	if( searchDFrom.end.value == "" || searchDFrom.begin.value == ""  ) {
		Swal.fire({
      	  icon: 'warning',
      	  title:"날짜를 입력해주세요.", 
        })
		return false;
	} else if(!( searchDFrom.end.value == "" || searchDFrom.begin.value == ""  )){
		var d1 = new Date(searchDFrom.begin.value);
		var d2 = new Date(searchDFrom.end.value);
		if( d1 >= d2 ){
			Swal.fire({
      	  icon: 'warning',
      	  title:"날짜를 확인해주십시오.", 
      	text: "시작날짜는 마지막 날짜보다 클 수 없습니다.",
        })
			return false;
		} 
	}

}


function showDiv(){
	if($('input[name=item]').eq(0).is(":checked")){
		$("#searchPriceDiv").css("display", "block");
		$("#searchDateDiv").css("display", "none");
		$("#searchCategoryDiv").css("display", "none");
	}
	if($('input[name=item]').eq(1).is(":checked")){
		$("#searchPriceDiv").css("display", "none");
		$("#searchDateDiv").css("display", "block");
		$("#searchCategoryDiv").css("display", "none");
	}
	if($('input[name=item]').eq(2).is(":checked")){
		$("#searchPriceDiv").css("display", "none");
		$("#searchDateDiv").css("display", "none");
		$("#searchCategoryDiv").css("display", "block");
	}
}

$(function(){
	
	if(${type == "searchPrice"}) {
		$("select[id=test]").val("");
		$("option[name=title]").attr("selected", "true");
		
		$("input[name=p1]").val(comma(${p1}))
		$("input[name=p2]").val(comma(${p2}))
	}else if(${type == "searchCategory" }) {
		$("select[id=test]").val("");

		$("option[name=category]").attr("selected", "true");
		
		$("input:radio[name=category]:input[value=${category}]").attr("checked", true)
		$("input:radio[name=item]:input[value=category]").attr("checked", true)
	}else if(${type == "searchDate" } ) {
		$("select[id=test]").val("");
		$("option[name=date]").attr("selected", "true");
		
		$("input[name=begin]").val("${begin}")
		$("input[name=end]").val("${end}")
		$("input:radio[name=item]:input[value=date]").attr("checked", true)
	}
	
	
	Change();
	
	
});


//글쓰기 버튼 클릭시 실행되는 함수
function showWriteForm(){
	// 게시 원글 쓰기 페이지로 이동 처리
	location.href = "${pageContext.servletContext.contextPath}/bwform.do";
}

function Change(){
	 var key = test.value;
	 if(key=="title"){
	 document.all["searchPriceDiv"].style.display="block";
	 document.all["searchCategoryDiv"].style.display="none";
	 document.all["searchDateDiv"].style.display="none"; 
	 }
	 if(key=="category"){
	 document.all["searchPriceDiv"].style.display="none";
	 document.all["searchCategoryDiv"].style.display="block";
	 document.all["searchDateDiv"].style.display="none";
	 
	 }
	 if(key=="date"){
	 document.all["searchPriceDiv"].style.display="none";
	 document.all["searchCategoryDiv"].style.display="none";
	 document.all["searchDateDiv"].style.display="block";
	 
	 }
	}


</script>
</head>
<body >
<c:import url="/WEB-INF/views/common/menubar.jsp" />



<br>
<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
<c:if test="${ date == ''}">
<h1 align="center">전체 지출 목록</h1>
</c:if>
<c:if test="${ date != ''}">
<h1 align="center">${ currentDate } 지출 목록</h1>
</c:if>
<h3 align="center">총 목록 수 : ${ listCount } 개</h3>
<br>
<!-- 
	=> 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
<!-- 검색 항목 영역 -->
<center>

<select id="test" onchange="Change()" style="width: 6rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:48px;text-align:center; right:308px;">
		<option name="title" value="title">금액</option>
		<option name="date" value="date">날짜</option>
		<option name="category" value="category">카테고리</option>
         </select>

<div id="searchPriceDiv" style="display: block">
	<form name="searchPFrom" action="billListView.do" method="post" onSubmit="return checkPrice()">
		<input type="hidden" name="type" value="searchPrice">
		<input type="hidden" name="date" value="${ date }">
		<input type="hidden" name="userid" value="${ loginMember.userid }">
		<input type="text" style="width: 12rem;height:3rem; border:3px solid #f8f9fa;" name="p1" class="input--text-item start_price" placeholder="0" min="0" value="0" onkeyup="removeChar(event);inputNumberFormat(this);">
		 ~ 
		<input type="text" style="width: 12rem;height:3rem; border:3px solid #f8f9fa;" name="p2" class="input--text-item end_price" placeholder="999,999,999" onkeyup="removeChar(event);inputNumberFormat(this);">
		<input type="submit" value="검색" style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
	</form>
</div>
<div id="searchCategoryDiv" style="display: none">
	<form name="searchCFrom" action="billListView.do" method="post">
	<input type="hidden" name="type" value="searchCategory" onSubmit="return checkCategory()">
	<input type="hidden" name="date" value="${ date }">
	<input type="hidden" name="userid" value="${ loginMember.userid }">
		<label>카테고리 :
			<input type="radio" name="category" value="식비">식비
	&nbsp; <input type="radio" name="category" value="문화/여가">문화/여가
	&nbsp; <input type="radio" name="category" value="교통비">교통비
	&nbsp; <input type="radio" name="category" value="기타">기타
		</label>
		<input type="submit" value="검색" style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
	</form>
</div>
<div id="searchDateDiv" style="display: none">
	<form name="searchDFrom" action="billListView.do" method="post" onSubmit="return checkDate()">
	<input type="hidden" name="type" value="searchDate">
	<input type="hidden" name="date" value="${ date }">
	<input type="hidden" name="userid" value="${ loginMember.userid }">
		<label>
			<input type="date" name="begin" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> ~
			<input type="date" name="end" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate">
		</label>
		<input type="submit" value="검색" style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
	</form>
</div>
</center>

<!-- 목록 출력 영역 -->
<br>
<table class="qa-table" align="center" width="700" border="1" cellspacing="0" cellpadding="1">
	<thead>
	<tr align="center">
		<th scope="cols">번호</th>
		<th scope="cols">지출 금액</th>
		<th scope="cols">결제 시간</th>
		<th scope="cols">카테고리</th>
	</tr>
	</thead>
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
			<a style="font-weight: bolder; color: red;  " href="${ bdt }">${ b.bill_price }</a>
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