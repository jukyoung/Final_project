<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: jangseoksu
  Date: 2022/07/15
  Time: 4:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        :root {
            --sil: #d5d5d5;
            --order: #d9d9d9;
            --grey: #313131;
        }

        * {
            box-sizing: border-box;
        }

        .container {
            width: 100%;
            min-height: 1800px;
            height: 1px;
        }

        .header {
            height: 10%;
        }

        .footer {
            height: 10%;
        }

        .title button {
            background-color: white;
            border: 1px solid var(--sil);
            color: var(--sil);
            border-radius: 5px;
        }

        .title button:hover {
            background-color: var(--sil);
            color: white;
        }

        .board {
            height: 80%;
            margin-top: 50px;
            padding: 50px;
        }

        .board_header {
            min-height: 400px;
            display: flex;
            gap: 50px;
            margin-bottom: 80px;
        }

        .representativeImg {
            flex-basis: 40%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
            border: 1px solid var(--sil);
        }

        .representativeImg img {
            width: 100%;
            height: auto;
        }

        .orderForm {
            flex-basis: 50%;
            display: flex;
            flex-direction: column;
        }

        .orderForm .shelter {
            height: 10%;
            border-bottom: 1px solid var(--sil);
            margin-bottom: 10px;
        }

        .shelter span {
            font-size: 1.3em;
        }

        .title {
            height: 8%;
            margin-top: 10px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            font-size: 1.2em;
        }

        .order_number {
            margin-top: 10px;
            height: 40%;
            background-color: var(--order);
            padding: 20px;
        }

        .order_number1 {
            height: 40%;
            border-bottom: 1px solid var(--sil);
            display: flex;
            align-items: center;
        }

        .order_number2 {
            height: 60%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .order_number2 button {
            background-color: var(--sil);
            border: none;
            color: white;
        }

        .order_number2 #order_number {
            width: 20px;
        }

        .total {
            margin-top: 20px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            padding-right: 20px;
        }

        .total span:first-child {
            color: var(--sil);
        }

        .order {
            display: flex;
            justify-content: center;
            height: 10%;
        }

        .order button {
            width: 50%;
            height: 100%;
            border: none;
            border-radius: 25px;
            background-color: var(--grey);
            color: #ffffff;
        }

        .info {
            display: flex;
            justify-content: center;
            border-bottom: 1px solid var(--sil);
            margin-bottom: 70px;
        }

        #order_number::-webkit-outer-spin-button,
        #order_number::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
</head>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<body>
<div class="container">
    <div class="header">HEADER</div>
    <div class="board">
        <div class="board_header">
            <div class="representativeImg">
                <c:if test="${not empty map.files_sys}">
                    <img src="/files/support/${map.files_sys}">
                </c:if>
                <c:if test="${empty map.files_sys}">
                    <img src="/resources/images/No_image.png">
                </c:if>
            </div>
            <form class="orderForm" action="/supportBoard/order">
                <div class="shelter">
                    <span><c:out value="${map.writer_nickname}"/> </span>
                </div>
                <div class="title">
                    <c:out value="${map.board_title}"/>
                    <c:if test="${loginSession.member_id eq map.member_id}">
                        <div class="boardButton">
                            <button type="button" id="modify">수정하기</button>
                            <button type="button" id="delete">삭제하기</button>
                        </div>
                    </c:if>
                </div>
                <div class="order_number">
                    <div class="order_number1">
                        <span>수량</span>
                    </div>
                    <div class="order_number2">
                        <div class="selection">
                            <button type="button" id="minus">-</button>
                            <input type="number" id="order_number" name="order_number" required="required" min="1">
                            <input type="hidden" id="price" name ="price">
                            <input type="hidden" name ="seq_board" value="${map.seq_board}">
                            <button type="button" id="plus">+</button>
                        </div>
                        <span> </span>
                    </div>
                </div>
                <div class="total">
                    <span>총 상품금액</span>
                    <span id="total">원</span>
                </div>
                <div class="order">
                    <button type="submit" id="order">신청(후원)하기</button>
                </div>
            </form>
        </div>
        <div class="info">상세 정보</div>
        <div class="board_content">
            ${map.board_content}
        </div>
    </div>
    <div class="footer">FOOTER</div>
</div>
<script>
    const plus = document.querySelector("#plus");
    const minus = document.querySelector("#minus");
    const order_number = document.querySelector("#order_number");
    const total = document.querySelector("#total");
    const price = 1000;
    let sum = 0;

    plus.addEventListener("click", ()=>{
        order_number.value++;
        changeTotal();
    });

    minus.addEventListener("click", ()=>{
        order_number.value--;
        changeTotal();
    });


    order_number.addEventListener("input",()=>{
        changeTotal();
    })

    document.querySelector(".order_number2> span:last-child").innerHTML = price.toLocaleString("ko-KR")+ " 원";
    document.querySelector("#price").value = price;

    function changeTotal () {
        if(order_number.value>0){
            sum = (order_number.value * price).toLocaleString("ko-KR");
            total.innerHTML = sum + "원";
        } else total.innerHTML = "원";

    }

    document.querySelector(".orderForm").addEventListener("submit", (e)=>{
        let loginSession = "${loginSession}";
        if(loginSession===null || loginSession===""){
            e.preventDefault();
            alert("회원만 이용할 수 있는 컨텐츠입니다.");
        }
    });

    document.querySelector("#delete").addEventListener("click", e=>{
        let check = confirm("정말로 삭제하시겠습니까?");
        if (check) {
            let form = document.createElement("form");
            form.method = "post";
            form.action = "/supportBoard/delete";

            let input = document.createElement("input");
            input.value = ${map.seq_board};
            input.type = "hidden";
            input.name = "seq_board";

            let arr = [];
            let imgs = document.querySelectorAll(".board_content img");
            imgs.forEach(e => arr.push(decodeURI(e.src)));

            let file = document.createElement("input");
            file.type = "hidden";
            file.name = "file_name";
            file.value = arr;

            form.append(input);
            form.append(file);
            document.body.append(form);
            form.submit();
        }
    });

    document.querySelector("#modify").addEventListener("click",()=>{
        location.href = "/supportBoard/modify?seq_board=${map.seq_board}"
    });

</script>
</body>
</html>
