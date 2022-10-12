<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
table th {
	background-color: #99ffff;
}

table#outer {
	border: 2px solid navy;
}
</style>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript">
	//아이디 중복 체크 확인을 위한 ajax 실행처리용 함수
	//ajax(Asynchronous Javascript And Xml) :
	// 페이지를 바꾸지 않고, 서버와 통신하는 기술
	// (서버측에 서비스 요청하고 결과받음)
	function dupCheckId() {
		//입력된 아이디가 중복되지 않았는 확인 : jQuery.ajax() 사용
		//jQuery 는 $ 로 줄일 수 있음
		$.ajax({
			url : "idchk.do",
			type : "post",
			data : {
				userid : $("#userid").val()
			},
			success : function(data) {
				console.log("success : " + data);
				if (data == "ok") {
					alert("사용 가능한 아이디입니다.");
					$("#upwd1").focus();
				} else {
					alert("이미 사용중인 아이디입니다.\n다시 입력하세요.");
					$("#userid").select();
				}
			},

			error : function(jqXHR, textStatus, errorThrown) {
				console.log("error : " + jqXHR + ", " + textStatus + ", "
						+ errorThrown);
			}
		});
		return false; //클릭 이벤트 전달을 막음
	}

	function validate() {
		//전송보내기 전(submit 버튼 클릭시) 입력값 유효한 값인지 검사

		//암호와 암호확인이 일치하는지 확인

		return true;
	}
	//비어있는지 확인하는 함수
	isEmpty = (value) => {

		if (value == ""
				|| value == null
				|| value == undefined
				|| (value != null && typeof value == "object" && !Object
						.keys(value).length)) {
			return true
		} else {
			return false
		}
	};

	function upload() {
		const imageInput = $("#imageInput")[0];
		// 파일을 여러개 선택할 수 있으므로 files 라는 객체에 담긴다.
		console.log("imageInput: ", imageInput.files)

		if (imageInput.files.length === 0) {
			alert("파일은 선택해주세요");
			return;
		}

		const formData = new FormData();
		formData.append("image", imageInput.files[0]);

		$.ajax({
			type : "POST",
			url : "imageToText.do",
			processData : false,
			contentType : false,
			data : formData,
			dataType : "json",
			success : function(data) {
				console.log("rtn: ", data)
				//var jsonStr = JSON.stringify(data);
				//var json = JSON.parse(data);
				var message = '성공!';
				console.log("message: ", message);
				console.log("fcardnum: ", data.fCardnum);
				
				var fcardnum = !isEmpty(data.fCardnum) ? JSON.parse(data.fCardnum) : "null";
				console.log("fcardnum.value: ", fcardnum.value);

				var fCom = !isEmpty(data.fCom) ? JSON.parse(data.fCom) : "null";
				console.log("카드사 : " + fCom.value);
				
				var fmtDate = ""; //날짜구하기
				if( !isEmpty(data.fDate) ){
					var fDate = JSON.parse(data.fDate);
					console.log(fDate.year + "년" + fDate.month + "월" + fDate.day
							+ "일")
					var year = fDate.year
	
					if (year == "" || year.length == 0){
						//year = 2022 //년도가 비어있다면 현재 년도를 넣어줌
						var now = new Date();
						var year = now.getFullYear();
						console.log(year);
					}
					fmtDate = year + "-" + fDate.month + "-" + fDate.day;
				}
				
				var fmtTime = ""; // 시간구하기
				if ( !isEmpty(data.fTime)) {
					var fTime = JSON.parse(data.fTime);
					fmtTime = fTime.hour + ":" + fTime.minute + ":"
							+ fTime.second;
				}
				$("input[name=bill_timestamp2]").attr('value',
						fmtDate + "T" + fmtTime);

				console.log(fTime.hour + "시" + fTime.minute + "분"
						+ fTime.second + "초");
				
				//총가격
				
				if ( !isEmpty(data.fTotalPrice) ){
					console.log("총가격 확인"+data.fTotalPrice)
					$("input[name=bill_price]").attr('value', data.fTotalPrice)
				} else if(!isEmpty(data.subResults_size)) {
					console.log("sub개수(total없을경우 계산용) : " + data.subResults_size);
					var sum=0;
					for ( var i in data.subResults) {
						var sub = data.subResults[i].subResults_subPrice ?? 'empty';
						if( sub != 'empty' )
							sum += parseInt(data.subResults[i].subResults_subPrice);
					}
					$("input[name=bill_price]").attr('value', sum)
				}
				//내용에 상품명 수량 가격 넣기
				//$("#resultUploadPath").text(message);
				$("textarea[name=bill_content]").text(""); // 먼저 비우기
				if (data.subResults_size > 0) {
					console.log("sub개수 : " + data.subResults_size);
					var content = ""
					console.log(data.subResults)
					for ( var i in data.subResults) {
						console.log(data.subResults[i].subResults_name);
						console.log(data.subResults[i].subResults_count);
						console.log(data.subResults[i].subResults_subPrice);
						content += data.subResults[i].subResults_name + " "
								+ data.subResults[i].subResults_count + "개 "
								+ data.subResults[i].subResults_subPrice
								+ "원\n";
					}

					$("textarea[name=bill_content]").text(content);
				} //

/* 				// 내용 마지막줄에 전화번호 넣기 존재하면 ====컬럼으로추가함
				if (!isEmpty(data.storeInfo_tel)) {
					$("textarea[name=bill_content]").text(
							$("textarea[name=bill_content]").text()
									+ "\n가게 전화번호 : " + data.storeInfo_tel
									+ "\n");
				} */
				
				//영수증 ocr 입력시 존재하면 보임
				$("input[name=bill_storeinfo_name]").attr('value',
							"");
				if (!isEmpty(data.storeInfo_name.length)) {
					$("input[name=bill_storeinfo_name]").attr('value',
							data.storeInfo_name);
					$('#store_name').show();
				}
				
				$("input[name=bill_storeinfo_biznum]").attr('value',
						"");
				if (!isEmpty(data.storeInfo_bizNum.length)) {
					$("input[name=bill_storeinfo_biznum]").attr('value',
							data.storeInfo_bizNum);
					$('#store_bizNum').show();
				}
				
				console.log(fcardnum.value.length);
				console.log(fCom.value.length);
				$("input[name=bill_cardinfo]").attr('value',
						"");
				if (!isEmpty(fcardnum.value.length) && !isEmpty(fCom.value.length) ) {
					$("input[name=bill_cardinfo]").attr('value',
							fCom.value + " " + fcardnum.value);
					$('#cardinfo').show();
				}
				
				$("input[name=bill_storeinfo_tel]").attr('value',
						"");
				if (!isEmpty(data.storeInfo_tel)) {
					// 매장 전화번호 전달 받았을 경우
					$("input[name=bill_storeinfo_tel]").attr('value',
							data.storeInfo_tel);
					$('#store_tel').show();
					
				}
				
				
				//식비 체크 
				$("input:radio[name=bill_category]:radio[value='식비']").prop(
						'checked', true);
				
				Swal.fire({
	            	  icon: 'success',
	            	  title:"영수증 정보를 성공적으로 가져왔습니다.", 
	              })
			},
			err : function(err) {
				var message = '실패!';
				//$("#resultUploadPath").text(message);
				console.log("err:", err)
			}
		})
	}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<p></p>
	
	
		<form id="uploadForm" enctype="multipart/form-data">
			<table>
			<tr>
			<td><input type="file" id="imageInput" /></td>
			</tr>
			<tr>
			<td><input type="button" onclick="upload()" value="영수증 정보 가져오기"/></td>
			</tr>
		</table>
		</form>
	
	<br>
	
	
	<div align="right"><a class="btn btn-primary" href="./multiReg.do">여러 영수증 이미지로 지출 등록하기</a></div>
	<h1 align="center">지출 등록 페이지</h1>
	<br>
	<form action="insertBill.do" method="post">
		<table id="outer" align="center" width="550" cellspacing="5"
			cellpadding="0">
			<tr>
				<th colspan="2">지출 정보를 입력해주세요. (* 표시는 필수입력 항목입니다.)</th>
			</tr>
			<tr>
				<th width="120">아이디</th>
				<td><input type="text" name="userid"
					value="${ loginMember.userid }" readonly style="background-color:  #d3d3d3;"></td>
			</tr>
			<tr>
				<th width="120">* 지출 금액</th>
				<td><input type="text" name="bill_price" required></td>
			</tr>
			<tr>
				<th width="120">* 결제 시간</th>
				<td><input type="datetime-local" name="bill_timestamp2"
					id="bill_timestamp" required> &nbsp; &nbsp; </td>
			</tr>
			<tr>
				<th width="120">내용</th>
				<td><textarea rows="5" cols="50" name="bill_content"
						id="bill_content"></textarea></td>
			</tr>
			<tr>
				<th width="120">* 카테고리</th>
				<td><input type="radio" name="bill_category" value="식비">식비
					&nbsp; <input type="radio" name="bill_category" value="문화/여가">문화/여가
					&nbsp; <input type="radio" name="bill_category" value="교통비">교통비
					&nbsp; <input type="radio" name="bill_category" value="기타" checked>기타
				</td>
			</tr>

			<tr style="display: none" id="cardinfo">
				<th width="120">카드 정보</th>
				<td><input type="text" name="bill_cardinfo"></td>
			</tr>
			<tr style="display: none" id="store_name">
				<th width="120">상호명</th>
				<td><input type="text" name="bill_storeinfo_name"></td>
			</tr>
			<tr style="display: none" id="store_bizNum">
				<th width="120">사업자 번호</th>
				<td><input type="text" name="bill_storeinfo_biznum"></td>
			</tr>
			<tr style="display: none" id="store_tel">
				<th width="120">매장 전화번호</th>
				<td><input type="text" name="bill_storeinfo_tel"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="등록하기">
					&nbsp; <input type="reset" value="작성취소"> &nbsp; <a
					href="main.do">시작페이지로 이동</a></th>
			</tr>


		</table>
	</form>


	<hr style="clear: both;">
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>