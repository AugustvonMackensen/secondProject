<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
table th{ background-color:#99ffff; }
table#outer { border: 2px solid navy;}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<h1 align="center">회원 정보 수정 페이지</h1>
<br>
<form action="amupdate.do" method="post">
<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
	<tr>
		<th width="120">이 름</th>
		<td><input type="test" name="username" value="${ member.username }" readonly></td>
	</tr>
	<tr>
		<th width="120">아이디</th>
		<td><input type="text" name="userid" id="userid" value="${ member.userid }" readonly></td>
	</tr>
	<tr>
		<th width="120">이메일</th>
		<td><input type="email" name="email" value="${ member.email }"></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기"> &nbsp;
			<input type="reset" value = "수정취소"> &nbsp;
			<a href="javascript:history.go(-1);">이전 페이지로 이동</a> &nbsp;
			<a href="main.do">시작페이지로 이동</a>
		</th>
	</tr>
</table>
</form>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>