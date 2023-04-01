<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link href="/resources/images/CC_mark.JPG" rel="shortcut icon" type="image/x-icon">

    <title>정보 수정 - CC</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Nunito:wght@700&display=swap');

        .all {
            font-family: 'Gowun Dodum', sans-serif;
            height: 100%;
            width: 100%;
        }

        .hello {
            font-family: 'Gowun Dodum', sans-serif;
            width: 100%;
            height: 15%;
        }

        .info {
            font-size: 18px;
        }

        hr {
            margin-top: 0 !important;
        }

        .table {
            width: 90%;
            border: 1px solid rgb(200, 200, 200);
            border-top: 3px solid black;
            border-bottom: 3px solid black;
            border-collapse: collapse;
            margin: auto;
        }

        .info-th {
            font-size: 20px;
            line-height: 100%;
            border-right: 1px solid rgb(200, 200, 200) !important;
            width: 120px;
        }

        .span-1 {
            margin-right: 50px;
        }

        .span-2 {
            margin-right: 66px;
        }

        .span-3 {
            margin-right: 13px;
        }

        form {
            margin-bottom: 0 !important;
        }

        .btn-control {
            display: flex;
            flex-direction: row-reverse;
        }

    </style>
    <%--    <script src="web/assets/js/user/delete.js"></script>--%>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script>

        let deleteUser = (id) => {
            // let id = new URLSearchParams(window.location.search).get("id");
            let data = {
                "id": id
            }
            Swal.fire({
                title: '회원 탈퇴를 하시겠습니까?',
                showCancelButton: true,
                confirmButtonText: "탈퇴",
                cancelButtonText: "취소",
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: '기존 비밀번호',
                        input: 'password',
                        inputLabel: '기존 비밀번호를 입력해주세요.',
                        inputPlaceholder: '기존 비밀번호',
                        inputAttributes: {
                            maxlength: 30,
                            autocapitalize: 'off',
                            autocorrect: 'off'
                        }
                    }).then((oldPassword) => {
                        data["oldPassword"] = oldPassword.value;
                        console.log(data);
                        $.ajax({
                            url: "/user/delete/" + id,
                            method: "get",
                            data: data,
                            success: function (message) {
                                console.log(message)
                                let result = (JSON).parse(message);
                                if (result.status == "success") {
                                    console.log(result.nextPath);
                                    Swal.fire({
                                        title: result.content,
                                        text: result.message,
                                        icon: result.status
                                    }).then(() => {
                                        location.href = result.nextPath;
                                    });
                                } else {
                                    console.log(result.nextPath);
                                    Swal.fire({
                                        title: result.content,
                                        text: result.message,
                                        icon: result.status
                                    }).then(() => {
                                        location.href = result.nextPath;
                                    });
                                }
                            }
                        });
                    });
                }
            })
        }
    </script>
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
    <script>
        async function submitUpdate() {
            let id = new URLSearchParams(window.location.search).get("id");
            let nickname = $('input[name="nickname"]').val();
            let password = $('input[name="password"]').val();
            let email = $('input[name="email"]').val();

            let data = {
                "nickname": nickname,
                "password": password,
                "email": email,
                "id": id
            };

            Swal.fire({
                title: '기존 비밀번호',
                input: 'password',
                inputLabel: '기존 비밀번호를 입력해주세요.',
                inputPlaceholder: '기존 비밀번호',
                inputAttributes: {
                    maxlength: 30,
                    autocapitalize: 'off',
                    autocorrect: 'off'
                }
            }).then((oldPassword) => {
                data["oldPassword"] = oldPassword.value;
                $.ajax({
                    url: "/member/update",
                    method: "post",
                    data: data,
                    success: function (message) {
                        let result = JSON.parse(message);

                        if (result.status == 'success') {
                            Swal.fire({title: result.content, text: result.message, icon: "success"}).then(() => {
                                location.href = result.nextPath;

                            });
                        } else {
                            Swal.fire({title: result.content, text: result.message, icon: "warning"}).then(() => {
                                location.href = result.nextPath;
                            });
                        }
                    }
                })
            })

        }

    </script>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
    <main>
        <div class="hello">
            <h3 class="mb-3"><span style="color: navy; font-weight: bolder">${userDTO.nickname} 고객님</span>, 반갑습니다 !</h3>
            <div class="hello-left">
                <h4>✔ 회원 정보 수정</h4>
                <div class="text-muted">※ 정보 수정시 각 변경 버튼을 눌러주세요.</div>
            </div>
        </div>
        <div class="all">
            <table class="table">
                <tr>
                    <th class="text-center info-th text-muted">아이디</th>
                    <td class="info text-muted">${userDTO.username}</td>
                </tr>
                <tr>
                    <th class="text-center info-th" style="line-height: 150px">비밀번호</th>
                    <td class="info">
                        <form action="/user/updatePw/${userDTO.id}" method="post">
                            <span class="span-1">현재 비밀번호</span> <input type="password" name="oldPw"
                                                                       class="mb-2"><br>
                            <span class="span-2">새 비밀번호</span> <input type="password" name="newPw"
                                                                      class="mb-2"><br>
                            <span class="span-3">비밀번호 다시 입력 </span> <input type="password" name="newPw2"
                                                                           class="mb-2"><br>
                            <span class="text-danger">${message}</span><br>
                            <button type="submit" class="badge text-bg-secondary">비밀번호 변경</button>
                        </form>
                    </td>
                </tr>
                <tr>
                    <th class="text-center info-th">닉네임</th>
                    <td class="info">
                        <form action="/user/updateNick/${userDTO.id}" method="post">
                            <input type="text" name="nickname" maxlength="10" value="${userDTO.nickname}">
                            <button type="submit" class="badge text-bg-secondary">닉네임 변경</button>
                        </form>
                    </td>
                </tr>
                <tr>
                    <th class="text-center info-th">이메일</th>
                    <td class="info">
                        <form action="/user/updateEmail/${userDTO.id}" method="post">
                            <input type="email" name="email" value="${userDTO.email}">
                            <button type="submit" class="badge text-bg-secondary">이메일 변경</button>
                        </form>
                    </td>
                </tr>
                <tr>
                    <th class="text-center info-th" style="line-height: 232px">주소</th>
                    <td class="info">
                        <span>현재 우편번호 : ${userDTO.postcode}</span><br>
                        <span>현재 주소 : ${userDTO.address}</span>
                        <form action="/user/updateAddr/${userDTO.id}" method="post">
                            <button type="submit" class="badge text-bg-secondary mb-2">주소 변경</button>

                            <div class="mb-2">
                                <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
                                <input type="text" id="zip_code" name="postcode" placeholder="우편번호">
                            </div>
                            <input type="text" id="roadAddress" class="form-control mb-2" name="address"
                                   placeholder="도로명주소">
                            <input type="text" id="detailAddr" class="form-control mb-2" name="address"
                                   placeholder="상세주소">

                            <span id="guide" style="color:#999"></span>
                        </form>
                    </td>
                </tr>
                <tr>
                    <th class="text-center info-th">전화번호</th>
                    <td class="info">
                        <form action="/user/updateNum/${userDTO.id}" method="post">
                            <input type="text" name="phone" value="${userDTO.phone}">
                            <button type="submit" class="badge text-bg-secondary">전화번호 변경</button>
                        </form>
                    </td>
                </tr>
            </table>
            <%--            <form action="/user/delete/${userDTO.id}" method="get">--%>
            <%--                <button type="submit" class="btn btn-danger">회원 탈퇴</button>--%>
            <%--            </form>--%>
            <div class="btn-control" style="width: 100%">
                <button type="button" class="btn btn-danger" onclick="deleteUser(${userDTO.id})">회원 탈퇴</button>
            </div>
        </div>
    </main>
</div>

</body>
</html>
