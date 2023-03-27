<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">

  <title>상품 - CC
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

    .average {
      margin: 20px 0px;
      font-size: 25px;
      font-weight: bold;
    }
  </style>
</head>
<body>

<%@include file="/WEB-INF/views/header.jsp"%>
<div class="container">
  <main>
    <div class="col">
      <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
        <div class="col-auto d-none d-lg-block">
          <svg class="bd-placeholder-img" width="330" height="470" xmlns="http://www.w3.org/2000/svg"
               role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice"
               focusable="false">
            <image href="/resources/images/${goodsDTO.image}"/>
          </svg>
        </div>
        <div class="col p-4 d-flex flex-column position-static">
          <h1 class="mb-3">${goodsDTO.name}
          </h1>
          <h2 class="mb-3">${goodsDTO.price} 원</h2>
          <h4 class="mb-3 text-muted"> ${goodsDTO.brandName} | 남은 갯수: ${goodsDTO.amount} 개
          </h4>
          <c:if test="${goodsDTO.amount <10}">
            <h6 class="text-danger">⌛!품절 임박!</h6>
          </c:if>
        </div>
      </div>
    </div>
  </main>

  <div class="movingBar">
    <a class="moveList" href="#goodsDetail">상품정보</a>
    <a class="moveList" href="#goodsReview">상품평</a>
    <a class="moveList" href="#goodsQnA">상품문의</a>
    <a class="moveList" href="#sellerInfo">판매자정보</a>
  </div>
  <a name="goodsDetail">상품정보</a>
  <p class="detail" style="height: 1000px">상세정보
  </p>
  <a name="goodsReview">리뷰</a>
  <div> 여기서부터 리뷰입니다.</div>
<%--  구매자만 리뷰 작성할 수 있게 조치해야함 => 구매내역에서 쓸 수 있게 하자--%>
<%--  <a href="#goodsReview"></a>--%>
<%--  <div class="col">--%>
<%--    <c:choose>--%>
<%--      <c:when test="${list.isEmpty()}">--%>
<%--        <div class="row">--%>
<%--          <div class="col">--%>
<%--            <h3 class="mt-4">아직 등록된 리뷰가 존재하지 않습니다.</h3>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </c:when>--%>

<%--      <c:otherwise>--%>
<%--        <%--%>
<%--          // 평점--%>
<%--//          double sum = 0.0;--%>
<%--          double avg = 0.0;--%>
<%--//          for (GradeDTO g : list) {--%>
<%--//            sum += g.getScore();--%>
<%--//          }--%>
<%--//          avg = sum / list.size();--%>
<%--//          avg = Math.round(avg * 10) / 10.0;--%>
<%--        %>--%>
<%--        <div class="average">--%>
<%--          <span>평점 : </span><%=avg%> 점--%>
<%--        </div>--%>
<%--        <c:forEach var="list" items="${list}">--%>
<%--          <div class="col">--%>
<%--            <div class="border-bottom mb-3 for-update">--%>
<%--              <div class="col-md-2 mb-2">--%>
<%--                점수 : ${list.score}--%>
<%--              </div>--%>
<%--              <div class="col-md-10 mb-2">--%>
<%--                  ${list.content}--%>
<%--              </div>--%>
<%--              <div style="color:darkgray">--%>
<%--                  ${list.username} | <fmt:formatDate value="${list.entry_date}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--&lt;%&ndash;            리뷰 수정도 내정보에서 하자&ndash;%&gt;--%>
<%--          </div>--%>
<%--        </c:forEach>--%>
<%--      </c:otherwise>--%>
<%--    </c:choose>--%>
<%--&lt;%&ndash;    상품 문의&ndash;%&gt;--%>
<%--    <a href="#goodsQnA"></a>--%>
  </div>
</div>

</body>
</html>
