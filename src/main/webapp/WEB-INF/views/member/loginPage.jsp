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
<div align="center">
<h1>Deep Account Book</h1><br>
<form action="login.do" method="post">
<label>아이디 : <input type="text" name="userid" class="pos"></label> <br><br>
<label>암  호 : <input type="password" name="userpwd" class="pos"></label> <br><br>
<input type="submit" value="로그인"><br>
</form>
<br>
<c:url var="mvfindId" value="/moveIdRecovery.do" />
<c:url var="mvfindPwd" value="/movePwdRecovery.do" />

<a href="${ mvfindId }">아이디 찾기</a> | &nbsp;
<a href="${ mvfindPwd }">비밀번호 찾기</a>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>