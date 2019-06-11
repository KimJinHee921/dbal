<%@page import="com.dbal.dao.TeamDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="../js/ajax.js"></script>
<style>
.wrap {
	margin-top: 30px;
}

<!-- /* 네이게이션바 */
.sidebar {
	/*  height: 100%; */
	width: 160px;
	/*  position: sticky; */
	z-index: 1;
	top: 80px;
	left: 0%;
	overflow-x: hidden;
	padding-top: 16px;
}

.sidebar a {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 1.3em;
	color: #818181;
	display: block;
}

.sidebar a:hover {
	color: #2196F3;
	/* background-color: yellow; */
}

/*네비게이션 바 끝  */

/* 왼쪽  */
.absolute {
	width: 160px;
	float: left;
}

.left {
	width: 30px;
	float: left;
}

.left2 {
	width: 80%;
	float: left;
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
	display: none;
	padding-top: 80px;
}

.buttonA {
	background-color: #e6e6e6;
	border-radius: 3px;
	border: none;
	color: white;
	padding: 33px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px 2px;
	width: 200px;
	height: 100px;
	cursor: pointer;
	background-image: url(../images/a.jpg);
}

.buttonB {
	background-color: #e6e6e6;
	border-radius: 3px;
	border: none;
	color: white;
	padding: 33px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px 2px;
	width: 200px;
	height: 100px;
	cursor: pointer;
	background-image: url(../images/b.jpg);
}

.btnwrap {
	display: inline-block;
}

@media screen and (max-width: 800px) {
	div {
		width: 99%;
	}
	.mainnav {
		display: none;
	}
}

#frame {
	margin-top: 10%;
	width: 80%;
	height: 500px;
	border: 0;
}
-->
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

	function findBoard(team_id) {
		//ajax 요청	//댓글등록참조
		cur_team = team_id;
		var param = "team_id=" + cur_team;
		new ajax.xhr.Request("../ajax/userboard.do", param, findBoardCalback,
				'GET');
		document.getElementById("frame").src = "../member/memberList.do?team_id="
				+ cur_team;
	}

	function findBoardCalback(req) {
		//리턴결과 중에서 first_name, last_name을 span태그에 출력
		if (req.readyState == 4) { //응답이 완료
			if (req.status == 200) { //정상실행  
				//응답결과를 json 객체로 변환
				var board = JSON.parse(req.responseText);
				var listDiv = document.getElementById('boardlist');
				listDiv.innerHTML = "";
				for (i = 0; i < board.length; i++) {
					var boardDiv = makeBoardView(board[i]);
					listDiv.appendChild(boardDiv);
				}

			} else {
				alert("에러");
			}
		}
	}

	function makeBoardView(board, i) {
		var div = document.createElement("div");
		div.setAttribute("board_id", board.board_id);
		div.className = 'btnwrap';
		div.board = board;

		var str = "<a href=\"../board/boardMain.do?board_id=" + board.board_id
				+ "&board_name=" + board.board_name + "\" class=\"buttonA\">"
				+ board.board_name + "</a>"
		div.innerHTML = str;
		return div;
	}

	//댓글 등록 ajax 요청
	function addboard() {
		var boardName = document.boardform.boardName.value;
		var params = "board_name=" + encodeURIComponent(boardName)
				+ "&team_id=" + cur_team;
		console.log(params);
		new ajax.xhr.Request('../ajax/addboard.do', params, addResult, 'POST');
	}

	// 댓글 등록 콜백함수
	function addResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var comment = JSON.parse(req.responseText);
				var listDiv = document.getElementById('boardlist');
				var commentDiv = makeCommentView(comment);

				listDiv.appendChild(commentDiv);

				
				document.getElementById('inviteTeamForm').style.display = 'none';
				document.getElementById('creatboard2').style.display = '';
				document.boardform.boardName.value = '';
				//등록폼 텍스트필드 클리어
			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	function makeCommentView(comment) {
		var div = document.createElement("span");
		div.className = 'comment';

		var str ='<a href=\"../board/boardMain.do?board_id=' + comment.board_id
		+ '&board_name='+  comment.board_name + '\" class=\"buttonA\">'
		+  comment.board_name + '</a>';
		
		
		/* '	<a href="#" class="button"><b>' + comment.board_name
				+ '</b></a> '; */
			

		div.innerHTML = str;

		return div;
	}

	window.onload = function() {
		// 화면 로드 시 첫번째 팀의 보드 조회
		findBoard('${team_list[0].team_id}');
		document.getElementById('${team_list[0].team_id}').style.backgroundColor="#cfe8fc";
		
		$("#navcon a").not(":last").on("click",function(e) {
			$("#navcon a").css ({
				"background-color" : "#fff"
			});
			
		$(this).css({
			"background-color" : "#cfe8fc" ,
			"border-radius" : "5px"
			});
		});
		
	}
</script>
<div class="wrap">
	<nav class="mainnav">
		<div class="sidebar absolute" id="navcon">
			Teams
			<c:forEach items="${team_list}" var="team">
				<a href="javascript:findBoard('${team.team_id }')"
					id="${team.team_id }" class="nav1"> ${team.team_name } </a>
			</c:forEach>
			<a
				href='javascript:window.open("../popup/createTeam.jsp","popup","width=332px,height=375px,left=200,top=200");'><i
				class="fa fa-fw fa-envelope"></i> + Create a team</a>

		</div>
	</nav>
	<div class="left">
		<p></p>
	</div>

	<div class="left2" id="subject">
		<div>
			<p>your team board</p>

			<div id="boardlist" class="btnwrap"></div>

			<span id="creatboard"> 
			<a href="#" class="buttonB" id="creatboard2"
				onclick="document.getElementById('inviteTeamForm').style.display='inline'; this.style.display='none';">
				<b>create new board</b></a>
			</span>

			<div id="testA" class="">
				<%@include file="../popup/createBoards.jsp"%>
			</div>
		</div>
		<!-- 회원 목록 조회 -->
		<div>
			<iframe id="frame" src=""></iframe>
		</div>
	</div>
</div>
