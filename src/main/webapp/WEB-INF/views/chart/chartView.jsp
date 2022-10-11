<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<script type="text/javascript">

checkPie = () => {
	 // 라디오버튼 클릭시 이벤트 발생 막대차트
    $("input:radio[name=radio2]").click(function(){
 
        if($("input[name=radio2]:checked").val() == "1"){
            //$("input:text[name=text]").attr("disabled",false);
            $("input[name=pieChartMonth]").css("display", 'none');
            $("select[name=pieChartYear]").css("display", 'block');
 			//radio 버튼의 value 값이 1이라면 년도 보이게
 
        } else if($("input[name=radio2]:checked").val() == "0"){
            $("input[name=pieChartMonth]").css("display", 'block');
            $("select[name=pieChartYear]").css("display", 'none');
        } 
    });
}

checkBar = () => {
	 // 라디오버튼 클릭시 이벤트 발생 파이차트
    $("input:radio[name=radio]").click(function(){
 
        if($("input[name=radio]:checked").val() == "1"){
            //$("input:text[name=text]").attr("disabled",false);
            $("input[name=barChartMonth]").css("display", 'none');
            $("select[name=barChartYear]").css("display", 'block');
 			//radio 버튼의 value 값이 1이라면 년도 보이게
 
        } else if($("input[name=radio]:checked").val() == "0"){
            $("input[name=barChartMonth]").css("display", 'block');
            $("select[name=barChartYear]").css("display", 'none');
        } 
    });
}

function getPieChart(date) {
	let monthList = [];
	let posList = [];
	var title;
	if(date.length == 4) {
		// 년도받음
		title={
				display: true,
	        	text: date+'년 카테고리 차트'
	    }
		console.log(title);
		
	} else if(date.length == 7) {
		//년도랑 월받음
		token = date.split('-');
		console.log(token[0] + '년')
		console.log(token[1] + '월')
		title={
				display: true,
	        	text: token[0] + '년'+ token[1] + ' 월' + ' 카테고리 차트'
	    }
	}
	
	
	$.ajax({
		url:"CategoryChart.do",
		type:"get",
		data:{ userid: "${loginMember.userid}", date: date },
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
	    	        },
	    	        title: title
	    	  }
	    	  
		}); //그래프
		},
		error: (jqXHR , textStatus, errorThrown) => {
			console.log("ntop3 error : "+ jqXHR+", " + textStatus +", " +errorThrown);
			
			}
	})
}
function getChart( year ) {
	let monthList = [];
	let posList = [];
	
	
	
	$.ajax({
		url:"barChart.do",
		type:"get",
		data:{ userid: "${loginMember.userid}", year: year },
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
	    	      text: year+'년 월별 지출 차트'
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
	getChart(2022);
	getPieChart('2022');
	checkBar();
	checkPie();
	$("select[name=barChartYear]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  console.log($("select[name=barChartYear] option:selected").text()); //text값 가져오기
		  getChart($(this).val());
		  
		});
	
	$("select[name=pieChartYear]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  console.log($("select[name=barChartYear] option:selected").text()); //text값 가져오기
		  getPieChart($(this).val());
		  /* console.log($("#linechart2").css("z-index")); */
		});
	
	$("input[name=pieChartMonth]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  token = $(this).val().split('-');
		  console.log(token[0] + '년')
		  console.log(token[1] + '월')
		  getPieChart($(this).val());
		  /* var a = parseInt($("canvas[name=pie]").css("z-index"))+1;
		  console.log($("canvas[name=pie]").css("z-index"));
		  console.log(a);
		  $("canvas[name=pie]").css("z-index", String(a));
		  console.log($("canvas[name=pie]").css("z-index")); */
		});
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
                	
                	<div align="left">
                	<div style="width:200px;">
					  <input class="custom-control-input" type="radio" name="radio" id="r1" value="1"><label for="r1">년도</label>
					</div>
                	<input style="display: none;" name="barChartMonth" type="month" min="2020-01" max="2022-12">
                    <select style="display: none;" name="barChartYear"id="resv_program_type" class="form-control">
        				<option value="2020">2020년</option>
       			 		<option value="2021">2021년</option>
				    	<option value="2022">2022년</option>
				    </select>
				    </div>
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
            
            <div class="col-lg-6" style="z-index: 10;">
            		<div align="center">
                	<div class="custom-control custom-radio" style="width:200px;">
					  <input class="custom-control-input" type="radio" name="radio2" id="r1" value="1"><label class="custom-control-label" for="r1">년도</label>
					  <input class="custom-control-input" type="radio" name="radio2" id="r2" value="0"><label class="custom-control-label" for="r2">월</label>
					</div>
                	<input style="display: none;" name="pieChartMonth" type="month" min="2020-01" max="2022-12">
                    <select style="display: none; width: 100px;" name="pieChartYear"id="resv_program_type" class="form-control">
        				<option value="2020">2020년</option>
       			 		<option value="2021">2021년</option>
				    	<option value="2022">2022년</option>
				    </select>
				    </div>
              <div class="right-image wow fadeInRight" data-wow-duration="1s" data-wow-delay="0.5s">
                
                
				<c:if test="${ loginMember != null }">
				<canvas name="pie" style="z-index: 10;" id="line-chart2" width="300" height="250"></canvas>
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
