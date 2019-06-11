<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- createTeam.jsp - 팀 추가 화면 -->

<script src="../js/ajax.js"></script>

<link rel="stylesheet" href="../css/buttons.css">
<link rel="stylesheet" href="../css/inputForm.css">

<!-- createTeam.jsp - 팀 추가 화면 -->

<style>
/* The popup form - hidden by default */
.form-popup {
	/* display: none; */
	position: fixed;
	border: 1px solid #f1f1f1;
	background-color: white;
	z-index: 9;
}

.form-container {
	position: absolute;
	width: 500px;
	left: 50%;
	top: 50%;
	margin-left: -250px;
	margin-top: -250px;
	background: #82713F;
	max-width: 300px;
	padding: 10px;
	justify-content: center;
	background-color: white;
	position: relative;
	font-size: 14px;
}

button.btn {
	background-color: silver!important;
	border: none;
	outline: none;
	padding: 12px 16px;
	cursor: pointer;
	width: 100px;
	font-weight: 700;
	color: white;
	border-radius: 12px;
}	

.btn:hover {
	background-color: #16a5f7!important;	
	
}
</style>
<script>
// 카드 상세화면 닫기
	function closeCardDetail() {
	
		parent.document.getElementById("creatboard2").style.display = '';
		parent.document.getElementById("inviteTeamForm").style.display = 'none';
		document.boardform.boardName.value = '';
	}
</script>

<div class="window-overlay" id="inviteTeamForm">
	<form id="boardform" name="boardform" class="form-container">
		<div class="bord-title">
			<img align="right" src="../images/cancel.png"
				onclick="closeCardDetail()"
				style="width: 30px; height: 30px; cursor: pointer;">

			<!-- close x  -->
			<div class="addBoard" id="teamName">
				<input name="boardName" type="text" placeholder="Add board title"
					required>
				<!-- Add board title -->
			</div>


		</div>

		<button type="button" class="btn" onclick="addboard()">Create
			Board</button>
		<font color="Gray"> </font>
	</form>
</div>


