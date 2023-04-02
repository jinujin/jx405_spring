<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <title>상품 등록 - CC
    </title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

        image {
            object-fit: contain;
            height: 100%;
            width: 100%;
        }

        * {
            font-family: 'Gowun Dodum', sans-serif;
        }

        .input-group-text > button {
            width: 100%;
            height: 100%;
        }

        html, body {
            height: 100%;
        }

        .input-group-text > button {
            width: 100%;
            height: 100%;
        }

        .register {
            margin-bottom: 15px;
            color: #ff8888;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<c:set value="<%=logIn%>" var="logIn"/>
<div class="container">
    <main>
        <form action="/products/add" method="post" enctype="multipart/form-data">
            <div class="text-center">
                <h2>< 상품 등록 ></h2>
            </div>
            <div class="session1 p-3 mb-2">
                <div>
                    <ul class="list-group list-group-flush">
                        <input type="hidden" value="${logIn.id}" name="userId">

                        <h4>상품 이름</h4>
                        <li class="list-group">
                            <input type="text" class="form-control register" id="name" name="name"
                                   placeholder="상품 이름" aria-describedby="goodsName" required>
                        </li>
                        <h4>상품 가격</h4>
                        <li class="list-group">
                            <input type="number" class="form-control register" id="price" name="price"
                                   placeholder="상품 가격" required>
                        </li>
                        <h4>상품 수량</h4>
                        <li class="list-group">
                            <input type="number" class="form-control register" id="amount" name="amount"
                                   placeholder="상품 수량" required>
                        </li>
                        <h4>상품사진</h4>
                        <li class="list-group">
                            <input type="file" class="form-control mb-2" name="image" id="image"/>
                        </li>

                        <h4>상품 카테고리</h4>
                        <select class="form-select" id="category" name="categoryId" required>
                            <option>1 의류</option>
                            <option>2 식품</option>
                            <option>3 생활용품</option>
                        </select>
                        <div class="register">
                            ※ 카테고리를 선택해주세요.
                        </div>
                        <h4>상품 정보관련 사진</h4>
                        <li class="list-group">
                            <input type="file" class="form-control register" id="detailImg" name="detailImg">
                        </li>
                        <h4>브랜드 선택</h4>
                        <select class="form-select" id="brand" name="brandId" required>
                            <c:forEach var="item" items="${brandList}">
                                <option>${item.id} ${item.name}</option>
                            </c:forEach>
                        </select>
                        <div class="register">
                            ※ 브랜드를 선택해주세요.
                        </div>
                        <h4>상품 정보</h4>
                        <li class="list-group">
                            <div class="input-group register">
                                <span class="input-group-text">작 성 란</span>
                                <textarea class="form-control" aria-label="With textarea" style="height: 110px;"
                                          id="detail" name="detail"></textarea>
                            </div>
                        </li>
                        <button class="btn btn-outline-primary" type="submit">등 록</button>
                    </ul>
                </div>
            </div>
        </form>
    </main>
</div>
</body>
</html>