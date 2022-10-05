<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="currentPage" value="${ requestScope.currentPage }"></c:set>
<c:set var="date"><fmt:formatDate type="date" pattern="yyyy MM dd" value="${ bill.bill_timestamp }"/></c:set>
<c:set var="date2"><fmt:formatDate type="date" pattern="yyyy-MM-dd'T'HH:mm:ss" value="${ bill.bill_timestamp }"/></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<style type="text/css">
	.editable{
		color:#880000; 
		background-color: #d3d3d3;
	}
</style>

<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
categoryCheck = () => {$('#bill_category input[value="${bill.bill_category}"]').attr('checked', true)};
$(() => {

		//document.querySelector("#bill_category input[value='${bill.bill_category}']").setAttribute('checked', true)
	categoryCheck();
	
	
		
	$("input[name=update]").click(() => {
		// 수정클릭시
	
		$('input[name=bill_category]').attr('disabled', false);
		$(".editable:input").attr('readonly', false); //이걸로 쉽게됨... ㅋ
		$(".editable:input").css('backgroundColor', "#ffffff", "color", "#ffffff");
		
		$("input[name=update]").css("display", "none");
		$("input[name=apply]").css("display", "inline");
	});
	
	$("input[name=rollback]").click(() => {
		// 취소클릭시
		$('input[name=bill_category]').attr('disabled', true);
		
		$(".editable:input").attr('readonly', true); //이걸로 쉽게됨... ㅋ
		$(".editable:input").css('backgroundColor', "#d3d3d3", "color", "#880000");
		
		
		$("input[name=update]").css("display", "inline");
		$("input[name=apply]").css("display", "none");
	});
	
	
	// 삭제클릭시
	$("#delete").click(() => {
/* 		var rlt = confirm('삭제하시겠습니까?'); 

		if(rlt){ //확인
			console.log("삭제 확인 누름");
			location.href = "${ pageContext.servletContext.contextPath }/deleteBill.do?bill_id=${bill.id}";
			
		}

		else {

		// 취소 눌렀을시 
			console.log("취소 누름");
		} */
		
		Swal.fire({
			  title: '지출을 삭제하시겠습니까???',
			  text: "삭제하시면 다시 복구시킬 수 없습니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.value) {
	              //"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다.
	              console.log("삭제 확인 누름");
	              Swal.fire({
	            	  icon: 'success',
	            	  title:"삭제되었습니다.", 
	              }).then((result2) =>{
	           	  location.href = "${ pageContext.servletContext.contextPath }/deleteBill.do?bill_id=${bill.id}";
	         
				  
	              
	              });
			  }
			})
	});
	
});


</script>
</head>
<body>

	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
	<hr>
	<h2 align="center">지출 상세보기</h2>
	<br>
	<form action="updateBill.do" method="post">
		<input type="hidden" name="id" value="${ bill.id }">
		<input type="hidden" name="bill_id" value="${ bill.id }">
		<input type="hidden" name="page" value="${ currentPage }">
		<table align="center" width="410" border="1" cellspacing="0"
			cellpadding="5">
			
			
			<tr>
				<th width="120">아이디</th>
				<td><input type="text" name="userid"
					value="${ loginMember.userid }" style="color:#880000; background-color: #d3d3d3;" readonly></td>
			</tr>
			
			<tr>
				<th width="120">지출 금액</th>
				<td><input class="editable" type="text" name="bill_price" value="${ bill.bill_price }" readonly></td>
			</tr>
			
			<tr>
				<th width="120">결제 날짜 및 &nbsp; 시간</th>
				<td><input class="editable" type="datetime-local" name="bill_timestamp2"
					id="bill_timestamp" value="${ date2 }" readonly></td>
			</tr>
			
			<tr>
				<th width="120">내용</th>
				<td><textarea class="editable" rows="5" cols="32" name="bill_content"
						id="bill_content"  readonly>${bill.bill_content}</textarea></td>
			</tr>
			
			<tr>
				<th width="120">카테고리</th>
				<td id="bill_category">
							<input type="radio" name="bill_category" value="식비" readonly disabled>식비
					&nbsp; <input type="radio" name="bill_category" value="문화/여가" readonly disabled>문화/여가
					&nbsp; <input type="radio" name="bill_category" value="교통비" readonly disabled>교통비
					&nbsp; <input type="radio" name="bill_category" value="기타" readonly disabled >기타
				</td>
			</tr>
			
			<tr id="cardinfo">
				<th width="120">카드 정보</th>
				<td><input class="editable" type="text" name="bill_cardinfo" value="${ bill.bill_cardinfo }" readonly></td>
			</tr>
			<tr id="store_name">
				<th width="120">상호명</th>
				<td><input class="editable" type="text" name="bill_storeinfo_name" value="${ bill.bill_storeinfo_name }" readonly></td>
			</tr>
			<tr id="store_bizNum">
				<th width="120">사업자 번호</th>
				<td><input class="editable" type="text" name="bill_storeinfo_biznum" value="${ bill.bill_storeinfo_biznum }" readonly></td>
			</tr>
			<tr id="store_tel">
				<th width="120">매장 전화번호</th>
				<td><input class="editable" type="text" name="bill_storeinfo_tel" value="${ bill.bill_storeinfo_tel }" readonly></td>
			</tr>
			
			<tr>
				<th colspan="2">
					<c:set var="date"><fmt:formatDate type="date" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSX" value="${ bill.bill_timestamp }"/></c:set>
					<button class="btn btn-primary" type="button"
						onclick="javascript:location.href='billListView.do?page=${ currentPage }&userid=${ loginMember.userid }&date=${date}'">목록</button>
					&nbsp;
						<input class="btn btn-primary" type="button" name="update" value="수정">
						<input class="btn btn-success" style="display: none" type="submit" name="apply" value="적용"> &nbsp;
						<input class="btn btn-warning" type="reset" name="rollback" value="취소">
						<c:url var="bdl" value="/deleteBill.do">
							<c:param name="bill_id" value="${ bill.id }" />
						</c:url>
						<div  style="float:right; text-align: right;"><input style="background-color: #ff0000;" class="btn btn-danger" type="button"  type="button" id="delete" value="삭제"></div>
		
				</th>
			</tr>
		</table>
	</form>
	<hr>
	<%-- <c:import url="/WEB-INF/views/common/footer.jsp" /> --%>



</body>
</html>