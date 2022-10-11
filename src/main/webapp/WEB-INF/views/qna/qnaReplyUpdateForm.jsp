<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="areplyup.do" method="post" >	
	<input type="hidden" name="a_ref" value="${ a_ref }">
	<input type="hidden" name="page" value="${ currentPage }">
	
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="a_title" value="${ answer.a_title }"></td></tr>
	<tr><th>작성자</th>
	<td><input type="text" name="a_writer" readonly value="${ answer.a_writer }"></td></tr>
	
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="a_content">${ answer.a_content }</textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="수정하기"> &nbsp; 
		<input type="reset" value="수정취소"> &nbsp; 
		<button onclick="javascript:history.go(-1); return false;">이전페이지로 이동</button>
	</th></tr>
</table>
</form>

<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>