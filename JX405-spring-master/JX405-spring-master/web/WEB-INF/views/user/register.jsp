<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
<div>
    <div>
        ${message}
    </div>
    <form action="/user/register" method="post">
        <table>
            <tr>
                <td><label for="username">아이디</label></td>
                <td><input type="text" id="username" name="username" placeholder="아이디"></td>
            </tr>
            <tr>
                <td><label for="password">비밀번호</label></td>
                <td><input type="password" id="password" name="password" placeholder="비밀번호"></td>
            </tr>
            <tr>
                <td><label for="nickname">닉네임</label></td>
                <td><input type="text" id="nickname" name="nickname" placeholder="닉네임"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button>회원가입</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
