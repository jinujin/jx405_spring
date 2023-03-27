<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <title>회원가입 - CC</title>
    <style>
        .link {
            position: relative;
            display: block;
            padding: 25px 30px 23px;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        a {
            text-decoration: none !important;
        }

        a:-webkit-any-link {
            cursor: pointer;
        }

        .subject {
            display: block;
            font-size: 18px;
            line-height: 27px;
            color: #111;
            margin: 0 0 4px 0;
        }

        .text {
            display: block;
            font-size: 13px;
            line-height: 20px;
            color: #333;
        }

        .c_member_class .box {
            float: left;
            width: 392px;
            margin: 0 0 0 16px;
            -webkit-box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.28), 0 2px 6px 0 rgba(0, 0, 0, 0.06);
            box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.28), 0 2px 6px 0 rgba(0, 0, 0, 0.06);
            border-radius: 4px;
        }

        .box {
            font: 12px/1.3 "Helvetica Neue", "Apple SD Gothic Neo", "돋움", dotum, sans-serif;
            font-family: "Noto Sans KR", "Helvetica Neue", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", "돋움", dotum, sans-serif;
            color: #4d4d4d;
            text-decoration: none;
            position: relative;
            display: block;
            padding: 25px 30px 23px;
            box-sizing: border-box;
        }

        .point {
            color: #ff0038;
        }

        .link::after {
            width: 8px;
            height: 8px;
            border: 1px solid #111;
            border-width: 1px 1px 0 0;
            -webkit-transform-origin: center center;
            -ms-transform-origin: center center;
            transform-origin: center center;
            content: "";
            vertical-align: middle;
            -webkit-transform: rotate(45deg);
            -ms-transform: rotate(45deg);
            transform: rotate(45deg);
            position: absolute;
            right: 26px;
            top: 50%;
            margin: -5px 0 0 0;
            content: "";
        }

    </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
    <div class="row h-100 align-items-center">
        <div class="c_member_class">
            <c:if test="${not empty message}">
<%--                ${message}--%>
                <script>
                    alert(${message});
                </script>
            </c:if>
            <div class="box">
                <a href="/user/registerForSell" class="link" data-log-actionid-area="mbr_join"
                   data-log-actionid-label="tab"
                   data-log-body="{&quot;tab_name&quot;: &quot;판매 회원 가입&quot;}">
                    <strong class="subject"><span class="point">사업자/일반 판매</span> 회원가입</strong>
                    <span class="text">
                        브랜드 론칭 및 판매하시려면,<br>
                        사업자/일반 판매 회원으로 가입하여 판매하실 수 있습니다.
                    </span>
                </a>
            </div>
            <div class="box">
                <a href="/user/registerForBuy" class="link text-decoration-unset" data-log-actionid-area="mbr_join"
                   data-log-actionid-label="tab"
                   data-log-body="{&quot;tab_name&quot;: &quot;구매 회원 가입&quot;}">
                    <strong class="subject"><span class="point">개인/일반 구매</span> 회원가입</strong>
                    <span class="text">
                        CC 에서 상품을 구입하시려면,<br>
                        개인/일반 구매 회원으로 가입하여 구매하실 수 있습니다.
                    </span>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
