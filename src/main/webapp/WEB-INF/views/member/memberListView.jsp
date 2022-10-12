<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="listCount" value= "${listCount}"></c:set>
<c:set var="startPage" value= "${startPage}"></c:set>
<c:set var="endPage" value= "${endPage}"></c:set>
<c:set var="maxPage" value= "${maxPage}"></c:set>
<c:set var="currentPage" value= "${currentPage}"></c:set>

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

form.sform {
	display: none; /*안 보이게 설정*/
	background: lightgray;
}

.user{
	color:#417556;
	background: #F0F8FF;
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

</script>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

$(function(){
	$('input[name=item]').on('change', function(){

		$('input[name=item]').each(function(index){

			if($(this).is(':checked')){
				$('form.sform').eq(index).css('display', 'block');
			}else{
				$('form.sform').eq(index).css('display', 'none');
			}
			
		});
	});
});

 //로그인 제한/가능 레디오 체크가 변경되었을 때 실행되는 함수
function changeLogin(element){
	//선택한 radio의 name 속성의 이름에서 userid 분리 추출함
	var userid = element.name.substring(8);
	console.log("changeLogin : " + userid);
	if(element.checked == true && element.value == "N"){
		//로그인 제한을 체크했다면
		console.log("로그인 제한 체크함");
		location.href="${pageContext.servletContext.contextPath}/loginok.do?userid=" + userid + "&loginok=N";
	} else {
		console.log("로그인 제한 해제함");
		location.href="${pageContext.servletContext.contextPath}/loginok.do?userid=" + userid + "&loginok=Y";
	}
} 
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<h1 align="center">회원 관리</h1>
<br>
<h4 align="center">현재 회원 수 : ${listCount} 명</h4>
<br>
<center>
	<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/mlist.do';" style="width: 7rem; border-radius: 10px;  height:3rem; background-color:#4b8ef1; color:white; border:3px solid; #f8f9fa;position:relative;">전체 보기</button>


<!-- 검색 항목 영역 -->
 <div align="center"  >
         <select id="test" onchange="Change()" style="width: 8rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:48px;text-align:center; right:308px;">
		<option value="1">회원 아이디</option>
		<option value="2">로그인 제한</option>
		<option value="3">가입날짜</option>
         </select>

      <div id="d1" style="display: block">
         <form action="msearchId.do" method="get" >
            <input type="search" name="keyword"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;">
            <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d2" style="display: none">
		<form action="msearchLogin.do" method="get">	
           <input type="radio" name="keyword" value="Y"  border:3px solid #f8f9fa;">회원 활성 &nbsp; &nbsp;
           <input type="radio" name="keyword" value="N"  border:3px solid #f8f9fa;">회원 비활성 &nbsp; &nbsp; &nbsp; &nbsp;
           <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d3" style="display: none">
         <form action="msearchDate.do" method="get"  >
            <input type="date" name="begin" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate" value="edate"> <input type="date"
               name="end"  style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate" value="edate"> <input type="submit" value="검색"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
 </div>
 <br>

	
<!-- 조회해 온 회원 리스트 정보 출력 처리 -->
<table class="qa-table">
	<thead>
	<tr>
		<th scope="cols">아이디</th>
		<th scope="cols">이메일</th>
		<th scope="cols">로그인 활성/비활성</th>
		<th scope="cols">정보 수정</th>
	</tr>
	</thead>
	
	<c:forEach items="${ requestScope.list }" var="m">
		<tr>
			<td>${ m.userid }</td>
			<td>${ m.email }</td>
			<td>
				<c:if test="${m.loginok eq 'Y' }">
					<input type="radio"	name="loginok_${m.userid }" 		value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
					<input type="radio"	name="loginok_${m.userid }" 		value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
				</c:if>
				<c:if test="${m.loginok eq 'N' }">
					<input type="radio"	name="loginok_${m.userid }" 		value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
					<input type="radio" 	name="loginok_${m.userid }" 		value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
				</c:if>
			</td>
			<th colspan="2">
		   <c:url var="amoveup" value="/amoveup.do">
				<c:param name="userid" value="${ m.userid }"/>
			</c:url>
			<a href="${ amoveup }" style="color:blue;">수정</a> &nbsp; 
		</th>
		</tr>
	</c:forEach>


</table>
<hr>
<c:if test="${ empty action }">
<!-- 전체 목록 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="bl" value="/mlist.do">
			<c:param name="page" value="1" />
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:url var="bl2" value="/mlist.do">
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
			<c:url var="bl3" value="/mlist.do">
				<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:url var="bl4" value="/mlist.do">
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
		<c:url var="bl5" value="/mlist.do">
			<c:param name="page" value="${ maxPage }" />
		</c:url>
		<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if>

<c:if test="${ !empty action }">

<!-- 검색 목록 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		 [맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
			<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
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
			<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
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
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
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
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
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