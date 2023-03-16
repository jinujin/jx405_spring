<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <a href="/user/update/${id}">회원수정</a>
    <a href="/user/delete/">회원탈퇴</a>
    <br/>
    <br/>

<c:forEach items="${list}" var="item">
    <a href="/board/showOne/${item.id}"> ${item.title} <fmt:formatDate value="${item.entryDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/></a> <br/>
</c:forEach>
</body>
</html>
