<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
table#outer { border:2px solid navy; }
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

function validate(){
	//비밀번호 유효성 검사
	var passRule = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;
	
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	
	if(pwd1 !== pwd2){
		alert("암호와 암호 확인의 값이 일치하지 않습니다.\n"
				+ "다시 입력하세요.");
		document.getElementById("upwd1").select();
		return false;
	}
	
	if(passRule.test(pwd1) === false){
		alert("비밀번호는 8~16자의 영문 대소문자와 숫자, 특수문자를 적어도 하나는 포함해야 합니다.");
		document.getElementById("upwd1").select();
		return false;
	}
	return true;
}
</script>

<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}
table.qa-table{
	width: 500px;
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
	background: #fff; 
	height : 38px;
}
table.qa-table tbody tr th{;
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

</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<h1 align="center">회원 정보 수정 페이지</h1>
<br>
<form action="mupdate.do" method="post">
	<input type="hidden" name="origin_userpwd" value="${ member.userpwd }">
<table class="qa-table">
	<tbody>
	<tr>
		<th width="120">이 름</th>
		<td><input type="text" name="username" value="${ member.username }" readonly></td>
	</tr>
	<tr>
		<th width="120">아이디</th>
		<td><input type="text" name="userid" id="userid" value="${ member.userid }" readonly></td>
	</tr>
	<tr>
		<th width="120">암 호</th>
		<td><input type="password" name="userpwd" id="upwd1" value=""></td>
	</tr>
	<tr>
		<th width="120">암호확인</th>
		<td><input type="password" id="upwd2" onblur="validate();"></td>
	</tr>
	<tr>
		<th width="120">이메일</th>
		<td><input type="email" name="email" value="${ member.email }"></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기"> &nbsp;
			<input type="reset" value="수정취소"> &nbsp;
			<a href="javascript:history.go(-1);">이전 페이지로 이동</a> &nbsp;
			<a href="main.do">시작페이지로 이동</a>
		</th>
	</tr>
	</tbody>
</table>
</form>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>