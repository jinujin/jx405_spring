<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>인덱스</title>
</head>
<body>
<%--<h1>HELLO, WORLD!!!</h1>--%>
<%--<h2>${name} 님 환영합니다!!!</h2>--%>
<%--<core:if test="${id ne null}">--%>
<%--    <h3>사용자가 입력한 id: ${id}</h3>--%>
<%--</core:if>--%>
<%--<a href="/show?id=1&name=jinu&rank=tutor">!!!show로 이동!!!</a>--%>
<form method="post" action="/user/auth">
    아이디 : <input type="text" name = "username">
    비밀번호 : <input type="password" name = "password">
    <button type="submit">로그인</button>
</form>
${message}
<a href="/user/register">회원 가입하기</a>
</body>
</html>
