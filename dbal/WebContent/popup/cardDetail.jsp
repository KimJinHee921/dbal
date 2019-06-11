<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.window {
	display: block;
	background-color: #f5f6f7;
	border-radius: 5px;
	margin: auto;
	overflow: hidden;
	position: relative;
	width: 768px;
	z-index: 25;
}

.card-container {
	margin: 20px;
	font-size: 14px;
}

.card-name {
	font-size: 1.8em;
	font-weight: bold;
	margin-bottom: 15px;
}

.title {
	font-size: 1.2em;
	font-weight: bold;
}

.dueDate {
	display: inline-block;
}

.description {
	margin-top: 10px;
	margin-bottom: 20px;
}

.description textarea {
	resize: none;
	width: 100%;
	height: 108px;
	display: block;
	background: #fff;
	box-shadow: none;
	margin-top: 10px;
	margin-bottom: 10px;
}

/* check list style */
.checkList {
	margin-top: 10px;
	margin-bottom: 20px;
}

.checkList .header {
	padding-top: 10px;
}

.checkList .check-item {
	padding-top: 10px;
}

/* Remove margins and padding from the list */
ul {
	margin: 0;
	padding: 0;
}

/* Style the list items */
ul li {
	cursor: pointer;
	position: relative;
	padding: 12px 8px 12px 40px;
	list-style-type: none;
	transition: 0.2s;
	border-radius: 5px;
	border: none;
	/* make the list items unselectable */
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

/* Darker background-color on hover */
ul li:hover {
	background: #e6e6e6;
}

/* When clicked on, add a background color and strike out text */
ul li.checked {
	background: #b3d9ff;
	color: #fff;
	text-decoration: line-through;
}

/* Add a "checked" mark when clicked on */
ul li.checked::before {
	content: '';
	position: absolute;
	border-color: #fff;
	border-style: solid;
	border-width: 0 2px 2px 0;
	top: 10px;
	left: 16px;
	transform: rotate(45deg);
	height: 15px;
	width: 7px;
}

/* Style the close button */
.close {
	position: absolute;
	right: 0;
	top: 0;
	padding: 12px 16px 12px 16px;
}

.close:hover {
	background-color: #f44336;
	color: white;
}

/* Clear floats after the header */
.header:after {
	content: "";
	display: table;
	clear: both;
}

/* Style the input */
.date-input {
    border-radius: 0;
    width: 150px;
    height: 40;
    float: left;
    padding-left: 5px;
}

/* Style the "Add" button */
.addBtn {
	padding: 10px;
	width: 25%;
	background: #d9d9d9;
	color: #555;
	float: left;
	text-align: center;
	/* font-size: 16px; */
	cursor: pointer;
	transition: 0.3s;
	border-radius: 0;
}

.addBtn:hover {
	background-color: #bbb;
}

/* 체크박스 (날짜) */
.dueDateContainer {
	display: block;
	position: relative;
	margin-bottom: 12px;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border-radius: 5px;
	padding: 5px;
}

/* Hide the browser's default checkbox */
.dueDateContainer input {
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: 0;
	left: 0;
	height: 20px;
	width: 20px;
	background-color: #ffffff;
	margin-top: 5px;
	margin-left: 5px;
}

/* On mouse-over, add a grey background color */
.dueDateContainer:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.dueDateContainer input:checked ~ .checkmark {
	background-color: #b3d9ff;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.dueDateContainer input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.dueDateContainer .checkmark:after {
	left: 6px;
	top: 2px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}

.card-name-div {
	display: 'none';
	width: 400px;
	height: 35px;
	border: 0px;
}

.btn {
	background-color: silver;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	width: 100%;
	height: 36px;
	margin-top: 10px;
	opacity: 0.8;
}

.btn:hover {
	background-color: #16a5f7;
}

#getCardName {
	padding-top: 4px;
	width: 400px;
	height: 35px;
}

#checkcon {
	background-color: #e6e6e6;
	height: 30px;
	padding: 5px;
	border-radius: 5px;
	text-align: center;
	width: 200px;
	margin-left: 170px;
}

</style>



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../js/ajax.js"></script>



<script>
	// 카드 입력창 보이게
	function showCardNameInput() {
		// 숨기고 
		document.getElementById('card-name-label').style.display = 'none';
		// 입력창 보이게
		document.getElementById('card-name-div').style.display = '';
		document.getElementById('card-name-Input').focus();
	}

	// 카드 입력창 닫고, 레이블 보이게 처리
	function closeCardNameInput(card_id) {
		console.log(document.getElementById('card-name-Input').value);
		if(document.getElementById('card-name-Input').value == ''){
			alert('제목 입력해주세요');
			return;
		}
		// 입력창 안보이게
		document.getElementById('card-name-div').style.display = 'none';
		// 레이블 보이게하고 값 전달		
		document.getElementById('card-name-label').style.display = '';
		document.getElementById('card-name-label').innerHTML = document
				.getElementById('card-name-Input').value;
		updateCardName(card_id)
	}

	function updateCardName(card_id) {
		var params = "card_name="
				+ document.getElementById('card-name-Input').value + "&"
				+ "card_id=" + card_id
		new ajax.xhr.Request('/dbal/ajax/updateCardName.do', params,
				updateResult, 'POST');
	}

	function updateResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var card = JSON.parse(req.responseText);
				window.parent.document.getElementById("cn-" + card.card_id).innerHTML = card.card_name;

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	function updateCardDate(card_id) {

		var params = "due_date=" + document.getElementById('inputDate').value
				+ "&" + "card_id=" + card_id;

		new ajax.xhr.Request('/dbal/ajax/updateCardDate.do', params,
				updatedCardDate, 'POST');
	}

	function updatedCardDate(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				var card = JSON.parse(req.responseText);
				document.getElementById('setDate').innerHTML = card.due_date;

				window.parent.document.getElementById("d-" + card.card_id).innerHTML = card.due_date;
				window.parent.document.getElementById("cali-${cardInfo.card_id}").style.visibility = 'visible';
			
				var card = JSON.parse(req.responseText);
				document.getElementById('setDate').innerHTML = card.due_date;

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	function checkedDate(card_id) {
		var done;
		if (document.getElementById('checkDate').checked == true) {
			done = 'T';
		} else {
			done = 'F';
		}

		var params = "done=" + done + "&" + "card_id=" + card_id;

		new ajax.xhr.Request('/dbal/ajax/updateCardDateCheck.do', params,
				updatedCardCheck, 'POST');

	}

	function updatedCardCheck(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var card = JSON.parse(req.responseText);
				if (card.done == 'T') {
					/* document.getElementById('checkcon').style.backgroundColor = "#b3d9ff";
					window.parent.document.getElementById("d-" + card.card_id).style.backgroundColor = "#b3d9ff"; */
					window.parent.document.getElementById("d-" + card.card_id).className = "cardback";
					
				} else {
					/* document.getElementById('checkcon').style.backgroundColor = "#e6e6e6";
					window.parent.document.getElementById("d-" + card.card_id).style.backgroundColor = "#ffffff"; */
					
					window.parent.document.getElementById("d-" + card.card_id).className = "";
				}

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	function updateDescription(card_id) {

		var params = "description="
				+ document.getElementById('description').value + "&"
				+ "card_id=" + card_id;
		new ajax.xhr.Request('/dbal/ajax/updateCardDescription.do', params,
				updatedDescription, 'POST');
	}

	function updatedDescription(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var card = JSON.parse(req.responseText);

				document.getElementById('description').innerHTML = card.description;
				alert('수정이 완료되었습니다');

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	// 카드 상세화면 닫기
	function closeCardDetail() {
		parent.document.getElementById("cardDetailFrame").style.display = 'none';
		parent.document.getElementById("cardDetailFrame").src = '';
	}

	function deleteCard(card_id) {
		console.log("deleteCard()");

		// DB 처리
		var params = "card_id=" + card_id;
		new ajax.xhr.Request('../ajax/deleteCard.do', params, deleteCardResult,
				'POST');
	}

	function deleteCardResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				console.log("결과 응답 완료");
				var resultData = JSON.parse(req.responseText);

				// 데이터 처리가 완료되면 카드 삭제
				if (resultData.result == true) {
					// 상세 화면 닫고
					closeCardDetail();
					// 리스트 목록에서 해당 카드 요소 삭제
					parent.$("#c-" + resultData.card_id).remove();
				} else {
					alert("카드 삭제 실패 했습니다.");
				}
			}
		}
	}

	window.onload = function() {
		// 체크 여부 확인
		if (document.getElementById('checkDate').value == 'T') {
			document.getElementById("checkDate").checked = true;
			/* document.getElementById('checkcon').style.backgroundColor = "#b3d9ff"; */
			window.parent.document.getElementById("d-" + card.card_id).className = "cardback";
		}
	}
</script>

<div class="window">
	<div class="card-container">
		<img align="right" src="../images/cancel.png"
			onclick="closeCardDetail()"
			style="width: 30px; height: 30px; cursor: pointer;">
		<!-- 카드 이름 타이틀 -->
		<div class="card-name">
			<div id="card-name-label" onclick="showCardNameInput()">${cardInfo.card_name}</div>
			<div class="card-name-div" id="card-name-div" style="display: none">
				<input id="card-name-Input" type="text"
					value="${cardInfo.card_name}"
					onblur="closeCardNameInput('${cardInfo.card_id}'); ">
			</div>
		</div>

		<!-- 완료 날짜 -->
		<div class="dueDate">
			<div>
				<img src="../images/calendar.png" width="20" height="20"> <span
					class="title">DUE DATE</span>
			</div>
			<div style="display: inline-block;">
				<input id="inputDate" class="date-input" type="date" onblur="updateCardDate('${cardInfo.card_id}')">
				<div id="checkcon" >
					<label class="dueDateContainer"> <span id="setDate">${cardInfo.due_date}</span>
						<input type="checkbox" id="checkDate"
						onclick="checkedDate('${cardInfo.card_id}')"
						value="${cardInfo.done }"> <span class="checkmark"></span>
					</label>
				</div>
			</div>
		</div>


		<!-- Description -->
		<div class="description">
			<div>
				<img src="../images/description.png" width="20" height="20"> <span
					class="title">Description</span>
			</div>

			<textarea id="description" class="description">${cardInfo.description} </textarea>
			<button type="button" class="btn" style="width: 100px;"
				onclick="updateDescription('${cardInfo.card_id}')">Save</button>
		</div>

		<!-- CheckList -->
		<div class="checkList">
			<div>
				<img src="../images/to-do-list.png" width="20" height="20"> <span
					class="title">TO-DO LIST</span>
			</div>

			<div class="header">
				<input type="text" id="itemInput" placeholder="Add an item.."
					style="width: 70%; height: 36px; padding-left: 5px;">
				<button type="button" class="btn" style="width: 13%"
					onclick="addCheckItem()">Add</button>
				<button type="button" class="btn" style="width: 13%">Delete</button>
			</div>

			<ul id="checkList" class="check-item">
				<c:forEach items="${cardInfo.check_list}" var="checkItem">
					<li id="item-${checkItem.item_id}" class="${checkItem.checked}" >${checkItem.item_name}</li>
				</c:forEach>
			</ul>
		</div>

		<hr>

		<!-- Comments -->
		<div>
			<button type="button" class="btn"
				onclick="deleteCard('${cardInfo.card_id}')">Delete</button>
		</div>
	</div>
</div>


<script>
	// 상세화면 띄운 뒤에 처리하는 내용

	// 1. 불러온 리스트에 close 버튼 생성
	var myNodelist = document.getElementsByTagName("LI");
	var i;
	for (i = 0; i < myNodelist.length; i++) {
		var span = document.createElement("SPAN");
		var txt = document.createTextNode("\u00D7");
		span.className = "close";
		span.appendChild(txt);
		myNodelist[i].appendChild(span);
	}

	// 2. 아이템 삭제 버튼 누를 때 처리
	var close = document.getElementsByClassName("close");
	var i;
	for (i = 0; i < close.length; i++) {
		close[i].onclick = deleteCheckItem;
	}

	// 3. 아이템 체크 할 때 처리
	var list = document.querySelector('ul');
	list.addEventListener('click', function(ev) {
		if (ev.target.tagName === 'LI') {

			// 클릭 된 li의 체크아이템 id 획득
			var item_id = ev.target.id.split('-')[1];
			console.log("선택된 체크 아이템: " + item_id);
			ev.target.classList.toggle('checked');
			updateCheckItem(item_id, ev.target.className);
			/* window.parent.document.getElementById("d-" + card.card_id). = 
				"#b3d9ff"; */
		}
	}, false);

	// 새로운 체크아이템 생성 처리
	function addCheckItem() {

		var item_name = $("#itemInput").val();
		if (!item_name)
			return;

		// 체크리스트 ID값 가져오기
		var check_id = "${cardInfo.check_id}";
		var card_id = "${cardInfo.card_id}";
		console.log("카드ID: " + card_id + "체크 리스트ID: " + check_id);

		// DB 처리
		var params = "item_name=" + encodeURIComponent(item_name)
				+ "&check_id=" + check_id + "&card_id=" + card_id;
		new ajax.xhr.Request('../ajax/insertCheckItem.do', params,
				addCheckItemResult, 'POST');
	}

	// 체크아이템 등록 콜백함수
	function addCheckItemResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				var checkItemData = JSON.parse(req.responseText);
				console.log(checkItemData);

				// 데이터 정상 처리 되면
				if (checkItemData.result == true) {
					// 입력 초기화
					document.getElementById("itemInput").value = "";

					// Element 생성
					var li = document.createElement("li");
					var t = document.createTextNode(checkItemData.item_name);
					li.setAttribute("id", "item-" + checkItemData.item_id);
					li.appendChild(t);
					document.getElementById("checkList").appendChild(li);

					// close 버튼 추가
					var span = document.createElement("SPAN");
					var txt = document.createTextNode("\u00D7");
					span.className = "close";
					span.appendChild(txt);
					li.appendChild(span);

					for (i = 0; i < close.length; i++) {
						close[i].onclick = deleteCheckItem; 
					}
					
					printCheckUI();
					
				}
			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	// 체크아이템 업데이트 처리
	function updateCheckItem(item_id, checked) {

		console.log("updateCheckItem()");

		// 체크리스트 ID값 가져오기
		console.log("체크 아이템ID: " + item_id + ", 체크 유무: " + checked);

		// DB 처리
		var params = "item_id=" + item_id + "&checked=" + checked;
		new ajax.xhr.Request('../ajax/updateCheckItem.do', params,
				updateCheckItemResult, 'POST');
	}

	// 체크아이템 업데이트 콜백함수
	function updateCheckItemResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				console.log("결과 응답 완료");
				var checkItemData = JSON.parse(req.responseText);

				// 데이터 처리가 완료되지 않으면 해당 체크를 원래대로 돌린다
				if (checkItemData.result == false) {
					$("#item-" + checkItemData.item_id).toggleClass("checked");
				}
				
				printCheckUI();
			}
		}
	}

	// 체크아이템 삭제 처리
	function deleteCheckItem(item_id) {

		console.log("deleteCheckItem()");
		console.log($(event.target).parent().attr("id"));
		
		var item_id = $(event.target).parent().attr("id").split('-')[1];
		
		// 체크리스트 ID값 가져오기
		console.log("체크 아이템ID: " + item_id);

		// DB 처리
		var params = "item_id=" + item_id;
		new ajax.xhr.Request('../ajax/deleteCheckItem.do', params,
				deleteCheckItemResult, 'POST');
	}

	// 체크아이템 삭제 콜백함수
	function deleteCheckItemResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {

				console.log("결과 응답 완료");
				var checkItemData = JSON.parse(req.responseText);

				// 데이터 처리가 완료되면 요소 삭제
				if (checkItemData.result == true) {
					$("#item-" + checkItemData.item_id).remove();
				}
				
				printCheckUI();
			}
		}
	}
	
	function printCheckUI() {
		
		var total = $(".check-item").children().length;
		var checked = $(".checked").length;
		
		if(total == 0) {
			window.parent.document.getElementById("chi-${cardInfo.card_id}").style.visibility = 'hidden';
			window.parent.document.getElementById("ch-${cardInfo.card_id}").innerHTML = ' ';
		} else {
			window.parent.document.getElementById("chi-${cardInfo.card_id}").style.visibility = 'visible';
			window.parent.document.getElementById("ch-${cardInfo.card_id}").innerHTML = checked + "/" + total;
		}
	}
	
</script>

