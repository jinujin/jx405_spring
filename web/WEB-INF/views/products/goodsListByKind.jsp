<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">

  <title>상품 - CC</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

    .soldOut{
      text-decoration: line-through;
      background-color: #a5b1c2 !important;
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

    .brandName {
      font-size: 10px;
    }

    span {
      color: #999999;
    }

    .itemName {
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
  <div class="wrapper">
    <div class="row h-100 align-items-center">
      <main>
        <c:choose>
        <c:when test="${list.size()==0}">
          <div class="row">
            <div class="col-6">
              <h3>❌ 해당 상품이 존재하지 않습니다. ❌</h3>
            </div>
          </div>
        </c:when>

        <c:otherwise>
        <div class="a">
          <c:forEach var="item" items="${list}">
          <c:choose>
          <c:when test="${item.amount == 0}">
          <div class="goods_list shadow soldOut">
            </c:when>
            <c:otherwise>
            <div class="goods_list shadow">
              </c:otherwise>
              </c:choose>
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
                <a href="/brand/brandOne/${item.brandId}">${item.brandName}</a> /
                <span>남은 갯수 : ${item.amount}개</span>
                <c:choose>
                  <c:when test="${item.amount <10 and item.amount != 0}">
                    <span class="text-danger">!품절 임박!</span>
                  </c:when>
                  <c:when test="${item.amount == 0}">
                    <span class="text-danger">❗품절❗</span>
                  </c:when>
                </c:choose>

              </div>
            </div>
            </c:forEach>
          </div>
          </c:otherwise>
          </c:choose>
      </main>
    </div>
  </div>
</div>

</body>

</html>
