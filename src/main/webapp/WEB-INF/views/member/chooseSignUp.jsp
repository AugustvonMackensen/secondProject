<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
<style>
.bg-color{
       heigth :100%;
}
.wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
}

.item {
	width:300px;
	height : 200px;
  	padding: 50px;
	margin-bottom : 100px;
  	border-radius: 23px;
  	border :0;
  	background: linear-gradient(105deg, rgba(91,104,235,1) 0%, rgba(40,225,253,1) 100%);
  	color : white;
  	font-family: 'Noto Sans KR', sans-serif;
  	font-size : 20px;
  	margin-top : 200px;
}
.title {
	text-align : center;
	margin-top : 100px;
	font-family: 'Noto Sans KR', sans-serif;
}

</style>
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
<div class="bg-color">
<h1 class="title">회원가입할 방법을 선택해주세요!</h1>
<div class="wrapper">

<button class="item" type="button" id="nameCardPage" onclick="mvNameCardPage();">명함으로 회원가입</button>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button class="item" type="button" id="mvEnrollPage" onclick="mvEnrollPage();">일반 회원가입</button>
</div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
