<%--
  Created by IntelliJ IDEA.
  User: JinWoo
  Date: 2023-03-27
  Time: 오후 4:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counting App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        body {
            position: relative;
            background-color: #ffeded;
        }
        .countBox {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            padding: 20px 50px;
            box-sizing: border-box;
            background-color: rgb(240,240,240);
            border-radius: 10px;
            box-shadow: 1px 1px 15px rgb(250,250,250);
            width: 100%;
            max-width: 360px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }
        h1 {
            color: #ffffff;
            font-size: 20px;
        }
        button {
            border: 0;
            background-color: transparent;
        }
        .countNumber {
            font-size: 50px;
            font-weight: bold;
            color: white;
            margin: 10px 0;
        }
        .countButtonWrap > button {
            color: white;
            font-weight: bold;
            border-radius: 5px;
            background-color: #ff8888;
            padding: 5px 10px;
        }
    </style>
</head>
<body>
<div class="countBox">
    <h1>Counting App</h1>
    <p class="countNumber">0</p>
    <div class="countButtonWrap">
        <button class="minus">-</button>
        <button class="reset">Reset</button>
        <button class="plus">+</button>
    </div>
</div>
<script>
    let countNum = document.querySelector(".countNumber");
    let buttonWrap = document.querySelector(".countButtonWrap");

    buttonWrap.addEventListener("click", (e) => {
        if (e.target.classList.contains("plus")) {
            countNum.innerHTML++;
            //증가
        }
        if (e.target.classList.contains("minus")) {
            countNum.innerHTML--;
            //감소
        }
        if (e.target.classList.contains("reset")) {
            countNum.innerHTML = 0;
            //리셋
        }

        //음수일 경우 색상 변경
        if (countNum.innerHTML < 0) {
            countNum.style.color = "#ff4d4d"
        } else {
            countNum.style.color = "#ffffff"
        }
    })
</script>
</body>
</html>
