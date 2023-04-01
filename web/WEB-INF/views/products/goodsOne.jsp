<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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

        .movingBar {
            display: flex;
            justify-content: space-around;
            align-items: center;
            height: 50px;
        }

        .moveList {
            text-decoration: none;
            font-family: 'Gowun Dodum', sans-serif;
            font-size: 20px;
            color: #111111;
        }

        .moveList:hover {
            font-weight: bolder;
            color: darkgreen;
        }

        a > h4 {
            color: blue;
        }

        .detail-img {
            width: 100%;
            height: auto;
        }

        .cnt-btn {
            border: 0;
            background-color: transparent;
        }

        .countNumber {
            font-size: 20px;
            font-weight: bold;
            color: black;
            margin: 10px 0;
        }

        .countButtonWrap > button {
            color: white;
            font-weight: bold;
            border-radius: 5px;
            background-color: #747d8c;
            padding: 5px 10px;
        }

        .countBox {
            margin-bottom: 10px;
            width: 24%;
            background-color: rgb(250, 250, 250);
            border-radius: 10px;
            box-shadow: 1px 1px 15px rgb(240, 240, 240);
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }

        .total-pay {
            font-size: 25px;
            font-weight: bold;
            color: navy;
        }

        .showOne {
            background-color: #999999;
            text-decoration: line-through;
        }

    </style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<c:set value="<%=logIn%>" var="logIn"/>
<div class="container">
    <main>
        <c:if test="${logIn.role.equals('ROLE_SELLER') && goodsDTO.userId eq logIn.id}">
            <button type="button" class="btn btn-danger" id="deleteGoods"
                    onclick=deleteCheck()>상품 삭제
            </button>
        </c:if>
        <c:choose>
        <c:when test="${goodsDTO.amount == 0}">
        <div class="col showOne">
            </c:when>
            <c:otherwise>
            <div class="col">
                </c:otherwise>
                </c:choose>
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                    <div class="col-auto d-none d-lg-block" style="background-color: black">
                        <svg class="bd-placeholder-img" width="280" height="420" xmlns="http://www.w3.org/2000/svg"
                             role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice"
                             focusable="false">
                            <image href="/resources/images/${goodsDTO.image}"/>
                        </svg>
                    </div>
                    <div class="col p-4 d-flex flex-column position-static">
                        <h1 class="mb-3">${goodsDTO.name}
                        </h1>
                        <h2 class="mb-2">${goodsDTO.price} 원</h2>
                        <h4 class="mb-2 text-muted"> ${goodsDTO.brandName} | 남은 갯수: ${goodsDTO.amount} 개
                        </h4>
                        <c:if test="${goodsDTO.amount <10 and goodsDTO.amount !=0}">
                            <h6 class="text-danger">⌛!품절 임박!</h6>
                        </c:if>
                        <h4>구매 수량</h4>
                        <div class="countBox">
                            <p class="countNumber">1</p>
                            <div class="countButtonWrap">
                                <button class="minus cnt-btn">-</button>
                                <button class="reset cnt-btn">Reset</button>
                                <button class="plus cnt-btn">+</button>
                            </div>
                        </div>
                        <h4 class="mb-3">총 금액 :
                            <span class="total-pay">
                                ${goodsDTO.price}
                            </span>
                            원
                        </h4>

                        <c:choose>
                            <c:when test="${goodsDTO.amount == 0}">
                                <button type="button" class="btn btn-lg btn-primary disabled col-3">❗품💥절❗</button>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${logIn.role.equals('ROLE_ADMIN')}">
                                        <button type="button" class="btn btn-lg btn-primary disabled col-3">구매
                                            불가
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${logIn eq null}">
                                                <button type="button" class="btn btn-lg btn-primary col-3"
                                                        onclick="location.href='/user/login'">로그인으로
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <form id="target">
                                                    <button type="button" class="btn btn-lg btn-primary col-3"
                                                            onclick="payAddr()">구매하기
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <%-- 수량,가격 증감 --%>
            <script>
                let countNum = document.querySelector(".countNumber");
                let buttonWrap = document.querySelector(".countButtonWrap");
                let pay = document.querySelector(".total-pay");
                let payInt = Number(pay.innerText);
                let payString = pay.innerText;
                let cntInt = Number(countNum.innerText);

                buttonWrap.addEventListener("click", (e) => {
                    if (e.target.classList.contains("plus")) {
                        if (countNum.innerHTML < ${goodsDTO.amount}) {
                            // countNum.innerHTML++;
                            cntInt += 1;
                            payInt += ${goodsDTO.price};
                            pay.innerHTML = payInt;
                            countNum.innerHTML = cntInt;
                            //증가
                        }
                    }
                    if (e.target.classList.contains("minus")) {
                        if (countNum.innerHTML > 1) {
                            // countNum.innerHTML--;
                            cntInt -= 1;
                            payInt -= ${goodsDTO.price};
                            pay.innerHTML = payInt;
                            countNum.innerHTML = cntInt;
                            //감소
                        }
                    }
                    if (e.target.classList.contains("reset")) {
                        // countNum.innerHTML = 1;
                        payInt = ${goodsDTO.price};
                        cntInt = 1;
                        countNum.innerHTML = cntInt;
                        pay.innerHTML = payInt;
                        //리셋
                    }
                    if (countNum.innerHTML == ${goodsDTO.amount}) {
                        countNum.style.color = "#ff4d4d";
                    } else {
                        countNum.style.color = "#1e272e";
                    }
                })

                let payAddr = () => {
                    Swal.fire({
                        title: '정말 구매하시겠습니까?',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: "아니요",
                        confirmButtonText: "구매하기"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            let target = document.getElementById("target");
                            let address = "/buy/pay/${goodsDTO.id}&${logIn.id}&${logIn.address}&" + cntInt;
                            $('#target').attr('action', address);
                            $('#target').attr('method', "post");
                            Swal.fire({
                                title: '구매 성공',
                                icon: 'success'
                            }).then(() => {
                                target.submit()
                            })
                        }
                    })
                }
                let deleteCheck = () => {
                    let deleteGoods = document.getElementById("deleteGoods");
                    let addr = "location.href='/products/delete/${goodsDTO.id}&${goodsDTO.userId}'";
                    $('#deleteGoods').attr('onclick', addr);
                    Swal.fire({
                        title: '정말 삭제하시겠습니까?',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: "취소",
                        confirmButtonText: "삭제"
                    }).then((result)=>{
                        if(result.isConfirmed){
                            Swal.fire({
                                title: '삭제 성공',
                                icon : 'success'
                            }).then(()=>{
                                deleteGoods.click();
                            })
                        }
                    })
                }
            </script>
    </main>
    <div class="movingBar mb-2">
        <a class="moveList" href="#goodsDetail">상품정보</a>
        <a class="moveList" href="#goodsReview">상품평</a>
        <%--        <a class="moveList" href="#goodsQnA">상품문의</a>--%>
        <a class="moveList" href="#sellerInfo">판매자정보</a>
    </div>
    <div class="mt-4"><a name="goodsDetail"><h4>✔ 상품정보</h4></a></div>
    ${goodsDTO.detail}
    <c:if test="${goodsDTO.detailImg ne null}">
        <div class="detail-img">
            <img src="/resources/images/${goodsDTO.detailImg}" width="100%"/>
        </div>
    </c:if>
    <div class="mt-4"><a name="goodsReview"><h4>✔ 상품리뷰</h4></a></div>
    <%--  구매자만 리뷰 작성할 수 있게 조치해야함 => 구매내역에서 쓸 수 있게 하자--%>
    <div class="col">
        <c:choose>
            <c:when test="${list.isEmpty()}">
                <div class="row">
                    <div class="col">
                        <h3 class="mt-4">아직 등록된 리뷰가 존재하지 않습니다.</h3>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <%
                    // 평점
                    //          double sum = 0.0;
                    double avg = 0.0;
                    //          for (GradeDTO g : list) {
                    //            sum += g.getScore();
                    //          }
                    //          avg = sum / list.size();
                    //          avg = Math.round(avg * 10) / 10.0;
                %>
                <div class="average">
                    <span>평점 : </span><%=avg%> 점
                </div>
                <c:forEach var="list" items="${list}">
                    <div class="col">
                        <div class="border-bottom mb-3 for-update">
                            <div class="col-md-2 mb-2">
                                점수 : ${list.score}
                            </div>
                            <div class="col-md-10 mb-2">
                                    ${list.content}
                            </div>
                            <div style="color:darkgray">
                                    ${list.username} | <fmt:formatDate value="${list.entry_date}"
                                                                       pattern="yyyy년 MM월 dd일 HH시 mm분 ss초"/>
                            </div>
                        </div>
                            <%--            리뷰 수정도 내정보에서 하자--%>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <%--    판매자 정보--%>
        <div class="mt-4"><a name="sellerInfo"><h4>✔ 판매자 정보</h4></a></div>
        <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
            <div class="col p-4 d-flex flex-column position-static">
                <div class="cinemaList align-items-center text-center">
                    <h4 class="mb-2">매장 이름
                    </h4>
                    <div class="cinemaOne mb-3">
                        ${goodsDTO.brandName}
                    </div>
                </div>
                <div class="cinemaList align-items-center text-center">
                    <h4 class="mb-2">매장 번호
                    </h4>
                    <div class="cinemaOne mb-3">
                        ${goodsDTO.number}
                    </div>
                </div>
                <div class="cinemaList align-items-center text-center">
                    <h4 class="mb-2">매장 링크
                    </h4>
                    <div class="cinemaOne mb-3">
                        <c:choose>
                            <c:when test="${goodsDTO.url eq null}">
                                <div class="cinemaOne mb-1">
                                    연관된 사이트가 없습니다.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="http://${goodsDTO.url}">사이트 이동</a>

                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="cinemaList align-items-center text-center">
                    <div class="cinemaOne mb-2 text-muted" style="color: #999999">
                        판매자 : ${goodsDTO.sellerName}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
