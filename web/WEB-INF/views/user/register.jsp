<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원 가입</title>
</head>
<body>
<form method="post" action="/user/register">
  아이디 : <input type="text" name="username"/><br/>
  비밀번호 : <input type="password" name="password"/><br/>
  닉네임 : <input type="text" name="nickname"/><br/>
  <button type="submit">회원가입</button>

  <button type="button" onclick="location.href='/'">로그인</button>

</form>
${message}

</body>
</html>
