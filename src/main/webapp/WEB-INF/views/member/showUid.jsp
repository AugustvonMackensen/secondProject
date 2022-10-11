<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Noto Sans KR", sans-serif;
  }
  
  a {
    text-decoration: none;
    color: black;
  }
  
  li {
    list-style: none;
  }
  
  .wrap {
    width: 100%;
    height: 800px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(172, 140, 140, 0.1);
  }
</style>
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="wrap">
<h3> 찾으시는 아이디는 "${ requestScope.find_id }"입니다. </h3>

</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>