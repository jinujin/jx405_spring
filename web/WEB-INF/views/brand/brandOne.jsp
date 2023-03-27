<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">

    <title> 브랜드 - CC
    </title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

        .container{
            min-height: 100%;
        }

        h2, h3 {
            font-family: 'Gowun Dodum', sans-serif;
        }

        .input-group-text > button {
            width: 100%;
            height: 100%;
        }

        html, body {
            height: 100%;
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

        img {
            width: 100%;
            height: 80%;
            object-fit: contain;
            margin-bottom: 2px;
        }
        .brandName{
            font-size: 10px;
        }
        span{
            color: #999999;
        }
        .itemName{
            font-weight: bolder;
            font-size: 18px;
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
        <div class="col">
            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                <div class="col p-4 d-flex flex-column position-static">
                    <div class="cinemaList align-items-center text-center">
                        <h4 class="mb-2">매장 이름
                        </h4>
                        <div class="cinemaOne mb-3">
                            ${brandDTO.name}
                        </div>
                    </div>
                    <div class="cinemaList align-items-center text-center">
                        <h4 class="mb-2">매장 번호
                        </h4>
                        <div class="cinemaOne mb-3">
                            ${brandDTO.number}
                        </div>
                    </div>
                    <div class="cinemaList align-items-center text-center">
                        <h4 class="mb-2">매장 링크
                        </h4>
                        <div class="cinemaOne mb-3">
                            <c:choose>
                                <c:when test="${brandDTO.url eq null}">
                                    <div class="cinemaOne mb-3">
                                            연관된 사이트가 없습니다.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a href="http://${brandDTO.url}">사이트 이동</a>

                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <h3>🚩판매중인 상품</h3>
            <c:choose>
                <c:when test="${list eq null}">
                    <div class="row">
                        <div class="col-6">
                            <h3>아직 등록된 상품이 존재하지 않습니다.</h3>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="a">
                        <c:forEach var="item" items="${list}">
                            <div class="goods_list shadow">
                                <a href="/products/goodsOne/${item.id}" class="film_one justify-content-center">
                                    <img src="/resources/images/${item.image}">
                                </a>
                                <div class="goods_text itemName">
                                        ${item.name}
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
        </div>
    </main>
</div>
</body>
</html>
