<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-15
  Time: 오후 7:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 등록하기</title>
</head>
<body>
<div>
    <div>
        ${message}
    </div>
    <div>
        <form action="/board/register" method="post">
            <table>
                <tr>
                    <td><label for="title">제목</label></td>
                    <td><input type="text" id="title" name="title" placeholder="제목"></td>
                </tr>
                <tr>
                    <td><label for="content">내용</label></td>
                    <td><textarea id="content" name="content" placeholder="내용 작성하기" rows="10"></textarea></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button>작성</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
