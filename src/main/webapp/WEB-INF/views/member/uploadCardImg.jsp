<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title></title>
<style type="text/css">
*{
font-family: 'Noto Sans KR', sans-serif;
}
.wrap {
			height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top : 20px;
}
.wrap_menu{
	margin-left :-130px;
}
.textval{
	width: 120px;
    height: 40px;
    border: 0;
    outline: none;
    padding-left: 10px;
    color: white;
    background: #0d6efd;
    margin-top : 30px;
 	cursor:pointer
}
.textval2{
	width: 120px;
    height: 45px;
    border: 0;
    outline: none;
    padding-left: 10px;
    color: white;
    background: #0d6efd;
    margin-top : 30px;
 	cursor:pointer
}
#extractedTxt{
	margin-top : 30px;
}
#mainmove{
   border : 0;
   background : #0d6efd;
   color : white;
   width: 200px;
   height : 50px;
   outline : none;
   text-align : center;
   fon-size: 1.2em;
   line-height:48px;
   letter-spacing : 2px;
   padding : 10px;
   text-decoration: none;
}
div .wrap2{
	display : absoulte;
	margin : auto;
}
a #mainmove:link {
  color : white;
  text-decoration: none;
}
a #mainmove:visited {
  color : white;
  text-decoration: none;
}
a #mainmove:hover {
  color : white;
  text-decoration: none;
}
a #mainmove:active {
  color : white;
  text-decoration: none;
}


</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script text="text/javascript">
function previewImage(f){
	var file = f.files;
	
	//확장자 체크
	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
		alert("gif, jpg, png 파일만 선택해 주세요.")
		
		f.outerHTML = f.outerHTML;
		
		document.getElementById('preview').innerHTML = "";
	} else{
		//FileReader 객체 사용
		var reader = new FileReader();
		
		//파일 읽기 완료시 실행
		reader.onload = function(input){
			document.getElementById('preview').innerHTML = '<img src="' + input.target.result + '" name="previewImg" id="previewImg">';
		}
		
		//파일 읽기
		reader.readAsDataURL(file[0]);
	}

}



</script>
</head>
<body>
<div class="wrap">
<div>
<h3>명함 회원가입 메뉴얼</h3>
<h3>▶ 1. 이미지 파일을 선택해주세요.</h3>
<h3>▶ 2. 텍스트 추출 버튼 클릭 하세요.</h3>
<h3>▶ 3. 등록 버튼 클릭후 회원가입 진행하시면 됩니다.</h3> <br><br>
</div>
<div class="wrap_menu">
<form  class="endroll"action="extractImgtoTxt.do" method="post" enctype="multipart/form-data">
	<h2>명함 업로드 :</h2><input type="file" name="nameCardFile" id="nameCardImg" accept="image/*" onchange="previewImage(this);" required>
	<div id="preview"></div>
	<input class="textval" type="submit" value="텍스트 추출">
</form>

<form action="sendEnrollForm.do">
	<textarea  rows="4" cols="56" id="extractedTxt" name="extractedTxt" readonly>${ extractedTxt }</textarea>



<input class="textval2 " type="submit" value="등록">
 <a id="mainmove" href="main.do">시작페이지</a>
 </div>
</form>
</div>
</body>
</html>