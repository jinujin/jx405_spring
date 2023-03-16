<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
글번호 : ${result.id} <br/>
제목 : ${result.title}<br/>
작성자 : ${result.writerId}<br/>
작성일 : <fmt:formatDate value="${result.entryDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/> <br/>
수정일 : <fmt:formatDate value="${result.modifyDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/><br/>
내용 : ${result.content}<br/>
<c:if test="${logInId eq result.writerId}">
    <a href="/board/update/${result.id}">수정하기</a>
    <a href="/board/delete/${result.id}">삭제하기</a>
</c:if>
</body>
</html>
