<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="currentPage" value="${requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<h2 align="center">${ requestScope.question.q_no }번 게시글 상세보기</h2>
	<br>
	<table align="center" width="500" border="1" cellspacing="0"
		cellpadding="5">
		<tr>
			<th>제 목</th>
			<td>${ question.q_title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${ question.q_writer }</td>
		</tr>
		<tr>
			<th>날 짜</th>
			<td>${ question.q_date }</td>

		</tr>
		<tr>
			<th>첨부파일</th>
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
			<th>내 용</th>
			<td>${ question.q_content }</td>
		</tr>
		<tr>
			<th colspan="2">
				<button
			onclick="history.back(-1);">목록</button>&nbsp;
			<a href="${ bdl }">[글삭제]</a>
			<c:url var="bup" value="/qnaview.do">
				<c:param name="q_no" value="${ q.q_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ bup }">[수정페이지로 이동]</a> &nbsp;
			</th>
		</tr>
	</table>
	<br>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>




