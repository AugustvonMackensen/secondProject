<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
<style></style>
<script text="text/javascript">
function mvNameCardPage(){
	location.href = "namecardPage.do";
}

function mvEnrollPage(){
	location.href = "enrollPage.do";
}
</script>
</head>
<body>
<!-- 헤더부분 로그, 로그인 부분 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<div>
<button type="button" id="nameCardPage" onclick="mvNameCardPage();">명함으로 회원가입</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button type="button" id="mvEnrollPage" onclick="mvEnrollPage();">일반 회원가입</button>
</div>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
