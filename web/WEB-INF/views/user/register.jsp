<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <title>회원 가입</title>
</head>
<body>
<div class="container">
    <div class="row h-100 align-items-center">
        <div class="row justify-content-center">
            <div class="col-8 justify-content-center">
                <div class="col-12">
                    <c:if test="${not empty message}">
                        <div class="alert alert-dismissible alert-danger">
                            <h3 class="text-danger">${message}</h3>
                        </div>
                    </c:if>
                </div>
                <form method="post" action="/user/register">
                    <div class="row">
                        <div class="col">
                            <label for="input-username">ID</label>
                            <input type="text" name="username" class="form-control mb-2" id="input-username"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-password">PASSWORD</label>
                            <input type="password" name="password" class="form-control mb-2" id="input-password"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-nickname">NICKNAME</label>
                            <input type="text" name="nickname" class="form-control mb-2" id="input-nickname"/>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success">회원가입</button>
                    <button type="button" class="btn btn-outline-info" onclick="location.href='/'">로그인</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
