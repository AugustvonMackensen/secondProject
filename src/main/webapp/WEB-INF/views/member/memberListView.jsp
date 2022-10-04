<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
form.sform {
	display: none; /*안 보이게 설정*/
	background: lightgray;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

$(function(){
	// 작성된 이벤트 실행 코드는 이벤트가 발생될 때까지 대기상태가 됨
	// jQuery('태그선택자').실행할메소드(전달값, ......);
	$('input[name=item]').on('change', function(){
		// change 이벤트가 발생한 radio 와 연결된 폼만 보여지게 하고, 
		// 나머지 폼들은 안보이게 처리함
		$('input[name=item]').each(function(index){
			// 해당 index 번째 radio 가 checked 인지 확인하고
			if($(this).is(':checked')){
				$('form.sform').eq(index).css('display', 'block');
			}else{
				$('form.sform').eq(index).css('display', 'none');
			}
			
		});
	});
});

//로그인 제한/가능 레디오 체크가 변경되었을 때 실행되는 함수
function changeLogin(element){
	//선택한 radio의 name 속성의 이름에서 userid 분리 추출함
	var userid = element.name.substring(7);
	console.log("changeLogin : " + userid);
	if(element.checked == true && element.value == "N"){
		//로그인 제한을 체크했다면
		console.log("로그인 제한 체크함");
		location.href="${pageContext.servletContext.contextPath}/loginok.do?userid=" + userid + "&loginok=N";
	} else {
		console.log("로그인 제한 해제함");
		location.href="${pageContext.servletContext.contextPath}/loginok.do?userid=" + userid + "&loginok=Y";
	}
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<hr>
<h1 align="center">회원 관리 페이지</h1>
<h2 align="center">현재 회원수 : ${ list.size() } 명</h2>
<center>
	<button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/mlist.do';">전체 보기</button>

<!-- 조회해 온 회원 리스트 정보 출력 처리 -->
<table align="center" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<th>아이디</th>
		<th>이메일</th>
		<th>로그인 활성/비활성</th>
	</tr>
	
	<c:forEach items="${ requestScope.list }" var="m">
		<tr>
			<td>${ m.userid }</td>
			<td>${ m.email }</td>
			<td>
				<c:if test="${m.loginok eq 'Y' }">
					<input type="radio"	name="loginok_${m.userid }" 		value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
					<input type="radio"	name="loginok_${m.userid }" 		value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
				</c:if>
				<c:if test="${m.loginok eq 'N' }">
					<input type="radio"	name="loginok_${m.userid }" 		value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
					<input type="radio" 	name="loginok_${m.userid }" 		value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
				</c:if>
			</td>
		</tr>
	</c:forEach>

</table>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>