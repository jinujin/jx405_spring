<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">

    <title>내 정보 - CC</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

        .hello {
            font-family: 'Gowun Dodum', sans-serif;
            width: 100%;
            height: 85px;
        }

        .all {
            font-family: 'Gowun Dodum', sans-serif;
            height: 100%;
            width: 100%;
        }

    </style>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

        h2, h3, h4 {
            font-family: 'Gowun Dodum', sans-serif;
        }

        h4 {
            margin-right: 8px;
        }

        .input-group-text > button {
            width: 100%;
            height: 100%;
        }

        html, body {
            height: 100%;
        }

        .brandList {
            display: flex;

        }

        .order {
            background-color: rgb(220, 220, 220);
            font-weight: bolder;
        }

        .img-control {
            object-fit: contain;
            width: 300px;
            height: 300px;
        }

        .goods-img {
            width: 100%;
            height: 80%;
            object-fit: contain;
            margin-bottom: 2px;
        }

        .goods_list {
            border-radius: 10px;
            background-color: #F7F7F7;
            width: 15rem;
            height: 20rem;
            padding: 10px;
        }

        .goods_text {
            width: 100%;
            height: 20px;
            line-height: 20px;
            padding-bottom: 1px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 14px;
            font-family: 'Gowun Dodum', sans-serif;
        }

        .a {
            display: grid;
            justify-items: center;
            align-items: center;
            justify-content: center;
            grid-template-columns: repeat(auto-fit, minmax(200px, 300px));
            grid-template-rows: repeat(auto-fit, minmax(300px, 400px));
            /*grid-auto-rows: minmax(300px, 3fr);*/
            gap: 1em;
            margin-bottom: 70px;
        }

    </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
    <main>
        <div class="hello">
            <div style="width: 100%; display: flex; justify-content: space-between;">
                <h3 class="mb-3"><span style="color: navy; font-weight: bolder">${userDTO.nickname} 고객님</span>, 반갑습니다 !
                </h3>
                <div>
                    <c:if test="${logIn.role.equals('ROLE_SELLER')}">
                        <button type="button" class="btn btn-outline-secondary btn-lg" style="margin-right: 10px" onclick="location.href='/products/add'">상품 등록</button>
                    </c:if>
                    <button type="button" class="btn btn-secondary btn-lg"
                            onclick="location.href='/user/mypage/<%=logIn.getId()%>'">회원 정보 수정
                    </button>
                </div>
            </div>
            <div class="hello-left">
                <c:if test="${userDTO.role.equals('ROLE_ADMIN')}">
                    <h4>✔ 관리자 정보 페이지</h4>
                </c:if>
                <c:if test="${userDTO.role.equals('ROLE_SELLER')}">
                    <h4>✔ 판매 상품 목록</h4>
                </c:if>
            </div>
        </div>
        <div class="all">
            <c:if test="${userDTO.role.equals('ROLE_SELLER')}">
                <c:choose>
                    <c:when test="${list eq null}">
                        <div class="row">
                            <div class="col-6">
                                <h3>판매 상품이 존재하지 않습니다.</h3>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="a">
                            <c:forEach var="item" items="${list}">
                                <div class="goods_list shadow">
                                    <a href="/products/goodsOne/${item.goodsId}" class="film_one justify-content-center">
                                        <img class="goods-img" src="/resources/images/${item.image}">
                                    </a>
                                    <div class="goods_text itemName">
                                            ${item.goodsName}
                                    </div>
                                    <div class="goods_text">
                                            ${item.price}원
                                    </div>
                                    <div class="goods_text brandName">
                                        <span>남은 갯수 : ${item.amount}개</span>
                                        <c:if test="${item.amount <10}">
                                            <span class="text-danger">!품절 임박!</span>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${not userDTO.role.equals('ROLE_ADMIN')}">
                <h4>✔ 구매 내역</h4>
                <c:choose>
                    <c:when test="${buyList.isEmpty()}">
                        <div class="row">
                            <div class="col-6">
                                <h3>구매 내역이 없습니다.</h3>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="item" items="${buyList}">
                            <div class="col">
                                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                                    <div class="col-auto">
                                        <img class="img-control" src="/resources/images/${item.image}">
                                    </div>
                                    <div class="col p-4 d-flex flex-column position-static">
                                        <div class="brandList align-items-center text-center">
                                            <h3 class="listOne order">
                                                <fmt:formatDate value="${item.entryDate}"
                                                                pattern="yyyy. MM. dd"/> 주문
                                            </h3>
                                        </div>
                                        <div class="brandList align-items-center text-center">
                                            <h4 class="listOne">
                                                    ${item.goodsName}
                                            </h4>
                                        </div>
                                        <div class="brandList align-items-center text-center">
                                            <h5 class="listOne">
                                                구매 수량 : ${item.cnt}
                                            </h5>
                                        </div>
                                        <div class="brandList align-items-center text-center">
                                            <h5 class="listOne">상품 가격 : ${item.price} 원
                                            </h5>
                                        </div>
                                        <div class="brandList align-items-center text-center">
                                            <h5 class="listOne">배송 주소 : ${item.deliveryAddr}
                                            </h5>
                                        </div>
                                        <br>
                                        <br>
                                        <div class="brandList align-items-center text-center">
                                            <h5 class="listOne">총 구매 가격 : ${item.totalPrice} 원
                                            </h5>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${userDTO.role.equals('ROLE_ADMIN')}">
                <h4>👉 회원 정보</h4>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>회원번호</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>신분</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${userList}" var="u">
                        <tr>
                            <td>${u.id}</td>
                            <td>${u.nickname}</td>
                            <td>${u.email}</td>
                            <td>${u.role}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </main>
</div>
</body>
</html>
