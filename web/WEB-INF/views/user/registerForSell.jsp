<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {

                    var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }
                    if (fullRoadAddr !== '') {
                        fullRoadAddr += extraRoadAddr;
                    }

                    document.getElementById('zip_code').value = data.zonecode;
                    document.getElementById('roadAddress').value = fullRoadAddr;

                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시
                    if (data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                    } else {
                        document.getElementById('guide').innerHTML = '';
                    }
                }
            }).open();
        }
    </script>
    <title>회원 가입 - CC</title>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
    <div class="row h-100 align-items-center">
        <div class="row justify-content-center space">
            <div class="col-8 justify-content-center">
                <div class="col-12">
                    <c:if test="${not empty message}">
                        <div class="alert alert-dismissible alert-danger">
                            <h3 class="text-danger">${message}</h3>
                        </div>
                    </c:if>
                </div>
                <form method="post" action="/user/register">
                    <h2>✔ 개인 / 일반 판매 회원가입</h2>
                    <input type="hidden" name="role" value="ROLE_SELLER">
                    <div class="row">
                        <div class="col">
                            <label for="input-username">ID</label>
                            <input type="text" name="username" class="form-control mb-2" id="input-username"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-password">PASSWORD</label>
                            <input type="password" name="password" class="form-control mb-2" id="input-password"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-name">NAME</label>
                            <input type="text" name="nickname" maxlength="10" class="form-control mb-2" id="input-name"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="roadAddress">COMPANY ADDRESS</label><br>
                            <div class="mb-2">
                                <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
                                <input type="text" id="zip_code" name="postcode" placeholder="우편번호">
                            </div>
                            <input type="text" id="roadAddress" class="form-control mb-2" name="address"
                                   placeholder="도로명주소">
                            <input type="text" id="detailAddr" class="form-control mb-2" name="address" placeholder="상세주소">

                            <span id="guide" style="color:#999"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-phone">PHONE</label>
                            <input type="text" name="phone" class="form-control mb-2" id="input-phone"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label for="input-email">Email</label>
                            <input type="text" name="email" class="form-control mb-2" id="input-email"/>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success">회원가입</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
