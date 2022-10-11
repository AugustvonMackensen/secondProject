<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

table, tr, th, td {
        border: 1px solid #bcbcbc;
      }
      table {
      width: 1300px;
        height: 300px;
      }
</style>
<title>Insert title here</title>
<script type="text/javascript">
function showreplydiv(){
	var replydiv = document.getElementById("replydiv");
	if(replydiv.style.display == "none"){
		replydiv.style.display = 'block';
	}else{
		replydiv.style.display = 'none';
	}
}


</script>

</head>
<body>
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<h2 align="center">${ requestScope.question.q_no }번 게시글 상세보기</h2>
	<br>
	<table align="center" border="1" cellspacing="0"
		cellpadding="5">
		<tr>
			<th>제 목 : </th>
			<td>${ question.q_title }</td>
		</tr>
		<tr>
			<th>작성자 : </th>
			<td>${ question.q_writer }</td>
		</tr>
		<tr>
			<th>날 짜 : </th>
			<td>${ question.q_date }</td>

		</tr>
		<tr>
			<th>첨부파일 : </th>
			<td>
				<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 --> <c:if
					test="${ !empty question.q_original_filename }">

					<a href="${ bfd }">${ question.q_original_filename }</a>
				</c:if> <!-- 첨부파일이 없다면 공백으로 처리함 --> <c:if
					test="${ empty question.q_original_filename }">
				&nbsp;
			</c:if>
			</td>
		</tr>
		<tr>
			<th>내 용 : </th>
			<td>${ question.q_content }</td></tr>
			<tr><th colspan="2">
		<button onclick="javascript:location.href='qnaListView.do?=${currentPage}';">목록</button>
	<!-- 본인이 등록한 게시글일 때는 수정과 삭제 기능 제공 -->
		<c:if test="${ requestScope.question.q_writer eq sessionScope.loginMember.userid }">
			<c:url var="bup" value="/qupview.do">
				<c:param name="q_no" value="${ question.q_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ bup }">[수정페이지로 이동]</a> &nbsp;
			<c:url var="bdl" value="/qdel.do">
				<c:param name="q_no" value="${ question.q_no }" />
				<c:param name="q_rename_filename" value="${ question.q_rename_filename}" />
			</c:url>
			<a href="${ bdl }">[글삭제]</a> &nbsp;
		</c:if>
		<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'Y'}">
			<button onclick="showreplydiv();" id="replybtn">댓글달기</button> &nbsp;
		</c:if>
		
		</tr>
		</tr>
	</table>
	<!-- 댓글 시작~ -->

<div id="replydiv" style="display:none;">
<form action="reply.do" method="post" >
 <!-- 원글 번호도 함께 숨겨서 전송 -->
	<input type="hidden" name="a_ref" value="${ question.q_no }">
	<input type="hidden" name="page" value="${ currentPage }">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="a_title"></td></tr>
	<tr><th>작성자</th>
	<td><input type="text" name="a_writer" readonly value="${ loginMember.userid }"></td></tr>
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="a_content"></textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="댓글등록하기"> &nbsp; 
		<input type="reset" value="작성취소"> &nbsp; 
		<button onclick="javascript:history.go(-1); return false;">이전페이지로 이동</button>
	</th></tr>
</table>
</form> 
</div>
 <hr>
 <c:forEach items="${ requestScope.replylist }" var="r">
		<tr>
		<th>번호 : </th>
		<td>${ r.a_id }</td>
		</tr>
		<tr><br>
			<th>제목 : </th>
			<td>${r.a_title }</td>
		</tr><br>
		<tr>
			<th>작성자 : </th>
			<td>${ r.a_writer }</td>
		</tr><br>
		<tr><th>날짜 : </th>
			<td><fmt:formatDate value="${ r.a_date }" pattern="yyyy-MM-dd" /></td></tr>
			<tr><br>
			<th>내용 : </th>
			<td>${r.a_content }</td>
			</tr>
			<div>
			<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'Y'}">
				<c:url var="aup" value="/aupview.do">
					<c:param name="a_ref" value="${ r.a_ref }" />
					<c:param name="page" value="${ currentPage }" />
				</c:url>
				<a href="${ aup }">[수정페이지로 이동]</a> &nbsp;
				<c:url var="bdl" value="/adel.do">
					<c:param name="a_ref" value="${ r.a_ref }" />
					<c:param name="page" value="${ currentPage }" />
				</c:url>
				<a href="${ bdl }">[글삭제]</a> &nbsp;
			</c:if>
			</div>
			<hr>
	</c:forEach>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>




