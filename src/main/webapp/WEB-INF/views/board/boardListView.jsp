<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />


<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}
table.qa-table{
   width: 1300px;
   text-align:center;
   border : 1px solid #ccc;
   margin-left: auto; 
   margin-right: auto;
   border-collapse: collapse;
   line-height: 1.5;
}
table.qa-table thead{
   border-right: 1px solid #ccc;
   border-left: 1px solid #ccc;
   background: #4886FA;
}
table.qa-table thead th {
   padding: 10px;
   font-weight: bold;
   vertical-align: top;
   color: #fff;
}
table.qa-table tbody tr{;
   font-weight: bold;
   border-bottom: 1px solid #ccc;
   background: #F0F8FF;
   height : 38px;
}
.paging {
    position: fixed;
    bottom: 100px;
    width: 100%;
   text-align : center;
}
</style>

<script type="text/javascript"
   src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.6.1.min.js"></script>
   
<script language="JavaScript" type="text/javascript">
function Change(){
 var key = test.value;
 if(key==1){
 document.all["d1"].style.display="block";
 document.all["d2"].style.display="none";
 document.all["d3"].style.display="none"; 
 }
 if(key==2){
 document.all["d1"].style.display="none";
 document.all["d2"].style.display="block";
 document.all["d3"].style.display="none";
 }
 if(key==3){
 document.all["d1"].style.display="none";
 document.all["d2"].style.display="none";
 document.all["d3"].style.display="block";
 }
}

// ????????? ?????? ????????? ???????????? ?????? 
function showWriteForm() {
   //???????????? ?????? ???????????? ?????? ?????? 
    location.href = "${pageContext.servletContext.contextPath}/bwform.do";
}

</script>


</head>
<body>
   <!--??????????????? ?????? ????????? ????????? ????????? ??????  -->
   <c:import url="../common/menubar.jsp" />
   <br>
   <h1 align="center">?????? ????????? ??????</h1><br>

   <center>
   <c:if test="${ !empty sessionScope.loginMember }">         
   <button onclick="showWriteForm();" style="width: 6rem; border-radius: 10px;  height:3rem; background-color:#4b8ef1; color:white; border:3px solid; #f8f9fa;">?????????</button> 
   <button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/blist.do';" style="width: 10rem; border-radius: 10px;  height:3rem; background-color:#4b8ef1; color:white; border:3px solid; #f8f9fa;">?????? ?????? ??????</button> &nbsp; &nbsp; &nbsp; &nbsp;
   </c:if>
   </center>
   <!-- ?????? ?????? ??????  -->
   
 <div align="center" >
         <select id="test" onchange="Change()" style="width: 6rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:48px;text-align:center; right:308px;">
      <option value="1">??????</option>
      <option value="2">?????????</option>
      <option value="3">??????</option>
         </select>

      <div id="d1" style="display: block">
         <form action="searchTitle.do" method="get" >
            <input type="search" name="keyword"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"> &nbsp; &nbsp; &nbsp;
            <input type="submit" value="??????"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d2" style="display: none">
      <form action="searchWriter.do" method="get">   
           <input type="search" name="keyword"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"> &nbsp; &nbsp; &nbsp;
           <input type="submit" value="??????"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
      <div id="d3" style="display: none">
         <form action="searchDate.do" method="get"  >
            <input type="date" name="begin" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> <input type="date"
               name="end"  style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> &nbsp; &nbsp; &nbsp; <input type="submit" value="??????"  style="width: 6rem;height:3rem;border:none; background-color:#4b8ef1; cursor:pointer;" class="btn">
         </form>
      </div>
   </div>

   <!-- ?????? ?????? ?????? -->
   <br>
<br>
<table class="qa-table">
   <thead>
      <tr>
      <th scope="cols">??????</th>
      <th scope="cols">??????</th>
      <th scope="cols">?????????</th>
      <th scope="cols">??????</th>
      <th scope="cols">?????????</th>
      <th scope="cols">????????????</th>
      </tr>
   </thead>
   <tbody>
   <c:forEach items="${ requestScope.list }" var="b">
      <tr>
         <td>${ b.board_num }</td>
         <c:url var="bdt" value="/bdetail.do">
            <c:param name="board_num" value="${ b.board_num }" />
            <c:param name ="page" value="${currentPage }" />
         </c:url>
         <td><a href="${ bdt }" style="color:blue;">${ b.board_title }</a></td>
         <td>${ b.board_writer }</td>

         <td><fmt:formatDate value="${ b.board_date }" pattern="yyyy-MM-dd" /></td>
         <td>${ b.board_readcount }</td>
         <td>
            <c:if test="${ !empty b.board_original_filename }">???</c:if>
            <c:if test="${ empty b.board_original_filename }">&nbsp;</c:if>
         </td>
         


    </tr>
   </c:forEach>
   </tbody>
</table>

<!-- ?????? ?????? ????????? ?????? -->
<c:if test="${ empty action }">

<div style="text-align:center;"> <!-- ????????? ?????? ?????? -->
   <!-- 1???????????? ?????? ?????? -->
   <c:if test="${ currentPage eq 1 }">
      [?????????] &nbsp;
   </c:if>
   <c:if test="${ currentPage > 1 }">
      <c:url var="bl" value="/blist.do">
         <c:param name="page" value="1" />
      </c:url>
      <a href="${ bl }">[?????????]</a> &nbsp;
   </c:if>
   <!-- ?????? ????????????????????? ?????? ?????? -->
   <c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
      <c:url var="bl2" value="/blist.do">
         <c:param name="page" value="${ startPage - 10 }" />
      </c:url>
      <a href="${ bl2 }">[????????????]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
      [????????????] &nbsp;
   </c:if>
   <!-- ?????? ???????????? ?????? ????????? ?????? ????????? ?????? ?????? -->
   <c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
      <c:if test="${ p eq currentPage }">
         <font size="4" color="red"><b>[${ p }]</b></font>
      </c:if>
      <c:if test="${ p ne currentPage }">
         <c:url var="bl3" value="/blist.do">
         <c:param name="page" value="${ p }" />
      </c:url>
      <a href="${ bl3 }">${ p }</a> 
      </c:if>
   </c:forEach>
   <!-- ?????? ????????????????????? ?????? ?????? -->
   <c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
      <c:url var="bl4" value="/blist.do">
         <c:param name="page" value="${ endPage + 10 }" />
      </c:url>
      <a href="${ bl4 }">[????????????]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
      [????????????] &nbsp;
   </c:if>
   <!-- ??????????????? ?????? ?????? -->
   <c:if test="${ currentPage eq maxPage }">
      [??????] &nbsp; 
   </c:if>
   <c:if test="${ currentPage < maxPage }">
      <c:url var="bl5" value="/blist.do">
         <c:param name="page" value="${ maxPage }" />
      </c:url>
      <a href="${ bl5 }">[??????]</a> &nbsp;
   </c:if>
</div>
</c:if> <!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<!-- ?????? ?????? ????????? ?????? -->
<c:if test="${ !empty action }">
<!-- ?????? ?????? ????????? ?????? -->


<div style="text-align:center;"> <!-- ????????? ?????? ?????? -->
   <!-- 1???????????? ?????? ?????? -->
   <c:if test="${ currentPage eq 1 }">
       [?????????] &nbsp;
   </c:if>
   <c:if test="${ currentPage > 1 }">
         <c:if test="${ action eq 'title' }">
            <c:url var="nsl" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="1" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="1" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="1" />
            </c:url>
         </c:if>
      <a href="${ nsl }">[?????????]</a> &nbsp;
   </c:if>
   <!-- ?????? ????????????????????? ?????? ?????? -->
   <c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
      <c:if test="${ action eq 'title' }">
            <c:url var="nsl2" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ startPage - 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl2" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ startPage - 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl2" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ startPage - 10 }" />
            </c:url>
         </c:if>
      <a href="${ nsl2 }">[????????????]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
      [????????????] &nbsp;
   </c:if>
   <!-- ?????? ???????????? ?????? ????????? ?????? ????????? ?????? ?????? -->
   <c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
      <c:if test="${ p eq currentPage }">
         <font size="4" color="red"><b>[${ p }]</b></font>
      </c:if>
      <c:if test="${ p ne currentPage }">
         <c:if test="${ action eq 'title' }">
            <c:url var="nsl3" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ p }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl3" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ p }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl3" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ p }" />
            </c:url>
         </c:if>
         <a href="${ nsl3 }">${ p }</a> 
      </c:if>
   </c:forEach>
   <!-- ?????? ????????????????????? ?????? ?????? -->
   <c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
      <c:if test="${ action eq 'title' }">
            <c:url var="nsl4" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ endPage + 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl4" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ endPage + 10 }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl4" value="nsearchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ endPage + 10 }" />
            </c:url>
         </c:if>
      <a href="${ nsl4 }">[????????????]</a> &nbsp;
   </c:if>
   <c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
      [????????????] &nbsp;
   </c:if>
   <!-- ??????????????? ?????? ?????? -->
   <c:if test="${ currentPage eq maxPage }">
      [??????] &nbsp; 
   </c:if>
   <c:if test="${ currentPage < maxPage }">
      <c:if test="${ action eq 'title' }">
            <c:url var="nsl5" value="searchTitle.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ maxPage }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'writer' }">
            <c:url var="nsl5" value="searchWriter.do">
               <c:param name="keyword" value="${ keyword }" />
               <c:param name="page" value="${ maxPage }" />
            </c:url>
         </c:if>
      
         <c:if test="${ action eq 'date' }">
            <c:url var="nsl5" value="searchDate.do">
               <c:param name="begin" value="${ begin }" />
               <c:param name="end" value="${ end }" />
               <c:param name="page" value="${ maxPage }" />
            </c:url>
         </c:if>
      <a href="${ nsl5 }">[??????]</a> &nbsp;
   </c:if>
</div>
</c:if> <!-- ?????? ?????? ????????? ?????? -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>





