<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <title>Title</title>
</head>
<body>
<script>
  // alert("!에러발생!");
  // location.href = "/index.jsp";
  Swal.fire({title:"! 에러 발생 !", text:"로그인을 확인해주세요.",icon:'error'})
  history.go(-1); // 뒤로가기
</script>
</body>
</html>
