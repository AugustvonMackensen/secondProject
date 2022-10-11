<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9">
	Swal.fire({
		timer: 50000,
  		title: 'Deep Account Book 을 사용해주셔서 감사합니다.',    
  		text: '탈퇴가 완료됐습니다.',  
  		icon: 'warning',                     
	});
</script>


<h1 align="center">내 정보 보기</h1>
<br>
<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0" border="1">
	<tr>
		<th width="120">이 름</th>
		<td>${ member.username }</td>
	</tr>
	<tr>
		<th width="120">아이디</th>
		<td>${ member.userid }</td>
	</tr>
	<tr>
		<th width="120">이메일</th>
		<td>${ member.email }</td>
	</tr>
	<tr align="center">
		<th colspan="2">
		<c:url var="moveup" value="/moveup.do">
				<c:param name="userid" value="${ member.userid }"/>
			</c:url>
			<a href="${ moveup }">수정하기</a> &nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${ !empty sessionScope.loginMember and loginMember.admin ne 'Y' }">

			<c:url var="mdel" value="/mdel.do">
				<c:param name="userid" value="${ member.userid }"/>
			</c:url>
			<a href="${ mdel }" onclick="Swal.fire()">탈퇴하기</a>&nbsp;&nbsp;&nbsp;&nbsp;
			
			</c:if>
			<a href="main.do">시작페이지로 이동</a>
		</th>
	</tr>
</table>
<hr>
<br>
<br>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>