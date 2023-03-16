<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${result.title}</title>
</head>
<body>
<div>
    <button onclick="location.href='/board/showAll/1'">목록으로</button>
</div>
<div>
    글 번호: ${result.id} <br>
    제목: ${result.title} <br>
    작성자: ${nickname} | ${result.entryDate} | ${result.modifyDate} <br>
    내용: ${result.content} <br>
    <c:if test="${loginId == result.writerId}">
        <div>
            <a href="/board/update/${result.id}">수정</a>
            <a href="/board/delete/${result.id}">삭제</a>
        </div>
    </c:if>
</div>
<div>
    <form action="/reply/register/${result.id}" method="post">
        <input type="text" name="content"/>
        <button>등록</button>
    </form>
    <div>
        <c:if test="${empty replyList}">
            등록된 댓글 없음
        </c:if>
        <c:forEach items="${replyList}" var="reply">
            <div>${reply.id} (${reply.writerId}): ${reply.content}/${reply.entryDate}</div>
        </c:forEach>
    </div>
</div>
</body>
</html>
