<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <title>로그인 - CC</title>
    <style>
        body{
            height: 70%!important;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
    <div class="row h-100 align-items-center justify-content-center space">
        <div class="col-8">
            <form method="post" action="/user/auth">
                <label for="input-username">ID</label>
                <input type="text" name="username" class="form-control mb-2" id="input-username">
                <label for="input-password">PASSWORD</label>
                <input type="password" name="password" class="form-control mb-2" id="input-password">
                자동로그인 <input type="checkbox" name="remember-me">
                <button type="submit" class="btn btn-outline-primary">로그인</button>
                <button type="button" class="btn btn-secondary"
                        onclick="location.href='/user/choice_register'">회원가입
                </button>
            </form>
            <h3 class="text-danger">${message}</h3>
        </div>
    </div>
</div>

</body>
</html>
