<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>댓글</title>
<style>
.comment {
	border: 1px dotted blue;
}
</style>
<script src="../js/ajax.js"></script>
<script>
	window.onload = function() {
		loadCommentList(); // 목록조회 ajax 요청
	}
	//목록조회 요청
	function loadCommentList() {
		var param = "cmd=selectAll";
		new ajax.xhr.Request("CommentJsonServ", param, loadCommentResult, 'GET');
	}
	
	//목록조회 콜백함수
	function loadCommentResult(req) {
		if (req.readyState == 4) { //응답이 완료
			if (req.status == 200) { //정상실행  
				// data 태그의 태그바디값(string)을  json 객체로 변환 
				var commentList = JSON.parse(req.responseText);
				var listDiv = document.getElementById('commentList');
				for (var i = 0; i < commentList.length; i++) {
					// 댓글div 태그생성
					var commentDiv = makeCommentView(commentList[i]);
					// div목록에 댓글div 추가
					listDiv.appendChild(commentDiv);
				}
			} else {
				alert("댓글 목록 로딩 실패:" + req.status);
			} //에러인 경우 상태코드 출력
		}
	}

	function makeCommentView(comment) {
		var div = document.createElement("div");
		div.setAttribute("id", "c" + comment.id);
		div.className = 'comment';
		// div에 comment라는 속성은 없지만, 사용자가 추가할 수 있다
		// <div comment="{댓글한개}">
		div.comment = comment;

		var str = "<strong>"
				+ comment.name
				+ "</strong>"
				+ comment.content
				+ "<input type=\"button\" value=\"수정\" onclick=\"viewUpdateForm('"
				+ comment.id
				+ "')\"/>"
				+ "<input type=\"button\" value=\"삭제\" onclick=\"confirmDeletion('"
				+ comment.id + "')\"/>"
		div.innerHTML = str;
		return div;
	}

	//댓글 등록 ajax 요청
	function addComment() {
		var name = document.addForm.name.value;
		var content = document.addForm.content.value;
		var params = "name=" + encodeURIComponent(name) + "&" + "content="
				+ encodeURIComponent(content) + "&cmd=insert";
		new ajax.xhr.Request('CommentJsonServ', params, addResult, 'POST');
	}
	
	// 댓글 등록 콜백함수
	function addResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var comment = JSON.parse(req.responseText);
				var listDiv = document.getElementById('commentList');
				var commentDiv = makeCommentView(comment);
				
				listDiv.appendChild(commentDiv);
				//등록폼 텍스트필드 클리어
				document.addForm.name.value = '';
				document.addForm.content.value = '';
				alert("등록했습니다![" + comment.id + "]");
			
			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	//수정버튼 이벤트핸들러: 수정할 댓글밑에 수정폼 보이게 함
	function viewUpdateForm(commentId) {
		var commentDiv = document.getElementById('c' + commentId);
		var updateFormDiv = document.getElementById('commentUpdate');
		//현재 수정상태(수정폼이 보이고 있음)이면 수정폼이 보이게 할 필요 없음
		if (updateFormDiv.parentNode != commentDiv) {
			// appendChild() 하면 이동할 수 있음
			commentDiv.appendChild(updateFormDiv); //수정폼을 수정할 댓글밑에 보이도록
		}
		//수정할 값을 텍스트필드에 보이게
		var comment = commentDiv.comment; //댓글 객체 { id:'', content:'', name:'' }
		document.updateForm.id.value = comment.id;
		document.updateForm.name.value = comment.name;
		document.updateForm.content.value = comment.content;
		updateFormDiv.style.display = ''; //수정폼 보이게
	}

	//댓글 수정 ajax 요청
	function updateComment() {
		var id = document.updateForm.id.value;
		var name = document.updateForm.name.value;
		var content = document.updateForm.content.value;
		var params = "id=" + id + "&" + "name=" + encodeURIComponent(name)
				+ "&" + "content=" + encodeURIComponent(content)
				+ "&cmd=update";
		new ajax.xhr.Request('CommentJsonServ', params, updateResult, 'POST');
	}
	
	// 댓글 수정 콜백함수
	function updateResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var comment = JSON.parse(req.responseText);
				var listDiv = document.getElementById('commentList');

				// 새로 만든 태그
				var commentDiv = makeCommentView(comment);
				// 기존 태그
				var oldCommentDiv = document.getElementById('c' + comment.id);
				
				// 수정폼을 body에 연결
				cancelUpdate();

				// 새 DIV와 기존의 DIV를 교체
				listDiv.replaceChild(commentDiv, oldCommentDiv);
				alert("수정했습니다!");

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	// 댓글 삭제 ajax 요청
	function confirmDeletion(id) {
		var params = "id=" + id + "&cmd=delete";
		new ajax.xhr.Request('CommentJsonServ', params, deleteResult, 'POST');
	}
	
	// 댓글 삭제 콜백함수
	function deleteResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var comment = JSON.parse(req.responseText);
				var listDiv = document.getElementById('commentList');
				var commentDiv = document.getElementById('c' + comment.id);
				commentDiv.parentNode.removeChild(commentDiv);
				alert("삭제했습니다!");

			} else {
				alert("서버 에러 발생: " + req.status);
			}
		}
	}

	// 취소
	function cancelUpdate() {
		// 수정폼을 안보이게
		// 수정폼을 body태그로 이동
		var updateFormDiv = document.getElementById('commentUpdate');
		document.body.appendChild(updateFormDiv);
		updateFormDiv.style.display = "none"; // 안보이게
	}
</script>
</head>
<body>
	<div id="commentList"></div>

	<!-- 댓글등록시작 -->
	<div id="commentAdd">
		<form action="" name="addForm">
			이름: <input type="text" name="name" size="10"><br /> 내용:
			<textarea name="content" cols="20" rows="2"></textarea>
			<br /> 
			<input type="button" value="등록" onclick="addComment()" />
		</form>
	</div>
	<!-- 댓글등록끝 -->

	<!-- 댓글수정폼시작 -->
	<div id="commentUpdate" style="display: none">
		<form action="" name="updateForm">
			<input type="hidden" name="id" value="" /> 이름: <input type="text"
				name="name" size="10"><br /> 내용:
			<textarea name="content" cols="20" rows="2"></textarea>
			<br /> <input type="button" value="등록" onclick="updateComment()" />
			<input type="button" value="취소" onclick="cancelUpdate()" />
		</form>
	</div>
	<!-- 댓글수정폼끝 -->
</body>
</html>






