<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table {
   width: 1500px;
   height : 300px;

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
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: #eee;
}
table.type02 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}
.updel:link {
  color : white;
}
.updel:visited {
  color : white;
}
.updel:hover {
  color : white;
}
.updel:active {
  color : white;
}
.updel{
   width: 200px;
    height: 60px;
    text-align: center;
    line-height: 60px;
   background : #0d6efd;
	padding: 10px 40px;
}
.containerr{
	text-align: center;
}
.containerr button.list{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 150px;
   height : 40px;
   margin-top : 20px;
   margin-bottom : 20px;
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
 height: 200px;
  font-size: 15px;
  border: 0;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}
.containerr2{
display: static;
align: left;
margin-left : 515px;
}

.replybtn{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 120px;
   height : 40px;
   margin-top : 20px;
}
.reply2{
   width: 120px;
    height: 40px;
     border: 0;
     outline: none;
     padding-left: 10px;
     color : white;
     background : #0d6efd;
}


table {
   width: 1500px;
   height : 300px;

}
table.type03 {
  border-collapse: separate;
  border-spacing: 0;
  text-align: center;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-left: 1px solid #ccc;
  margin-left : 515px;

}
table.type03 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #fff;
  border-left: 1px solid #fff;
  background: #eee;
}
table.type03 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-right: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
}

.replybtn2 {
   width: 200px;
    height: 60px;
    text-align: center;
    line-height: 60px;
   background : #0d6efd;
   padding: 8px 25px;

}
.replybtn2:link {
  color : white;
}
.replybtn2:visited {
  color : white;
}
.replybtn2:hover {
  color : white;
}
.replybtn2:active {
  color : white;
}
.rereply{
   margin-left : 515px;
}


</style>
<title>Insert title here</title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<style type="text/css" >
html, body {
      overflow: scroll;
      overflow-x: hidden
   }   
</style>
<h2 style="margin-top : 20px;" align="center">${ requestScope.notice.noticeno } 번 공지글 상세보기 [관리자용]</h2>
<br>
<table class="type02" align="center">
	<tr><th scope="row">제 목</th><td>${ notice.noticetitle }</td></tr>
	<tr><th scope="row">작성자</th><td>${ notice.noticewriter }</td></tr>
	<tr><th scope="row">날 짜</th><td>${ notice.noticedate }</td></tr>
	<tr><th scope="row">첨부파일</th>
		<td>
			<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
			<c:if test="${ !empty notice.original_filepath }">
				<c:url var="nfd" value="/nfdown.do">
					<c:param name="ofile" value="${ notice.original_filepath }" />
					<c:param name="rfile" value="${ notice.rename_filepath }" />
				</c:url>
				<a href="${ nfd }">${ notice.original_filepath }</a>
			</c:if>
			<!-- 첨부파일이 없다면 공백으로 처리함 -->
			<c:if test="${ empty notice.original_filepath }">
				&nbsp;
			</c:if>
		</td>
	</tr>
	<tr><th scope="row">내 용</th><td>${ notice.noticecontent }</td></tr>
	<tr><th scope="row">조회수</th><td>${ notice.readcount }</td></tr>
	<tr><th scope="row">중요도</th>
	<td><c:if test="${ notice.importance eq 1 }">일반</c:if>
		<c:if test="${ notice.importance eq 2 }">중요</c:if>
	</td></tr>
	</table>
	<div class="containerr">
	<tr><th colspan="2">
		<button class="list" onclick="javascript:history.go(-1);">목록</button> &nbsp; &nbsp;
		<!-- 수정페이지로 이동 버튼 -->
		<c:url var="movenup" value="/nmoveup.do">
			<c:param name="noticeno" value="${ notice.noticeno }" />			
		</c:url>
		<button class="list" onclick="javascript:location.href='${ movenup }';">수정페이지로 이동</button> &nbsp; &nbsp;
		<!-- 삭제하기 버튼 -->
		<c:url var="ndel" value="/ndel.do">
			<c:param name="noticeno" value="${ notice.noticeno }" />
			<c:param name="rfile" value="${ notice.rename_filepath }" />
		</c:url>
		<button class="list" onclick="javascript:location.href='${ ndel }';">글삭제</button>
	</th></tr>
	</div>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>