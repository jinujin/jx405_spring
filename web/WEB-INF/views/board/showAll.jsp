<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <title>게시판</title>
</head>
<body>
<div class="container">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="/board/showAll/1">Navbar</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01"
                    aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor01">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="/board/showAll/1">Home
                            <span class="visually-hidden">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                           aria-haspopup="true" aria-expanded="false">Dropdown</a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <a class="dropdown-item" href="#">Something else here</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Separated link</a>
                        </div>
                    </li>
                </ul>
                <form class="d-flex" action="/board/search/1?keyword=${keyword}" method="get">
                    <input class="form-control me-sm-2" type="search" placeholder="검색" name="keyword">
                    <button class="btn btn-secondary my-2 my-sm-0 col-4" type="submit">검색</button>
                </form>
            </div>
        </div>
    </nav>
    <div class="row h-100">
        <div class="col-10">
            <div class="row">
                <div class="col">
                    <div class="mb-5">
                        <a class="btn btn-success" href="/user/update/${id}">회원수정</a>
                        <a class="btn btn-danger" href="/user/delete/">회원탈퇴</a>
                    </div>
                    <table class="table table-hover table-striped">
                        <thead>
                        <tr>
                            <th>NUMBER</th>
                            <th>TITLE</th>
                            <th>WRITER</th>
                            <th>ENTRY DATE</th>
                            <th>MODIFY DATE</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="item">
                            <tr onclick="location.href='/board/showOne/${item.id}'">
                                <td>${item.id}</td>
                                <td>${item.title}</td>
                                <td>${item.writerNickname}</td>
                                <td><fmt:formatDate value="${item.entryDate}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/></td>
                                <td><fmt:formatDate value="${item.modifyDate}"
                                                    pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/></td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="5">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item">
                                        <a class="page-link" href="${pagingAddr}/1">&laquo</a>
                                    </li>
                                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <c:choose>
                                            <c:when test="${i eq current}">
                                                <li class="page-item active disabled">
                                                    <a class="page-link" href="${pagingAddr}/${i}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="${pagingAddr}/${i}">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item">
                                        <a class="page-link" href="${pagingAddr}/${lastPage}">&raquo</a>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <a class="btn btn-secondary" href="/board/write">글쓰기</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
