<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <title>브랜드 - CC
    </title>

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
        .info{
            width: 100%;
            height: 100%;
        }

    </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
    <main>
        <c:choose>
            <c:when test="${list.isEmpty()}">
                <div class="row">
                    <div class="col-6">
                        <h3>아직 등록된 매장이 존재하지 않습니다.</h3>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${list}">
                    <div class="col">
                        <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                            <div class="col p-4 d-flex flex-column position-static">
                                <div class="brandList align-items-center text-center">
                                    <h4 class="mb-0">매장 이름 :
                                    </h4>
                                    <div class="cinemaOne">
                                            ${item.name}
                                    </div>
                                </div>
                                <div class="brandList align-items-center text-center">
                                    <h4 class="mb-0"> 매장 번호 :
                                    </h4>
                                    <div class="cinemaOne">
                                            ${item.number}
                                    </div>
                                </div>
                                <div class="brandList align-items-center text-center">
                                    <h4 class="mb-0">판매자 명 :
                                    </h4>
                                    <div class="cinemaOne">
                                            ${item.sellerName}
                                    </div>
                                </div>
                            </div>
                            <div class="col-auto">
                                <button class="btn btn-outline-secondary info" type="submit"
                                        onclick="location.href='/brand/brandOne/${item.id}'">상세 정보
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </main>
</div>

</body>
</html>

