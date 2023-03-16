<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-15
  Time: 오후 5:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="/board/update">
    <input type="hidden" name="id" value="${result.id}"/>
    <table>
        <tr>
            <td>제목</td>
            <td><input type="text" name="title" value="${result.title}"/></td>
        </tr>
        <tr>
            <td>내용</td>
            <td><input type="text" name="content" value="${result.content}"/></td>
        </tr>
        <tr>
            <td colspan="2">
                <button type="submit">수정</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
