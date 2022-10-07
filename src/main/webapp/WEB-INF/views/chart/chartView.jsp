<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">

<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

<script type="text/javascript">
function getPieChart() {
	let monthList = [];
	let posList = [];
	$.ajax({
		url:"CategoryChart.do",
		type:"get",
		data:{ userid: "${loginMember.userid}" },
		dataType:"json",
		success: (data) => {
			
			for (let i = 0; i<data.length;i++){    				  
				monthList.push(data[i].label);    				  
				posList.push(data[i].sumPrice);    				  
		 	 }
		console.log(monthList);
		console.log(posList);
		
		var dataset={ 
				labels: "카테고리 별 지출",
				backgroundColor: ['#ffd950', '#02bc77', '#28c3d7', '#FF6384'],
			    borderColor: '#22252B',
			    data: posList 
		};
		
		var datasets={ datasets:[dataset], labels: monthList}
		
		new Chart(document.getElementById("line-chart2"), {
	    	  type: 'pie',
	    	  data: datasets,
	    	  options: {
	    		  responsive: true,
	    	        maintainAspectRatio: false, //true 하게 되면 캔버스 width,height에 따라 리사이징된다.
	    	        legend: {
	    	            position: 'top',
	    	            fontColor: 'black',
	    	            align: 'center',
	    	            display: true,
	    	            fullWidth: true,
	    	            labels: {
	    	                fontColor: 'rgb(0, 0, 0)'
	    	            }
	    	        }
	    	  }
	    	  
		}); //그래프
		},
		error: (jqXHR , textStatus, errorThrown) => {
			console.log("ntop3 error : "+ jqXHR+", " + textStatus +", " +errorThrown);
			
			}
	})
}
function getChart() {
	let monthList = [];
	let posList = [];
	
	
	
	$.ajax({
		url:"currentYearChart.do",
		type:"get",
		data:{ userid: "${loginMember.userid}" },
		dataType:"json",
		success: (data) => {
			
			for (let i = 0; i<data.length;i++){    				  
				monthList.push(data[i].label+"월");    				  
				posList.push(data[i].sumPrice);    				  
		 	 }
		console.log(monthList);
		console.log(posList);
		
		new Chart(document.getElementById("line-chart"), {
	    	  type: 'bar',
	    	  data: {
	    	    labels: monthList, // X축 
	    	    datasets: [{ 
	    	        data: posList, // 값
	    	        label: "지출(원)",
	                backgroundColor: 'rgb(255, 99, 132)',
                    borderColor: 'rgb(255, 99, 132)',

	    	        fill: false
	    	      }
	    	    ]
	    	  },
	    	  options: {
	    	    title: {
	    	      display: true,
	    	      text: '2022년 월별 지출 차트'
	    	    }
	    	  }
	    	}); //그래프
	
		},
		error: (jqXHR , textStatus, errorThrown) => {
			console.log("ntop3 error : "+ jqXHR+", " + textStatus +", " +errorThrown);
			
			}
	})
}

$(() => {
	getChart();
	getPieChart();
});

</script>
</head>


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
                   <div class="right-image wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.5s">
                
				<c:if test="${ loginMember != null }">
				<canvas id="line-chart" width="300" height="250"></canvas>
				</c:if>
				
              </div>
                  </div>
                  
                  <div class="col-lg-12">
                  </div>
                  
                </div>
              </div>
            </div>
            
            <div class="col-lg-6">
              <div class="right-image wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.5s">
                
				<c:if test="${ loginMember != null }">
				<canvas id="line-chart2" width="300" height="250"></canvas>
				</c:if>
				
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
