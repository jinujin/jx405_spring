<%@ page import="com.bit.spring.model.UserDTO" %>
<%@ page import="org.springframework.security.core.userdetails.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">

  <title>문의 내역 - CC</title>
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>

  <style>
    @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

    .accordion-body {
      background-color: rgb(247, 247, 247);
    }

    .group {
      display: flex;
      justify-content: space-around;
      align-items: center;
      height: 50px;
    }

    .group-list {
      text-decoration: none;
      font-family: 'Gowun Dodum', sans-serif;
      font-size: 20px;
      color: #111111;
    }

    .group-list:hover {
      font-weight: bolder;
      color: darkgreen;
    }
  </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
  <div class="row h-100">
    <div class="col">
      <form class="col-lg-auto mb-lg-2 me-lg-3 form" action="/board/search/3" method="get" role="search">
        <div class="searchbox"><input type="search" class="form-control form-control-dark" placeholder="게시판 검색"
                                      name="keyword" aria-label="Search">
          <button type="submit" class="btn btn-success gap">🔍</button>
        </div>
      </form>
      <div class="mb-2 group">
        <a class="group-list" href="/board/showAll">전체</a>
        <a class="group-list" href="/board/showAllByKind/1">공지사항</a>
        <a class="group-list" href="/board/showAllByKind/2">이벤트</a>
        <c:set var="logIn" value="<%=logIn%>"/>
        <c:if test="${logIn ne null}">
          <a class="group-list" href="/board/showAllQnA">문의 내역</a>
        </c:if>
      </div>

      <c:choose>
        <c:when test="${list.size()==0}">
          <div class="row d-flex justify-content-center">
            <div class="col-6">
              <h3>❌ 해당 게시글이 존재하지 않습니다. ❌</h3>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <div class="accordion mb-5">
            <c:forEach items="${list}" var="item" varStatus="i">
              <div class="accordion-item mb-3">
                <h2 class="accordion-header" id="headingOne">
                  <button class="accordion-button collapsed" type="button"
                          data-bs-toggle="collapse" data-bs-target="#collapse${i.count}"
                          aria-expanded="false" aria-controls="collapseOne">
                      ${item.title}
                    <br/><fmt:formatDate value="${item.entryDate}"
                                         pattern="yyyy.MM.dd HH:mm"/>
                  </button>
                </h2>
                <div id="collapse${i.count}" class="accordion-collapse collapse"
                     aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
                  <div class="accordion-body">
                      ${item.content}
                  </div>
                </div>
              </div>
            </c:forEach>
            <c:set var="logIn" value="<%=logIn%>"/>
            <c:if test="${logIn.role.equals('ROLE_ADMIN')}">
              <a class="btn btn-secondary" href="/board/write">글쓰기</a>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
</body>
</html>
