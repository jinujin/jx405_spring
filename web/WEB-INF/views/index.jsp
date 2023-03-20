<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <title>인덱스</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <div class="row h-100 align-items-center">
        <div class="col-10">
            <div class="col-10 align-content-center">
                <form method="post" action="/user/auth">
                    <label for="input-username">ID</label>
                    <input type="text" name="username" class="form-control mb-2" id="input-username">
                    <label for="input-password">PASSWORD</label>
                    <input type="password" name="password" class="form-control mb-2" id="input-password">
                    <button type="submit" class="btn btn-outline-info">로그인</button>
                    <a class="btn btn-outline-success" href="/user/register">회원가입</a>
                </form>
                <h3 class="text-danger">${message}</h3>
            </div>
        </div>
    </div>
</div>

</body>
</html>
