<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<link rel="stylesheet" href="../css/buttons.css">
<style>
.invitecon {
	width: 420px;
	height: 540px;
	padding: 2px;
	border: 1px solid black;
	border-radius: 3%;
}

.notificon {
	width: 400px;
	height:40px;
	/* margin:auto; */ 
	text-align: center;
	border-bottom: 1px solid #e6e6e6;
	margin: auto;
	padding-top: 10px;
	
}

.viewall {
	padding: 8px 16px 0 12px;
	width: 380px;
}

.notifilist {
	position: relative;
	width: 420px;
	margin: 8px -12px 0;
	padding: 0 12px;
	min-height: 285px;
	
}

.notifilist img {
	display: block;
	margin-bottom: 32px;
}

.nlistcon {
	position: absolute;
	text-align: center;
	bottom: 16px;
	margin: auto;
	margin-left: 30%;
}

.notifitext{
	text-align: center;
}

.notiimg {
	margin-left: 30px;
}

.notififont {
	font-size:20px;
}
</style>
<div class="invitecon">
	<div class="notificon">
	<img class="close" align="right" src="../images/cancel.png"  onclick="alert('close')">
	<div class="notififont">Notification</div>
	</div>
	
	<div class="viewall">
		<a href="#"><u>View All</u></a>
	</div>
	<div class="notifilist">
		<div class="nlistcon">
			<div class="notiimg">
			<img src="../images/notification2.png">
			</div>
			<div class="notifitext">
			 No Unread Notifications
			</div>
		</div>
		<div class="notifitext">
		
		</div>
	</div>
</div>
