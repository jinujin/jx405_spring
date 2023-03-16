<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <title>Title</title>
</head>
<body>
<form action="/board/write" method="post">
    제목 : <input type="text" name="title" class="form-control"/>
    내용 : <input type="text" name="content" class="form-control"/>
    <br>
    <br>
    <button type="submit" class="btn btn-secondary">작성하기</button>
</form>
</body>
</html>
