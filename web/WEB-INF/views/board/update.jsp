<%--
  Created by IntelliJ IDEA.
  User: JinWoo
  Date: 2023-03-15
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="/board/update/">
  <input type="hidden" name="id" value="${result.id}">
  <input type="text" name="title" value="${result.title}">
  <input type="text" name="content" value="${result.content}">
  <button type="submit">수정하기</button>
</form>
</body>
</html>
