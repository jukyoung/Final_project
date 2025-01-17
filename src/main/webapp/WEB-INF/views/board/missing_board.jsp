<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
	<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>실종 게시판</title>
<style>
.header {
	margin-bottom: 20px;
}
/*실종 게시판 타이틀*/
.title {
	border-bottom: 1px solid black;
}

/* 검색 select */
.selectMissing {
	margin-top:2px;
	width: 100%;
}
.searchDiv{
 margin-top : 20px;
 margin-bottom : 10px;
}
/* 검색 input 창 감싸는 div */
.shMissing {
	position: relative;
	width: 300px;
}
/* 검색 input */
#keywordMissing {
	width: 100%;
	border: 1px solid #bbb;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px;
}
/* 돋보기 이미지 */
.lookup {
	position: absolute;
	width: 17px;
	top: 12px;
	right: 12px;
	margin-right: 15px;
	cursor: pointer;
}

.missingContent {
	margin-top: 30px;
}
/* 실종 동물이 없을경우 */
.nomissing {
	font-size: 100px;
}
/* 실종 카드 */
.card {
	margin-bottom: 30px;
}

.cardMissing {
	margin: 10px;
}

.card-title {
	font-size: 30px;
	font-weight: bold;
}
/*반응형 실종 목록 */
.resMissing {
	padding: 10px;
	border-bottom: 1px solid black;
}

.missingContent img {
	width: 100%;
	height: 100%;
}
/* 페이징 */
.page {
	display: flex;
	justify-content: center;
	gap: 20px;
}

.page a {
	display: block;
	margin: 0 3px;
	font-size: 20px;
	color: #cf936f !important;
	text-decoration: none !important;
}

.page a:hover {
	background-color: #f9f9f9;
	color: #555;
	border: 1px solid #aaa;
	border-radius: 2px;
}

</style>
</head>
<body>
	<div class="container">
		<div class="row header">
			<jsp:include page="/WEB-INF/views/frame/header.jsp"/>
		</div>
		<div class="row body">
			<div class="row title">
				<div class="col-7">
					<h1>실종 게시판</h1>
				</div>
				<div class="col-12 col-sm-5 searchDiv">
				<form id="searchForm">
					<div class="row d-flex justify-content-end">
						<div class="col d-block d-sm-none d-flex justify-content-end">
							<button type="button" class="btn btn-outline-light writeBtn" style="background-color: #cfb988;">글쓰기</button>
						</div>
						<div class="col-3 p-0">
						<select name="category" class="form-select selectMissing">
							<option value="title" selected>제목</option>
							<option value="content">내용</option>
							<option value="writerNickname">작성자</option>
							<option value="area">지역</option>
						</select>
						</div>
						<div class="col shMissing">
							<input type="text" name="keywordMissing" id="keywordMissing" class="form-control"
								placeholder="검색어 입력" onkeypress="enterKey(event)" > 
								<img class="lookup" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
						</div>	
					</div>
					</form>
				</div>
			</div>
			<div class="row missingContent row-cols-md-3 g-3">
				<c:if test="${map.list.size() == 0}">
					<div class="col nomissing d-flex justify-content-center">
						<p><strong>실종 동물이 없습니다.</strong></p>
					</div>
				</c:if>
				<c:if test="${map.list.size() > 0}">
					<c:forEach items="${map.list}" var="dto">
						<div class="col-6 d-none d-sm-flex justify-content-center">
							<div class="card" style="width: 19rem;">
								<a href="/miss/toDetail?seq_board=${dto.seq_board}">
							<c:if test="${empty dto.files_sys}">
                            	<img src="/resources/images/No_image.png">
                        	</c:if>
                        	<c:if test="${not empty dto.files_sys}">
                           		 <img src="/mbFile/${dto.files_sys}">
                        	</c:if></a>
								<div class="card-body">
									<h5 class="card-title">${dto.board_title}</h5>
									<p>실종지역 : <strong>${dto.miss_area}</strong></p>
									<p> 동물 종류 : <strong>${dto.animal_kind}</strong></p>
									<c:set var="TextValue" value="${dto.miss_date}" />
									<p class="card-text">실종일 : <strong>${fn:substring(TextValue, 0, 10)}</strong></p>
									<c:set var="TextDate" value="${dto.written_date}" />
									<p class="card-text">작성일 : <strong>${fn:substring(TextDate, 0, 10)}</strong></p>						
								</div>
							</div>
						</div>
						<div class="col-12 d-sm-none">
							<div class="row resMissing">
								<div class="col">
									<a href="/miss/toDetail?seq_board=${dto.seq_board}">
									<c:if test="${empty dto.files_sys}">
                            			<img src="/resources/images/No_image.png">
                        			</c:if>
                        			<c:if test="${not empty dto.files_sys}">
                           		 		<img src="/mbFile/${dto.files_sys}">
                        			</c:if></a>
								</div>
								<div class="col">
									<h5 class="card-title">${dto.board_title}</h5>
									<p>실종 지역 : <strong>${dto.miss_area}</strong></p> 
									<p>동물 종류 : <strong>${dto.animal_kind}</strong></p>
									<c:set var="TextValue" value="${dto.miss_date}" />
									<p class="card-text">실종일 : <strong>${fn:substring(TextValue, 0, 10)}</strong></p>
									<c:set var="TextDate" value="${dto.written_date}" />
									<p class="card-text">작성일 : <strong>${fn:substring(TextDate, 0, 10)}</strong></p>
								</div>

							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="row">
				<div class="col page d-flex justify-content-end">
				  <c:if test="${empty map.category}">
                <c:if test="${map.pagingVO.startPage!=1}">
                    <a id="first"
                       href="/miss/toMissing?curPage=1">첫
                        페이지</a>
                    <a class="arrow left"
                       href="/miss/toMissing?curPage=${map.pagingVO.startPage-1}">&lt;</a>
                </c:if>
                <c:forEach begin="${map.pagingVO.startPage}" end="${map.pagingVO.endPage}" var="p" step="1">
                    <a href="/miss/toMissing?curPage=${p}">${p}</a>
                </c:forEach>
                <c:if test="${map.pagingVO.endPage != map.pagingVO.lastPage}">
                    <a class="arrow right"
                       href="/miss/toMissing?curPage=${map.pagingVO.endPage+1}">&lt></a>
                    <a id="last"
                       href="/miss/toMissing?curPage=${map.pagingVO.lastPage}">끝페이지</a>
                </c:if>
            </c:if>
            <c:if test="${not empty map.category}">
                <c:if test="${map.pagingVO.startPage!=1}">
                    <a id="first"
                       href="/miss/search?category=${map.category}&search=${map.search}">첫
                        페이지</a>
                    <a class="arrow left"
                       href="/miss/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.startPage-1}">&lt;</a>
                </c:if>
                <c:forEach begin="${map.pagingVO.startPage}" end="${map.pagingVO.endPage }" var="p" step="1">
                    <a href="/miss/search?category=${map.category}&search=${map.search}&curPage=${p}">${p}</a>
                </c:forEach>
                <c:if test="${map.pagingVO.endPage != map.pagingVO.lastPage}">
                    <a class="arrow right"
                       href="/miss/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.endPage+1}">&lt></a>
                    <a id="last"
                       href="/miss/search?category=${map.category}&search=${map.search}&curPage=${map.pagingVO.lastPage}">끝페이지</a>
                </c:if>
            </c:if>
				</div>
				<div class="col d-none d-sm-flex justify-content-end">
					<button type="button" class="btn btn-outline-light writeBtn" style="background-color: #cfb988;">글쓰기</button>
				</div>
			</div>
		</div>
		<div class="row footer">
			<jsp:include page="/WEB-INF/views/frame/footer.jsp"></jsp:include>
		</div>
	</div>
	<script>
		// 글쓰기 버튼눌렀을때
		$(".writeBtn").click(function(){
			location.href = "/miss/toWrite";
		})
	
		// 검색
		$(".lookup").click(function(){

			if ($("#keywordMissing").val() == "") {
				location.href = "/miss/toMissing";
			}else {
				let formData = $("#searchForm").serialize();
				console.log(formData);

				$.ajax({
					url : "/miss/search"
					,type: "get"
					,data : formData
					, success : function(data) {
						console.log(data);
						//mkElement(data);
						$(".missingContent").empty();
						if(data.list.length == 0){ // 검색 결과 없음
							let divRow = $("<div>").addClass("col d-flex justify-content-center");
							let p2 = $("<p>")
							let strong = $("<strong>").html("검색된 결과가 없습니다.");
							p2.append(strong);
							p2.appendTo(divRow);
							$(".missingContent").append(divRow);
							$(".page").addClass("d-none");
						}else{
							for(let dto of data.list){
								console.log(typeof dto.miss_date);
								let miss_date = new Date(dto.miss_date - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, 10);
								let written_date = new Date(dto.written_date).toISOString().slice(0, 10);
				
								let col2 = $("<div>").addClass("col-6 d-none d-sm-flex justify-content-center");
								let card = $("<div>").addClass("card").css("width", "18rem");
								let a = $("<a>").attr("href","/miss/toDetail?seq_board="+dto.seq_board);
								if(dto.files_sys == null){
									let img = $("<img>").attr("src", "/resources/images/No_image.png").addClass("card-img-top");
									a.append(img);
								}else if(dto.files_sys != null){
									let img = $("<img>").attr("src", "/mbFile/"+dto.files_sys).addClass("card-img-top");
									a.append(img);
								}
								console.log();
								let cardBody = $("<div>").addClass("card-body");
								let h5 = $("<h5>").addClass("card-title").html(dto.board_title);
								let pMiss = $("<p>").html("실종 지역 : " );
								let sMiss = $("<strong>").html(dto.miss_area);
								let pKind = $("<p>").html("동물 종류 : " );
								let sKind = $("<strong>").html(dto.animal_kind);
								let cardText = $("<p>").addClass("card-text").html("실종일 : ");
								let scardText = $("<strong>").html(miss_date);
								let cardText2 = $("<p>").addClass("card-text").html("작성일 : " );
								let scardText2 = $("<strong>").html(written_date);
								
								pMiss.append(sMiss);
								pKind.append(sKind);
								cardText.append(scardText);
								cardText2.append(scardText2);
								cardBody.append(h5, pMiss, pKind, cardText, cardText2);
								
								card.append(a, cardBody);
								col2.append(card);
								col2.appendTo(".missingContent");
								
								let div3 = $("<div>").addClass("col-12 d-sm-none");
								let row = $("<div>").addClass("row resMissing");
								let col3 = $("<div>").addClass("col");
								let a2 = $("<a>").attr("href","/miss/toDetail?seq_board="+dto.seq_board);
								if(dto.files_sys == null){
									let img2 = $("<img>").attr("src", "/resources/images/No_image.png").addClass("card-img-top");
									a2.append(img2);
								}else if(dto.files_sys != null){
									let img2 = $("<img>").attr("src", "/mbFile/"+dto.files_sys).addClass("card-img-top");
									a2.append(img2);
								}
								let col4 = $("<div>").addClass("col");
								let h5_1 = $("<h5>").addClass("card-title").html(dto.board_title);
								let p3 = $("<p>").html("실종지역 : ");
								let sP3 = $("<strong>").html(dto.miss_area);
								let p4 = $("<p>").html("동물 종류 : ");
								let sP4 = $("<strong>").html(dto.miss_area);
								let p1 = $("<p>").html("실종일 : ");
								let sP1 = $("<strong>").html(miss_date);
								let p2 = $("<p>").html("작성일 : ");
								let sP2 = $("<strong>").html(written_date);
								
								p3.append(sP3);
								p4.append(sP4);
								p1.append(sP1);
								p2.append(sP2);
								
								col4.append(h5_1, p3, p4, p1, p2);
								col3.append(a2);
								row.append(col3, col4);
								div3.append(row);
								div3.appendTo(".missingContent");
								$(".page").removeClass("d-none");
							}
						}
						
					}, error : function(e) {
						console.log(e);
					}
				})
			}
		})
	</script>
	
</body>
</html>