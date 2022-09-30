<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

    <title>DeepAccountBook</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!--

TemplateMo 570 Chain App Dev

https://templatemo.com/tm-570-chain-app-dev

-->

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link rel="stylesheet" href="resources/assets/css/templatemo-chain-app-dev.css">
    <link rel="stylesheet" href="resources/assets/css/animated.css">
    <link rel="stylesheet" href="resources/assets/css/owl.css">

</head>
<body>
<body>

  <!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!-- ***** Preloader End ***** -->

  <!-- ***** Header Area Start ***** -->
  <header class="header-area header-sticky wow slideInDown" data-wow-duration="0.75s" data-wow-delay="0s">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <nav class="main-nav">
            <!-- ***** Logo Start ***** -->
            <a href="index.html" class="logo">
              <span style="font-size :30px">DeepAccountBook</span>
            </a>
            <!-- ***** Logo End ***** -->
            <!-- ***** Menu Start ***** -->
            <ul class="nav">
              <li class="scroll-to-section"><a href="#top" class="active">Home</a></li>
              <li class="scroll-to-section" style=" font-family: 'Noto Sans KR', sans-serif"><a href="#services">Q&A게시판</a></li>
              <li class="scroll-to-section" style=" font-family: 'Noto Sans KR', sans-serif;"><a href="${ pageContext.servletContext.contextPath }/calendarListView.do">가계부</a></li>
              <c:if test="${ empty sessionScope.loginMember }">
	              <li><div class="gradient-button" ><a href="${ pageContext.servletContext.contextPath }/enrollPage.do"> 회원가입</a></div></li> 
	              <li><div class="gradient-button" ><a href="${ pageContext.servletContext.contextPath }/loginPage.do"> 로그인</a></div></li>
              </c:if>
              <c:if test="${ !empty sessionScope.loginMember and loginMember.admin ne 'Y' }">
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

</div>
  <div class="main-banner wow fadeIn" id="top" data-wow-duration="1s" data-wow-delay="0.5s">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="row">
            <div class="col-lg-6 align-self-center">
              <div class="left-content show-up header-text wow fadeInLeft" data-wow-duration="1s" data-wow-delay="1s">
                <div class="row">
                  <div class="col-lg-12">
                    <span style="color: #3BF766; font-size: 80px;">D</span>
                    <span style="color: #7353D4; font-size: 70px;">eep</span>
                    <span style="color: #3BF766; font-size: 80px;">A</span>
                    <span style="color: #7353D4; font-size: 70px;">ccount</span></h1>
                    <span style="color: #3BF766; font-size: 80px;">B</span>
                    <span style="color: #7353D4; font-size: 70px;">ook</span></h1>
                    
                  </div>
                  <div class="col-lg-12">
                    <div class="white-button first-button scroll-to-section">
                      <a href="${ pageContext.servletContext.contextPath }/calendarListView.do" style=" font-family: 'Noto Sans KR', sans-serif; font-size: 20px">가계부로가기</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="right-image wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.5s">
                <img style="margin-left : 200px" src="resources/assets/images/slider-dec.png" alt="">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  
  


  <!-- Scripts -->
  <script src="resources/vendor/jquery/jquery.min.js"></script>
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="resources/assets/js/owl-carousel.js"></script>
  <script src="resources/assets/js/animation.js"></script>
  <script src="resources/assets/js/imagesloaded.js"></script>
  <script src="resources/assets/js/popup.js"></script>
  <script src="resources/assets/js/custom.js"></script>
</body>
</body>
</html>