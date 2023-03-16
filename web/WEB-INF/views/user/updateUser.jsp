<%--
  Created by IntelliJ IDEA.
  User: JinWoo
  Date: 2023-03-15
  Time: 오후 8:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원정보수정</title>
</head>
<body>
<form method="post" action="/user/update">
    아이디 : <input type="text" name="username" value="${username}" readonly/><br/>
    비밀번호 : <input type="password" name="password" value="${password}"/><br/>
    닉네임 : <input type="text" name="nickname" value="${nickname}"/><br/>
    <button type="submit">수정하기</button>
    ${message}
</form>

</body>
</html>
