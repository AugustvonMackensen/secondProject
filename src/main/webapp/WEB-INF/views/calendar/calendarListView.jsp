<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
	<title>캘린더</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">

	<script type="text/javaScript" src="./modal.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./modal.css">

	<style TYPE="text/css">
		body {
		scrollbar-face-color: #F6F6F6;
		scrollbar-highlight-color: #bbbbbb;
		scrollbar-3dlight-color: #FFFFFF;
		scrollbar-shadow-color: #bbbbbb;
		scrollbar-darkshadow-color: #FFFFFF;
		scrollbar-track-color: #FFFFFF;
		scrollbar-arrow-color: #bbbbbb;
		margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
		}

		td {font-family: "돋움"; font-size: 9pt; color:#595959;}
		th {font-family: "돋움"; font-size: 9pt; color:#000000;}
		select {font-family: "돋움"; font-size: 9pt; color:#595959;}


		A:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
		A:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }
		A:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }
		A:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}
		.day{
			width:100px; 
			height:30px;
			font-weight: bold;
			font-size:15px;
			font-weight:bold;
			text-align: center;
		}
		.sat{
			color:#529dbc;
		}
		.sun{
			color:red;
		}
		.today_button_div{
			float: right;
		}
		.today_button{
			width: 100px; 
			height:30px;
		}
		.calendar{
			width:80%;
			margin:auto;
		}
		.navigation{
			margin-top:100px;
			margin-bottom:30px;
			text-align: center;
			font-size: 25px;
			vertical-align: middle;
		}
		.calendar_body{
			width:100%;
			background-color: #FFFFFF;
			border:1px solid white;
			margin-bottom: 50px;
			border-collapse: collapse;
		}
		.calendar_body .today{
			border:1px solid white;
			height:120px;
			background-color:#c9c9c9;
			text-align: left;
			vertical-align: top;
		}
		.calendar_body .date{
			font-weight: bold;
			font-size: 15px;
			padding-left: 3px;
			padding-top: 3px;
		}
		.calendar_body .sat_day{
			border:1px solid white;
			height:120px;
			background-color:#EFEFEF;
			text-align:left;
			vertical-align: top;
		}
		.calendar_body .sat_day .sat{
			color: #529dbc; 
			font-weight: bold;
			font-size: 15px;
			padding-left: 3px;
			padding-top: 3px;
		}
		.calendar_body .sun_day{
			border:1px solid white;
			height:120px;
			background-color:#EFEFEF;
			text-align: left;
			vertical-align: top;
		}
		.calendar_body .sun_day .sun{
			color: red; 
			font-weight: bold;
			font-size: 15px;
			padding-left: 3px;
			padding-top: 3px;
		}
		.calendar_body .normal_day{
			border:1px solid white;
			height:120px;
			background-color:#EFEFEF;
			vertical-align: top;
			text-align: left;
		}
		.before_after_month{
			margin: 10px;
			font-weight: bold;
		}
		.before_after_year{
			font-weight: bold;
		}
		.this_month{
			margin: 10px;
		}
		
		.buttonstyle {
			border: 1px solid #A0D9E2;
			color: #A0D9E2;
			background-color: white;
			margin-bottom: 7px;
			font-weight: bold;
			border-radius: 5px;
			font-size: 10pt;
		}
		
		.buttonstyle:hover{
			box-shadow: 0px 15px 20px rgba(131, 131, 131, 0.4);
			transform: translateY(-5px);
			background-color: #A0D9E2;
			color: white;
		}
		
		.buttonstyle:focus{
			background-color: #A0D0E2;
			color: white;
			border: 3px solid #c9c9c9;
		}
		
		.buttonstyle_bill {
			border: 1px solid #A0D9E2;
			color: #A0D9E2;
			background-color: white;
			margin-bottom: 7px;
			border-radius: 5px;
			font-size: 5pt;
		}
		
		.buttonstyle_bill:hover{
			box-shadow: 0px 15px 20px rgba(131, 131, 131, 0.4);
			transform: translateY(-5px);
			background-color: #A0D9E2;
			color: white;
		}
		
		.buttonstyle_bill:focus{
			background-color: #A0D0E2;
			color: white;
			border: 3px solid #c9c9c9;
		}
		
	</style>
</head>
<body>

<form name="calendarFrm" id="calendarFrm" action="" method="GET">

<div class="calendar" >

	<!--날짜 네비게이션  -->
	<div class="navigation">
		<a class="before_after_year" href="./calendarListView.do?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
			&lt;&lt;
		<!-- 이전해 -->
		</a> 
		<a class="before_after_month" href="./calendarListView.do?year=${today_info.before_year}&month=${today_info.before_month}">
			&lt;
		<!-- 이전달 -->
		</a> 
		<span class="this_month">
			&nbsp;${today_info.search_year}. 
			<c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
		</span>
		<a class="before_after_month" href="./calendarListView.do?year=${today_info.after_year}&month=${today_info.after_month}">
		<!-- 다음달 -->
			&gt;
		</a> 
		<a class="before_after_year" href="./calendarListView.do?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
			<!-- 다음해 -->
			&gt;&gt;
		</a>
	</div>

<!-- 현재 날짜로 돌아가기 버튼 생성 완료 -->
<div class="today_button_div">
<button type="button" class="buttonstyle" onclick="location.href='calendarListView.do'" style="height: 30ps; width:80px;">Today</button>
</div>

<table class="calendar_body">

<thead>
	<tr bgcolor="#CECECE">
		<td class="day sun" >
			일
		</td>
		<td class="day" >
			월
		</td>
		<td class="day" >
			화
		</td>
		<td class="day" >
			수
		</td>
		<td class="day" >
			목
		</td>
		<td class="day" >
			금
		</td>
		<td class="day sat" >
			토
		</td>
	</tr>
</thead>
<tbody>
	<tr>
		<c:forEach var="dateList" items="${dateList}" varStatus="date_status"> 
			<c:choose>
				<c:when test="${dateList.value=='today'}">
					<td class="today">
						<div class="date">
							${dateList.date}
							<div class="modal-dialog">
							<jsp:include page="./modal.jsp"></jsp:include>
							<button id="createBtn" type="button" data-toggle="modal" data-target="#myModal">영수증 내역</button>
							</div>
						</div>
						<div>
						</div>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==6}">
					<td class="sat_day">
						<div class="sat">
							${dateList.date}
							<div class="modal-dialog">
							<jsp:include page="./modal.jsp"></jsp:include>
							<button id="createBtn" type="button" data-toggle="modal" data-target="#myModal">영수증 내역</button>
							</div>
						</div>
						<div>
						</div>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==0}">
	</tr>
	<tr>	
		<td class="sun_day">
			<a href></a>
			<div class="sun">
				${dateList.date}
				<div class="modal-dialog">
				<jsp:include page="./modal.jsp"></jsp:include>
				<button id="createBtn" type="button" data-toggle="modal" data-target="#myModal">영수증 내역</button>
				</div>
			</div>
			<div>
			</div>
		</td>
				</c:when>
				<c:otherwise>
		<td class="normal_day">
			<div class="date">
				${dateList.date}
				<div class="modal-dialog">
				<jsp:include page="./modal.jsp"></jsp:include>
				<button id="createBtn" type="button" data-toggle="modal" data-target="#myModal">영수증 내역</button>
				</div>
			</div>
			<div>
			
			</div>
		</td>
				</c:otherwise>
			</c:choose>
		</c:forEach>
</tbody>

</table>
</div>
</form>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>