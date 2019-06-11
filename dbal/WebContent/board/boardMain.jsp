<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<style media="screen">

.wrap {
	position: absolute;
	width: 100%;
	left: 0;
	top: 15;
	font-size: 14px;
}

.window-overlay {
	align-items: flex-start;
	background-color: rgba(0, 0, 0, .64);
	height: 100%;
	justify-content: center;
	left: 0;
	overflow-y: auto;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 20;
	display:none;
	padding-top: 80px;
}

.wrap .box {
	margin-left: 20px;
	margin-top: 15px;
}

input {
	background: #fff;
	border: none;
	/*  box-shadow: inset 0 0 0 2px ; */ /* TODO: 그림자*/
	display: block;
	transition: margin 85ms ease-in, background 85ms ease-in;
	width: 100%;
	padding: 5px;
}

/* 리스트가 담기는 가로 스크롤 박스*/
.board-list-wrap {
	width: 100%;
	height: 100%; /* TODO: 화면 높이로 설정 해줘야 함 */
	white-space: nowrap;
	overflow-x: auto;
	overflow-y: hidden;
	margin-top: 20px;
	margin-bottom: 8px;
	padding-bottom: 8px;
}

/* 리스트 하나 */
.list-box-wrap {
	width: 272px;
	margin: 0 4px;
	height: 100%;
	box-sizing: border-box;
	display: inline-block;
	vertical-align: top;
	white-space: nowrap;
}

.list-box-wrap .list-content {
	background-color: #e6f2ff;
	border-radius: 5px;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	max-height: 100%;
	position: relative;
	white-space: normal;
	padding: 10px;
}

.list-content .title {
	font-size: 1.1em;
	font-weight: bold;
}

.list-content .card {
	background-color: white;
	border-radius: 5px;
	width: 100%;
	min-height: 30px;
	padding: 5px;
	/* box-shadow: 0.1px 2px 5px grey; */
	margin-top: 10px;
	cursor: pointer;
}

.card .subCard {
	margin-top: 10px;
	margin-bottom: 5px;
}

.add-list-content {
	background-color: #b3d9ff;
	border-radius: 5px;
	cursor: pointer;
	color: #fff;
	padding: 5px;
}

.btn {
	background-color: silver;
	color: white;
	border: none;
	border-radius: 0;
	cursor: pointer;
	width: 100%;
	margin-top: 10px;
	opacity: 0.8;
	border-radius: 5px;
}

.blue-btn {
	background-color: silver;
	color: white;
	border: none;
	border-radius: 0;
	cursor: pointer;
	width: 100%;
	height: 36px;
	opacity: 0.8;
	border-radius: 5px;
}

.blue-btn:hover {
	background-color: #16a5f7 !important;
}

.blue-btn.active {
	background-color: #666;
	color: white;
}

.cardback {
	padding: 5px;
	margin-right: 5px;
	background-color : #b3d9ff;
	border-radius: 5px;
	opacity: 0.8;
}


</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../js/ajax.js"></script>

<script>
	// 엔터키 누를 때, Submit 처리되지 않도록 이벤트 방지 함
	document.addEventListener('keydown', function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
		}
	}, true);

	/**
	 *  카드 상세 보여줌 
	 **/
	function showCardDetail(card_id) {

		if (typeof this.id != 'undefined') {
			card_id = this.id.split('-')[1];
		}
		console.log("card_id : " + card_id);

		$("#cardDetailFrame").attr("src",
				"../ajax/cardInfo.do?card_id=" + card_id);
		$("#cardDetailFrame").css("display", "flex");
	}

	/**
	 *  보드 리스트 처리 
	 **/

	// 보드 리스트 추가
	function addBoardList() {

		console.log("addBoardList()");

		var list_name = document.listForm.listName.value;
		// 리스트 이름 빈값 체크
		if (!list_name) {
			alert("리스트의 이름을 입력해주세요.");			
			return;
		}

		console.log("보드ID : " + "${board.board_id}");

		var params = "list_name=" + encodeURIComponent(list_name)
				+ "&board_id=${board.board_id}";
		new ajax.xhr.Request('../ajax/insertBoardList.do', params,
				addListResult, 'POST');
	}

	// 보드 리스트 등록 콜백함수
	function addListResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				console.log("결과 처리 완료");

				// JSON Data
				var listData = JSON.parse(req.responseText);

				$("#board-list").append(makeListElement(listData));

				// 등록폼 텍스트필드 클리어
				document.listForm.listName.value = '';
			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	// 카드 추가
	function addCard() {

		console.log("addCard()");

		var card_name = document.cardInputForm.cardName.value;
		if (!card_name)
			return;

		// 카드 입력폼의 상위 DIV에서 ListID 값을 가져온다
		var list_id = $("#card-Input-div").parent().attr("id").split('-')[1];

		console.log("부모 ListID : " + list_id);

		// Card 값을 저장
		var params = "card_name=" + encodeURIComponent(card_name) + "&list_id="
				+ list_id;
		new ajax.xhr.Request('../ajax/insertCard.do', params, addCardResult,
				'POST');
	}

	// 카드 등록 콜백함수
	function addCardResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				console.log("결과 처리 완료");

				// JSON Data
				var cardData = JSON.parse(req.responseText);

				console.log(cardData);

				// 카드 추가할 리스트 Div 찾음
				var cardListDiv = document.getElementById("cardList-"
						+ cardData.list_id);
				var cardElement = makeCardElement(cardData);

				console.log("새로운 card - " + cardElement.id);

				cardListDiv.appendChild(cardElement);

				// 카드 등록폼 화면 초기화, 안보이게
				cancelAddCard();

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	function makeListElement(listData) {

		var div = document.createElement("div");
		div.className = 'list-box-wrap';
		div.setAttribute("id", "l-" + listData.list_id);
		div.ondrop = drop;
		div.ondragover = allowDrop;

		var str = "<div class=\"list-content\">"
				+ "<div id=\"listName\" class=\"title\">"
				+ listData.list_name
				+ "</div>"
				+ "<div id=\"cardList-" + listData.list_id
				+ "\" style=\"min-height: 20px; padding-bottom: 20px;\">"
				+ "</div>"

				+ "<div>"
				+ "<div id=\"addCard\">"
				+ "<button  type=\"button\" class=\"btn\" onclick=\"viewAddCardForm('"
				+ listData.list_id + "')\">+ add card</button>"

				+ "<div id=\"cardInput-" + listData.list_id + "\"></div>"
				+ "</div>" + "</div>";

		div.innerHTML = str;

		return div; 
	}
	
	

	// 카드 div 생성
	function makeCardElement(cardData) {

		var cardDiv = document.createElement("div");

		cardDiv.className = 'card';
		cardDiv.setAttribute("id", "c-" + cardData.card_id);
		cardDiv.draggable = "true";

		cardDiv.addEventListener("click", showCardDetail);
		cardDiv.addEventListener("ondragstart", drag);
		
		// 카드이름
		var nSpan = document.createElement("span");
		nSpan.setAttribute("id", "cn-" + cardData.card_id);
		nSpan.innerHTML = cardData.card_name;
		
		
		// 서브카드 영억
		var subDiv = document.createElement("div");
		subDiv.className = 'subCard';
		subDiv.setAttribute("id", "s-" + cardData.card_id);

		
		// 체크아이템 표시영역
		var dueDateDiv = document.createElement("div");
		dueDateDiv.setAttribute("id", "card-dueDate");
		dueDateDiv.style.display = "inline-block";
		
		// DueDate 표시영역
		var calImg = document.createElement("img");
		calImg.setAttribute("id", "cali-" + cardData.card_id);
		calImg.setAttribute("src", "../images/calendar.png");
		calImg.setAttribute("width", "20");
		calImg.setAttribute("height", "20");
		calImg.style.visibility = "hidden";
		
		dueDateDiv.appendChild(calImg);
		
		var subSpan = document.createElement("span");
		subSpan.setAttribute("id", "d-" + cardData.card_id);
		
		dueDateDiv.appendChild(subSpan);
		
		
		// 체크아이템 표시영역
		var checkItemDiv = document.createElement("div");
		checkItemDiv.setAttribute("id", "card-checkItem");
		checkItemDiv.style.display = "inline-block";
		
		var img = document.createElement("img");
		img.setAttribute("id", "chi-" + cardData.card_id);
		img.setAttribute("src", "../images/check_.png");
		img.setAttribute("width", "20");
		img.setAttribute("height", "20");
		img.style.visibility = "hidden";
		
		checkItemDiv.appendChild(img);
		
		var checkSpan = document.createElement("span");
		checkSpan.setAttribute("id", "ch-" + cardData.card_id);
		
		checkItemDiv.appendChild(checkSpan);
		// 체크 아이템
		
		// 
		cardDiv.appendChild(nSpan);	
		subDiv.appendChild(dueDateDiv);
		subDiv.appendChild(checkItemDiv);
		cardDiv.appendChild(subDiv);
		
		return cardDiv;
	}

	/**
	 *  카드추가 입력 창 처리 
	 **/

	// 카드 추가버튼 이벤트 핸들러
	function viewAddCardForm(listId) {
		var cardInputDiv = document.getElementById('cardInput-' + listId);
		var cardInputFormDiv = document.getElementById('card-Input-div');
		// 현재 카드 추가 폼이 보이고 있으면 보일 필요 없음
		if (cardInputFormDiv.parentNode != cardInputDiv) {
			// appendChild() 하면 이동할 수 있음
			// 카드 추가 폼을 카드 목록 밑에 보이도록 추가
			cardInputDiv.appendChild(cardInputFormDiv);
		}
		// 수정할 값을 텍스트필드에 보이게
		document.cardInputForm.cardName.value = '';
		cardInputFormDiv.style.display = '';
	}

	// 취소
	function cancelAddCard() {
		// 카드 추가 폼을 안보이게
		var cardInputFormDiv = document.getElementById('card-Input-div');
		document.body.appendChild(cardInputFormDiv);
		cardInputFormDiv.style.display = "none"; // 안보이게
	}

	/**
	 *  카드 이동 처리 
	 **/

	// 카드를 다른 리스트로 이동 시, 리스트 아이디 업데이트
	function moveCard(card_id, list_id) {

		// DB 처리
		var params = "card_id=" + card_id + "&list_id=" + list_id;
		console.log(params);

		new ajax.xhr.Request('../ajax/moveCard.do', params, moveCardResult,
				'POST');
	}

	// 카드를 다른 리스트로 이동 시, 콜백함수
	function moveCardResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				var resultData = JSON.parse(req.responseText);

				// 데이터 처리가 완료되지 않으면 해당 체크를 원래대로 돌린다
				if (resultData.result == true) {
					// 이동 시키기
					$("#cardList-" + resultData.list_id).append($("#c-" + resultData.card_id));
				}
			}
		}
	}

	/**
	 * 카드 이동 시키는 이벤트
	 */
	function allowDrop(ev) {
		ev.preventDefault();
	}

	function drag(ev) {
		ev.dataTransfer.setData("text", ev.target.id);
	}

	function drop(ev) {
		ev.preventDefault();
		// 카드 리스트일 경우에만 이동
		if (ev.target.id.indexOf("cardList") >= 0) {
			var data = ev.dataTransfer.getData("text");

			// 이동된 카드의 리스트 아이디를 DB에 업데이트
			console.log("카드ID : " + data + ", 이동 할 리스트 ID: " + ev.target.id);
			moveCard(data.split('-')[1], ev.target.id.split('-')[1]);
		}
	}
</script>


<div class="wrap">
	<div class="box">
		<!-- 상단 보드명  -->
		<span style="font-size: 2rem; font-weight: bold;">&nbsp;${boardInfo.board.board_name}&emsp;</span>
		<button type="button" class="blue-btn" style="width: 150px;"
			onclick="location='./boardDelete.do?board_id=${boardInfo.board.board_id}'">보드 삭제</button>
		<!-- 보드 리스트 -->
		<div class="board-list-wrap">
			<div id="board-list" style="display: inline-block;">
				<c:forEach items="${boardInfo.boardList}" var="list">

					<!-- 리스트 박스 -->
					<div class="list-box-wrap" id="l-${list.list_id}"
						ondrop="drop(event)" ondragover="allowDrop(event)">
						<div class="list-content">
							<!-- 컨텐트 제목 -->
							<div id="listName" class="title">${list.list_name}</div>

							<!-- 카드목록 -->
							<div style="display: block;">
								<div id="cardList-${list.list_id}"
									style="min-height: 20px; padding-bottom: 20px;">
									<c:forEach items="${list.cardList}" var="card">
										<div class="card" id="c-${card.card_id}" draggable="true" onclick="showCardDetail('${card.card_id}')"
											ondragstart="drag(event)">
											
												<span id="cn-${card.card_id}">${card.card_name}</span>
											
											<div class="subCard" id="s-${card.card_id}">
												<!-- Due date -->
												<div id="card-dueDate" style="display: inline-block;">
														 <c:if test="${card.due_date != null}"> 
															<img id="cali-${card.card_id}" src="../images/calendar.png" width="20" height="20" style="visibility: visible;">
														 </c:if>
														 <c:if test="${empty card.due_date }"> 
															<img id="cali-${card.card_id}" src="../images/calendar.png" width="20" height="20" style="visibility: hidden;">
														 </c:if>
														<span class="<c:if test="${card.done=='T'}">cardback</c:if>" id="d-${card.card_id}">${card.due_date}</span>
												</div>
												
												<!-- 체크리스트 개수 -->
												<div id="card-checkItem" style="display: inline-block;">
													<c:if test="${card.total != 0}"> 
														<img id="chi-${card.card_id}" src="../images/check_.png" width="20" height="20" style="visibility: visible;">
													</c:if>
													<c:if test="${card.total == 0}"> 
														<img id="chi-${card.card_id}" src="../images/check_.png" width="20" height="20" style="visibility: hidden">
													</c:if>
													<span id="ch-${card.card_id}"> 
														<c:if test="${card.total != 0}"> 
															${card.checkedsum}/${card.total}
														</c:if>
													</span>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
								<div>
									<!-- 카드 추가 -->
									<div id="addCard">
										<button type="button" class="btn"
											onclick="viewAddCardForm('${list.list_id}')">+ add
											card</button>

										<!-- 카드 추가 입력 폼 위치 -->
										<div id="cardInput-${list.list_id}"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 새로운 리스트 추가 (항상 맨 끝에 위치) -->
			<div style="display: inline-block;">
				<div class="list-box-wrap">
					<div class="add-list-content" style="padding-top: 10px; padding-bottom: 10px;">
						<form name="listForm">
							<input type="text" name="listName"
								placeholder="Enter list title..." maxlength="20" required >
							<div style="margin-top: 10px;">
								<button class="blue-btn" type="button" onclick="addBoardList()" style="background-color: #16a5f7">Add
									List</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 카드 추가 입력폼 시작 -->
<div id="card-Input-div"
	style="display: none; margin-top: 10px; margin-bottom: 10px;">
	<form name="cardInputForm">
		<div>New Card</div>
		<input type="text" name="cardName" placeholder="Enter Card title..."
			value="" required style="margin-top: 10px;">
		<div style="margin-top: 10px;">
			<button type="button" class="blue-btn" onclick="addCard()" style="width: 49%">Create</button>
			<button type="button" class="blue-btn" onclick="cancelAddCard()" style="width: 49%">Cancel</button>
		</div>
	</form>
</div>

<!-- 카드 추가 입력폼 종료 -->

<!-- 카드 상세화면 -->
<div>
	<iframe id="cardDetailFrame" class="window-overlay"></iframe>
</div>


