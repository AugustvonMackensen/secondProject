<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
  a:visited {
  color : black;
}
  
  li {
    list-style: none;
  }
  
  .wrap {
    width: 100%;
    height:800px;
    display: flex;
    align-items: center;
    justify-content: center;
      background: rgba(172, 140, 140, 0.1);
    
  }

  .login {
    width: 30%;
    height: 700px;
    background: rgb(255, 255, 255);
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column; 
    
  }
  
  h2 {
    color: tomato;
    font-size: 2em;
  }
  .login_sns {
    padding: 20px;
    display: flex;
  }
  
  .login_sns li {
    padding: 0px 15px;
  }
  
  
  .login_id {
    margin-top: 20px;
    width: 80%;
  }
  
  .login_id input {
    width: 100%;
    height: 50px;
    border-radius: 30px;
    margin-top: 10px;
    padding: 0px 20px;
    border: 1px solid lightgray;
    outline: none;
  }
  
  .login_pw {
    margin-top: 20px;
    width: 80%;
  }
  
  .login_pw input {
    width: 100%;
    height: 50px;
    border-radius: 30px;
    margin-top: 10px;
    padding: 0px 20px;
    border: 1px solid lightgray;
    outline: none;
  }

  
  .submit {
    margin-top: 50px;
    width: 80%;
    color: rgb(255, 255, 255);
  }
  .submit input {
    width: 100%;
    height: 50px;
    border: 0;
    outline: none;
    border-radius: 40px;
	background: linear-gradient(105deg, rgba(91,104,235,1) 0%, rgba(40,225,253,1) 100%);
    font-size: 1.2em;
    letter-spacing: 2px;
    color:white;
  }
.loginmenu {
    display: flex;
    flex-direction: row;
    font-size: 20px;
}
.loginmenu .schid {
    margin: 10px;
}
.loginmenu .schpw {
    margin: 10px;
}
.loginmenu .join {
    margin: 10px;
}

</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />


<form action="login.do" method="post">
<div class="wrap">
<div class="login">
<h1 style="color: #0d6efd; align="center">DeepAccountBook</h1><br>
  <div class="login_id">
  <h4>아이디</h4> <input type="text" name="userid" class="pos" placeholder="ID를 입력해주세요."> <br><br>
   </div>
   <div class="login_pw">
 <h4>비밀번호</h4><input type="password" name="userpwd" class="pos" placeholder="비밀번호를 입력해주세요."></label> <br><br>
   </div>
     <div class="submit">
<input type="submit" value="로그인"><br>
</div>
 <div class="loginmenu">
 <div class="schid">
 <c:url var="mvfindId" value="/moveIdRecovery.do" />
<a href="${ mvfindId }">아이디 찾기</a> &nbsp; &nbsp; | &nbsp;
</div>
  <div class="schpw">
  <c:url var="mvfindPwd" value="/movePwdRecovery.do" />
<a href="${ mvfindPwd }">비밀번호 찾기</a>
</div>
</div>
     </div>
</div>
</form>
<br>


</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>