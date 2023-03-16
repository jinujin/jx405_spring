<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 목록</title>
</head>
<body>
<div>
    <button onclick="location.href='/board/register'">글 작성</button>
    <button onclick="location.href='/user/myInfo'">내 정보</button>
</div>
<c:forEach items="${list}" var="item">
    <a href="/board/showOne/${item.id}">${item.id} ${item.title} ${item.entryDate}</a> <br>
</c:forEach>
</body>
</html>
