<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-15
  Time: 오후 7:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>내 정보</title>
</head>
<body>
<div>
    <div>
        <button onclick="location.href='/board/showAll/1'">게시판으로</button>
        <button onclick="location.href='/user/delete'">회원 탈퇴</button>
        <button onclick="location.href='/user/update'">회원 정보 수정</button>
    </div>
    <div>
        <table>
            <tr>
                <td>회원 번호</td>
                <td>${login.id}</td>
            </tr>
            <tr>
                <td>아이디</td>
                <td>${login.username}</td>
            </tr>
            <tr>
                <td>닉네임</td>
                <td>${login.nickname}</td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
