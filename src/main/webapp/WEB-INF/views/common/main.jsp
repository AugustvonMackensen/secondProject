<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">

<body>
<!-- 헤더부분 로그, 로그인 부분 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />

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


<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
