<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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
	max-width: 300px;
	padding: 10px;
	background-color: white;
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

<div class="form-popup" id="inviteTeamForm">
	<form action="createTeam.do" class="form-container">
		<img class="close_" align="right" src="../images/cancel.png">
		<h2>Team Name</h2>
		<input type="text" name="team_name" required>
		<button type="submit" class="btn">Create</button>
		<hr>
		<font color="Gray">
		A team is a group of boards and people. Use it to organize your
		company, side hustle, family, or friends. Business Class gives your
		team more security, administrative controls.
		</font>
	</form>
</div>