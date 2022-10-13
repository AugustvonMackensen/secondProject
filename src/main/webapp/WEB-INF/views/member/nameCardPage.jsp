<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
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
  	cursor: pointer;
}
.title {
	text-align : center;
	margin-top : 100px;
	font-family: 'Noto Sans KR', sans-serif;
}

</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script text="text/javascript">
function capCamera(){
	location.href = "camCamera.do";
}

function imgUpload(){
	location.href = "uploadImage.do";
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="bg-color">
<image id="preImage" src="" onchange="chkCard();">
<h1 class="title">카메라촬영 혹은 이미지등록 버튼을 눌러주세요!</h1>
<div class="wrapper">
<button class="item" type="button" onclick="capCamera();">카메라로 촬영</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<button class="item" type="button" onclick="imgUpload();">이미지 등록</button>
</div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>