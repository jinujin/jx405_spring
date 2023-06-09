<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <title>회원정보수정</title>
</head>
<body>
<form method="post" action="/user/update">
    아이디 : <input type="text" name="username" value="${username}" readonly/><br/>
    비밀번호 : <input type="password" name="password" value="${password}"/><br/>
    닉네임 : <input type="text" name="nickname" value="${nickname}"/><br/>
    <button type="submit">수정하기</button>
    ${message}
</form>

</body>
</html>
