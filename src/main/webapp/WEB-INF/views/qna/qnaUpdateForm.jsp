<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${ requestScope.page }" /> 
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
table {
   width: 1500px;
   height : 500px;
}
table.type02 {
  border-collapse: separate;
  border-spacing: 0;
  text-align: center;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;

}
table.type02 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: #eee;
}
table.type02 td {
  width: 350px;
  padding: 10px;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
.containerr2{
	text-align : center;
}
.replybtn{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 120px;
   height : 40px;
   margin-top : 20px;
}
.inputds {
  width: 500px;
  height: 32px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}

.inputdss {
 width: 500px;
 height: 250px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}


</style>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->

<c:import url="/WEB-INF/views/common/menubar.jsp" /> 
<br>
<h2 align="center">${ qna.q_no }번 게시글 수정 페이지</h2>
<br>
<!-- 원글 수정 폼 -->
<form action="qup.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="q_no" value="${ qna.q_no }">
	<input type="hidden" name="page" value="${ currentPage }">
	<c:if test="${ !empty q.q_original_filename }">
	<!-- 첨부파일이 있는 공지글이라면 -->
		<input type="hidden" name="q_original_filename" value="${ qna.q_original_filename }">
		<input type="hidden" name="q_rename_filename" value="${ qna.q_rename_filename }">
	</c:if>
<table class="type02" align="center">
	<tr><th scope="row">제 목</th><td><input class="inputds"  type="text" name="q_title" value="${ qna.q_title }"></td></tr>
	<tr><th scope="row">작성자</th>
	<td><input class="inputds"  type="text" name="q_writer" readonly value="${ qna.q_writer }"></td></tr>
	<tr><th scope="row">첨부파일</th>
		<td>
			<!-- 원래 첨부파일이 있는 경우 -->
			<c:if test="${ !empty qna.q_original_filename }">
				${ qna.q_original_filename } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
			</c:if>
			<br>
			새로 첨부 : <input type="file" name="upfile">
		</td>
	</tr>
	<tr><th scope="row">내 용</th><td><textarea class="inputdss" rows="5" cols="50" name="q_content">${ qna.q_content }</textarea></td></tr>
	</table>
	<div class="containerr2">
	<tr><th colspan="2">
		<input class="replybtn" type="submit" value="수정하기"> &nbsp; 
		<input class="replybtn" type="reset" value="수정취소"> &nbsp; 
		<button class="replybtn" onclick="javascript:history.go(-1); return false;">목록</button>
	</th></tr>
</div>
</form>
<!-- 댓글/대댓글 수정 폼 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>