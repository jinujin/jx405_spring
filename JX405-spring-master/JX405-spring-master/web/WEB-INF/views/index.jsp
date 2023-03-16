<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>인덱스</title>
</head>
<body>
<form method="post" action="/user/auth">
    아이디 <input type="text" name="username"/>
    비밀번호 <input type="password" name="password"/>
    <button type="submit">로그인</button>
</form>
${message}
<a href="/user/register">회원가입</a>
</body>
</html>
