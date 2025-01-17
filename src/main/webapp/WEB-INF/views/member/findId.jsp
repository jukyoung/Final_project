<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <title>아이디 찾기</title>
</head>
<style>


/* 타이틀 수평선 hr */
#hr {
    margin: 16px;
}

/* 줄간격 여백주기 */
.bodyContent > .row {
    margin-top: 10px;
}

/* 백그라운드 컬러 */
.body {
    background-color: rgb(231, 231, 231);
}

/* 하이퍼링크 */
.cls-href {
    color: black;
    text-decoration: none;
}


/* 바디 전체 */
.body {
    padding: 20px;
}

/* 찾기 너비 */
.cls-findBox {
    width: 300px;
    margin-bottom: 25px;
}

/* 휴대전화 인풋창에 화살표 안나오게 */ 
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
    -webkit-appearance: none;
}

/* 라벨링 */
.cls-label {
    margin-bottom: 10px;
}

/* 아이디찾기버튼 */
.buttonRow {
    margin-top: 50px;
}

#btnFindId {
    width: 200px;
}

</style>
<body>
    <div class="container">
        <div class="header">
            여기는 헤더
        </div>

        <div class="body">
            <div class="bodyTitle">
                <div class="row">
                    <div class="col d-flex justify-content-center">
                        <h1>아이디 찾기</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <hr id="hr">
                    </div>
                </div>
            </div>

            <div class="bodyContent">

                <div class="row">
                    <div class="col d-flex justify-content-center">
                        <div class="cls-findBox">
                            <div class="row cls-label">
                                <div class="col">
                                    <input type="radio" id="findToEmail" name="findOption" checked>
                                    <label for="findToEmail">&nbsp;가입한 이메일로 찾기</label>    
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <input type="text" class="form-control" name="email" id="email" placeholder="이메일을 입력하세요">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col d-flex justify-content-center">
                        <div class="cls-findBox">
                            <div class="row cls-label">
                                <div class="col">
                                    <input type="radio" id="findToPhone" name="findOption">
                                    <label for="findToPhone">&nbsp;가입한 휴대전화로 찾기</label>    
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">
                                    <select class="form-select" id="phone1">
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                    </select>        
                                </div>
                                <div class="col-4">
                                    <input type="number" id="phone2" class="form-control" maxlength="4" oninput="maxLengthCheck(this)">
                                </div>
                                <div class="col-4">
                                    <input type="number" id="phone3" class="form-control" maxlength="4" oninput="maxLengthCheck(this)">
                                </div>
                            </div>           

                        </div>
                    </div>
                </div>

                <div class="row buttonRow">
                    <div class="col d-flex justify-content-center">
                        <button type="button" class="btn btn-light" id="btnFindId">아이디 찾기</button>
                    </div>
                </div>

            </div>
        </div>

        <div class="footer">
            여기는 풋터
        </div>
    </div>
    <script>

        /* input number타입에 maxvalue 설정하기 (휴대전화번호) */
        function maxLengthCheck(object){
            if (object.value.length > object.maxLength){
                object.value = object.value.slice(0, object.maxLength);
            }    
        }
    </script>    

</body>
</html>