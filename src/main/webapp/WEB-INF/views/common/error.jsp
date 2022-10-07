<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br><br><br><br><br><br>

<h1 align="center">Error Page</h1>
<!-- 다른 jsp 에서 exception이 넘어온 경우의 처리 -->
<c:set var="e" value="<%= exception %>" />
<c:if test="${ !empty e }">  <!-- if(e != null) 과 같음 -->
	<h3 align="center"><%-- jsp 페이지 오류 발생 : ${ message } --%></h3>
</c:if>

<!-- 서버 측에서 서비스 요청에 대한 에러메세지 리턴한 경우의 처리 -->
<c:if test="${ empty e }">  <!-- if(e == null) 과 같음 -->
	<H3 align="center"><%-- 컨트롤러 요청 실패 메세지 : ${ message } --%></H3>
</c:if>
<hr>

<c:url var="movemain" value="/main.do" />
<h3 align="center"><a href="javascript:history.go(-1);">◀ 이전 페이지로 이동</a></h3><br><br>
<hr>
<h3 align="center"><a href="${ movemain }">▶시작 페이지로 이동</a></h3>

 <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>






