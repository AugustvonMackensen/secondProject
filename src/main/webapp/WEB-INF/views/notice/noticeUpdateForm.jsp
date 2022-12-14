<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
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
  width: 100px;
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
  width: 250px;
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
   width: 180px;
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
<title></title>
</head>
<body>
<!-- ??????????????? ?????? ????????? ????????? ????????? ?????? -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h2 style="margin-top : 20px;" align="center">${ notice.noticeno }??? ????????? ?????? ?????????</h2>
<br>
<!-- form ???????????? ????????? ??????(?????????)??? ??????????????? ?????? ???????????????,
	????????? enctype ????????? form ????????? ???????????? ???
	enctype="multipart/form-data" ?????? ???????????? ???
	method="post" ??? ???????????? ???
 -->
<form action="nupdate.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="noticeno" value="${ notice.noticeno }">
	<c:if test="${ !empty notice.original_filepath }">
	<!-- ??????????????? ?????? ?????????????????? -->
		<input type="hidden" name="original_filepath" value="${ notice.original_filepath }">
		<input type="hidden" name="rename_filepath" value="${ notice.rename_filepath }">
	</c:if>
<table class="type02" align="center">
	<tr><th scope="row">??? ???</th><td><input class="inputds" type="text" name="noticetitle" value="${ notice.noticetitle }">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<c:if test="${ notice.importance eq 2 }">
	<input type="checkbox" name="importance" value="2" checked> ?????????
	</c:if>
	<c:if test="${ notice.importance eq 1 }">
	<input type="checkbox" name="importance" value="2"> ?????????
	</c:if>
	</td></tr>
	<tr><th scope="row">?????????</th>
	<td><input class="inputds" type="text" name="noticewriter" readonly value="${ notice.noticewriter }"></td></tr>
	<tr><th scope="row">????????????</th>
		<td>
			<!-- ?????? ??????????????? ?????? ?????? -->
			<c:if test="${ !empty notice.original_filepath }">
				${ notice.original_filepath } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> ???????????? <br>
			</c:if>
			<br>
			?????? ?????? : <input type="file" name="upfile">
		</td>
	</tr>
	<tr><th scope="row">??? ???</th><td><textarea class="inputds" rows="5" cols="50" name="noticecontent">${ notice.noticecontent }</textarea></td></tr>
	<div class="containerr2">
  <tr><th colspan="2">
		<input class="replybtn" type="submit" value="????????????"> &nbsp; 
		<input class="replybtn" type="reset" value="????????????"> &nbsp; 
		<button class="replybtn" onclick="javascript:history.go(-1);">?????????????????? ??????</button>
	</th></tr>
  </div>
</table>
</form>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>