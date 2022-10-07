<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <title></title>
    <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link rel="stylesheet" href="resources/assets/css/templatemo-chain-app-dev.css">
    <link rel="stylesheet" href="resources/assets/css/animated.css">
    <link rel="stylesheet" href="resources/assets/css/owl.css">
  </head>
<meta charset="UTF-8">
<title>deep account book</title>
  <header class="header-area header-sticky wow slideInDown" data-wow-duration="0.75s" data-wow-delay="0s">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <nav class="main-nav">
            <!-- ***** Logo Start ***** -->
            <a href="${ pageContext.servletContext.contextPath }/main.do" class="logo">
              <span style="font-size :30px; color: #0d6efd;">DeepAccountBook</span>
            <a href="index.html" class="logo">
            </a>
            <ul class="nav">
              <li class="scroll-to-section"><a href="#top" class="active">Home</a></li>
              <li class="scroll-to-section" style=" font-family: 'Noto Sans KR', sans-serif"><a href="${ pageContext.servletContext.contextPath }/nlist.do">공지사항</a></li>
              <li class="scroll-to-section" style=" font-family: 'Noto Sans KR', sans-serif"><a href="${ pageContext.servletContext.contextPath }/qnaListView.do">Q&A게시판</a></li>
              <li class="scroll-to-section" style=" font-family: 'Noto Sans KR', sans-serif;"><a href="${ pageContext.servletContext.contextPath }/calendarListView.do">가계부</a></li>
              <c:if test="${ empty sessionScope.loginMember }">
	              <li><div class="gradient-button" ><a href="${ pageContext.servletContext.contextPath }/pickEnroll.do"> 회원가입</a></div></li> 
	              <li><div class="gradient-button" ><a href="${ pageContext.servletContext.contextPath }/loginPage.do"> 로그인</a></div></li>
              </c:if>
              <c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'Y' }">
				<li><a href="${ pageContext.servletContext.contextPath }/mlist.do">회원관리</a></li>
			 </c:if>
			
              <c:if test="${ !empty sessionScope.loginMember and loginMember.admin ne 'Y' }">
	              <li><a href="${ pageContext.servletContext.contextPath }/bill.do">지출등록Test</a></li>
	              <li>
	              <div class="gradient-button" >
	              	<c:url var="callMyinfo" value="/myinfo.do">
						<c:param name="userid" value="${ loginMember.userid }" />
					</c:url>
					<a href="${ callMyinfo }">My Page</a>
	              </div>
	              </li> 
	              
	              <li><div class="gradient-button" ><a href="${ pageContext.servletContext.contextPath }/logout.do"> 로그아웃</a></div></li>
              </c:if>
              <!-- 관리자 -->
              <c:if test="${ !empty sessionScope.loginMember and loginMember.admin eq 'Y' }">
	              <li><a href="${ pageContext.servletContext.contextPath }/bill.do">지출등록Test</a></li>
	              <li>
	              <div class="gradient-button" >
	              	<c:url var="callMyinfo" value="/myinfo.do">
						<c:param name="userid" value="${ loginMember.userid }" />
					</c:url>
					<a href="${ callMyinfo }">My Page</a>
	              </div>
	              </li> 
	              <li><div class="gradient-button" ><a href="${ pageContext.servletContext.contextPath }/logout.do"> 로그아웃</a></div></li>
              </c:if>
            </ul>                 
          </nav>
        </div>
      </div>
    </div>
  </header>
</head>
<body>

  <!-- Scripts -->
  <script src="resources/vendor/jquery/jquery.min.js"></script>
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="resources/assets/js/owl-carousel.js"></script>
  <script src="resources/assets/js/animation.js"></script>
  <script src="resources/assets/js/imagesloaded.js"></script>
  <script src="resources/assets/js/popup.js"></script>
  <script src="resources/assets/js/custom.js"></script>
</body>
</html>