<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-15
  Time: 오후 7:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 정보 수정</title>
</head>
<body>
<script>
    let checkForm = () => {
        if(document.getElementById("password").value == '') {
            alert("비밀번호 입력은 필수입니다.");
            return;
        }
        document.getElementById("updateForm").submit();
    }
</script>
<div>
    <form action="/user/update" method="post" id="updateForm">
        <table>
            <tr>
                <td><label for="username">아이디</label></td>
                <td><input type="text" id="username" name="username" placeholder="아이디" value="${login.username}" readonly></td>
            </tr>
            <tr>
                <td><label for="password">비밀번호</label></td>
                <td><input type="password" id="password" name="password" placeholder="비밀번호"></td>
            </tr>
            <tr>
                <td><label for="nickname">닉네임</label></td>
                <td><input type="text" id="nickname" name="nickname" placeholder="닉네임" value="${login.nickname}"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="button" onclick="checkForm()">수정</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
