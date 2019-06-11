<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<head>
<title>DBAL</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<style>
.container {
	font-size: 14px;
}

.main {
	margin-left: 160px; /* Same as the width of the sidenav */
	padding: 0px 10px;
}

.bg-dark {
	background-color: #2196F3 !important;
}

@media screen and (max-height: 450px) {
	.sidebar {
		padding-top: 15px;
	}
	.sidebar a {
		font-size: 18px;
	}
}

.fakeimg {
	height: 200px;
	background: #aaa;
}

.jumbotron {
	padding: 10rem 2rem;
}

.log {
	margin-left: auto;

}

.logout {
	background-color: #2196F3;
	color: white;
	padding: 14px 20px;
	margin: auto;
	border: none;
	cursor: pointer;
	width: 50%;
	opacity: 0.9;
}


.logout:hover {
	opacity: 1;
}


</style>
</head>

<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a href=../main/userHome.do><img src="../images/logo.png"
			width="80" height="30" style="margin: auto;" /></a>
	<div class="log">
	<button type="submit" class="logout" style="border-radius: 1em" onclick="location='../member/logout.do'">Logout</button>
	</div>
	</nav>	

	<div class="container">
		<decorator:body />
	</div>
</body>
</html>