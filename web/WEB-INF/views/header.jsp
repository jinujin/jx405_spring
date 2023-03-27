<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    boolean loginCheck = session.getAttribute("logIn") == null;
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <style>
        @media screen and (max-width: 1000px) {
            header {
                position: unset !important;

            }
            .form{
                margin-bottom: 0!important;
            }
            .container {
                margin-top: 20px;
            }
            .gap{
                margin-right: 12px;
            }
        }
        @media screen and (max-width: 450px) {
            .form{
                margin-bottom: 10px!important;
            }
        }

        .container {
            margin-top: 90px;
        }

        header {
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
            z-index: 1030;
        }

        .space {
            margin-top: 100px;
        }

        .nav {
            --bs-nav-link-color: white !important;
        }

        .home {
            color: #fbc531 !important;
        }

        .home:hover {
            color: whitesmoke !important;
            font-weight: bolder;
        }

        .notHome:hover {
            color: #fbc531 !important;
            font-weight: bolder;
        }

        .dropdown-item:hover {
            font-weight: bolder;
        }

        .gap{
            margin-left: 15px;
        }
        .searchbox{
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }
        #topBtn {
            position: fixed; /* 포지션 고정 */
            right: 2%; /* 오른쪽에서 2% - %도 할수 있음*/
            bottom: 5px; /* 밑에서 5px */
            z-index: 9999; /* 포지션을 먼저 지정후 z-좌표(레이어) : 9999입니다. */
            text-decoration: none;
        }
    </style>
</head>
<body>

<header class="p-3 text-bg-dark">
    <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="#" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
            <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap">
                <use xlink:href="#"></use>
            </svg>
        </a>

        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
            <li><a href="/" class="nav-link px-2 text-secondary home">Home</a></li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle notHome" data-bs-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">상품</a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="/products/goodsList">전체</a>
                    <a class="dropdown-item" href="/products/goodsListByKind/1">의류</a>
                    <a class="dropdown-item" href="/products/goodsListByKind/2">식품</a>
                    <a class="dropdown-item" href="/products/goodsListByKind/3">생활용품</a>
                </div>
            </li>
            <li><a href="/brand/brandList" class="nav-link px-2 text-white notHome">브랜드</a></li>
            <li><a href="/board/showAll" class="nav-link px-2 text-white notHome">FAQs</a></li>
            <c:if test="<%=!loginCheck%>">
                <li><a href="/user/login" class="nav-link px-2 text-white notHome">장바구니</a></li>
            </c:if>
        </ul>
            <form class="col-lg-auto mb-lg-0 me-lg-3 form" action="/products/search" method="get" role="search">
                <div class="searchbox"><input type="search" class="form-control form-control-dark" placeholder="상품검색"
                                        name="keyword" aria-label="Search">
                    <button type="submit" class="btn btn-warning gap">🔍</button>
                </div>
            </form>
        <div class="text-end">
            <c:choose>
                <c:when test="<%=loginCheck%>">
                    <button type="button" class="btn btn-outline-light me-2"
                            onclick="location.href='/user/login'">로그인
                    </button>
                    <button type="button" class="btn btn-warning"
                            onclick="location.href='/user/choice_register'">회원가입
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-outline-light me-2"
                            onclick="location.href='/user/login'">내정보
                    </button>
                    <button type="button" class="btn btn-warning" onclick="location.href='/user/logout'">로그아웃
                    </button>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</header>
<a id="topBtn" href="#">🔺TOP</a>
</body>
</html>

