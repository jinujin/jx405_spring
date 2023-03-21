<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
  <div class="row h-100 align-items-center justify-content-center space">
      <div class="col-8">
        <form method="post" action="/user/auth">
          <label for="input-username">ID</label>
          <input type="text" name="username" class="form-control mb-2" id="input-username">
          <label for="input-password">PASSWORD</label>
          <input type="password" name="password" class="form-control mb-2" id="input-password">
          <button type="submit" class="btn btn-outline-info">로그인</button>
        </form>
        <h3 class="text-danger">${message}</h3>
      </div>
  </div>
</div>
<%@include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>
