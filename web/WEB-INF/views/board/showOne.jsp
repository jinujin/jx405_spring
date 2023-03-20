<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
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
    <a class="btn btn-success" href="/board/update/${result.id}">수정하기</a>
    <a class="btn btn-danger" href="/board/delete/${result.id}">삭제하기</a>
    <a class="btn btn-secondary" onclick="location.href='/board/showAll/1'">글 목록으로</a>
</c:if>
</body>
</html>
