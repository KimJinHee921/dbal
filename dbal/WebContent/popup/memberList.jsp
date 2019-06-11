<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/inputForm.css">
<style>
body {
	margin: auto;
	font-size: 14px;
}

.invite {
	margin-bottom: 20px;
	text-align: right;
}

.member-list {
	border-top: 1.5px solid #d6dadc;
	clear: both;
	margin-top: 20px;
	display: flex;
	flex-direction: column;
}

.member-item {
	position: relative;
	width: 100%;
	height: 50px;
	border-bottom: 1px solid #bfbfbf;
	display: flex;
}

.member-item .name {
	font-weight: 700;
	font-size: 16px;
	margin-right: 100px;
	padding-top: 10px;
	margin-left: 10px;
}

.member-item .email {
	font-size: 16px;
	margin-right: 50px;
	padding-top: 10px;
}

.member-item .leave {
	position: absolute;
	top: 5px;
	right: 0px;
}

button.btn {
	background-color: silver !important;
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
	background-color: #16a5f7 !important;
}

.btn.active {
	background-color: #666;
	color: white;
}

/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
	background-color: #555;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	opacity: 0.8;
	position: fixed;
	bottom: 23px;
	right: 28px;
	width: 280px;
}

/* The popup form - hidden by default */
.form-popup {
	display: none;
	position: fixed;
	top: 110;
	right: 5px;
	border: 1px solid #f1f1f1;
	background-color: white;
	z-index: 9;
}

/* Add styles to the form container */
.form-container {
	max-width: 300px;
	padding: 10px;
	background-color: white;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
	opacity: 1;
}
</style>

<script src="../js/ajax.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	function openForm() {
		curDisplay = document.getElementById("inviteMemForm").style.display;
		if (curDisplay == "block") {
			document.getElementById("inviteMemForm").style.display = "none";
		} else {
			document.getElementById("inviteMemForm").style.display = "block";
		}
	}

	function deleteUser(member_id) {
		// 확인 메세지
		var result = confirm("사용자를 삭제하시겠습니까?");
		if (result == true) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {

					console.log("결과 응답 완료");
					var resultData = JSON.parse(xhttp.responseText);

					if (resultData.result == true) {
						// 리스트 목록에서 해당 사용자 요소 삭제
						$("#member-item-" + resultData.member_id).remove();
					} else {
						alert("사용자 팀 탈퇴에 실패 했습니다.");
					}
				}
			};
			var param = "?member_id=" + member_id + "&team_id=" + ${param.team_id};
			console.log(param);
			
			xhttp.open("GET", "../ajax/deleteMember.do" + param, true);
			xhttp.send();
		}
	}
	
	function memberInvite() {

		console.log("memberInvite()");
		var member_id = document.memberForm.userId.value;
		if (!member_id)
			return;

		console.log("멤버ID : " + member_id);

		var params = "member_id=" + encodeURIComponent(member_id) + "&team_id="
				+ "${param.team_id}";
		new ajax.xhr.Request('../ajax/memberInvite.do', params, addListResult,
				'POST');
	}

	function addListResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				console.log("멤버 초대 완료");
				var resultData = JSON.parse(req.responseText);

				openForm();
				
				document.memberForm.userId.value = '';

				// 회원 목록 조회
				if (resultData.result == true) {
					$("#member-list").append(makeListElement(resultData));
				} else {
					alert("회원 초대에 실패하였습니다.")
				}
			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	function makeListElement(listData) {

		var div = document.createElement("div");
		div.className = 'member-item';
		div.setAttribute("id", "member-item-" + listData.member_id);

		var str = "<span class=\"name\">" + listData.name + "</span>"
				+ "<span class=\"email\">" + listData.email + "</span>"
				+ "<div class=\"leave\">"
				+ "<button class=\"btn\" onclick=\"deleteUser('"
				+ listData.member_id + "')\">Leave</button>"
				+ "</div>";

		div.innerHTML = str;

		return div;
	}
</script>
</head>
<body>
	<div class="memberList-wrap">
		<div>
			<p>Team Members</p>

			<!-- 회원 초대 -->
			<div class="invite">
				<button type="button" class="btn"
					style="width: 200px; height: 40px;" onclick="openForm()">InviteTeam
					Members</button>
			</div>

			<div class="form-popup" id="inviteMemForm">
				<form name="memberForm" class="form-container">
					<h1>Enter User ID</h1>

					<label for="email"><b>Email</b></label> <input type="text"
						placeholder="Enter user ID" name="userId" required>
					<button type="button" onclick="memberInvite()" class="btn">Invite</button>
				</form>
			</div>
		</div>

		<div class="member-list" id="member-list">
			<c:forEach items="${memberList}" var="member">
				<div class="member-item" id="member-item-${member.member_id}">
					<span class="name">${member.name}</span> <span class="email">${member.email}</span>
					<div class="leave">
						<button class="btn" onclick="deleteUser('${member.member_id}')">Leave</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>


