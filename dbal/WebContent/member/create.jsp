<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Sign up</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

<style>

.wrap {
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	padding-top: 60px;
}

.all {
	margin: 5% auto 15% auto;
	/* 5% from the top, 15% from the bottom and centered */
	box-shadow: 0px 0px 20px silver;
	border-radius:2em;
	width: 500px; /* Could be more or less, depending on screen size */
}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 70%;
  padding: 15px;
  margin: auto;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
  margin: auto;
}

hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
  background-color: #16a5f7;
  color: white;
  padding: 14px 20px;
  margin: auto;
  border: none;
  cursor: pointer;
  width: 80%;
  opacity: 0.9;
  text-align:center;
}

button:hover {
  opacity:1;
}


/* Add padding to container elements */
.container {
  padding: 16px;
  background-color: #16a5f7;
  color: white;
  border-top-left-radius:2em;
  border-top-right-radius:2em;
  text-align:center;
 
  
}


.container2 {
  padding: 16px;
  border-radius:2em;
  margin-left:15%;
}


.bottom {
  margin-left:15%;

}

</style>
<script>
	function dupCheck(){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	     document.getElementById("demo").innerHTML = this.responseText;  //dom
	    }
	  };
	  var param = "?member_id=" + frm.member_id.value;
	  xhttp.open("GET", "../member/idcheck.do"+param, false);
	  xhttp.send();		
}	
</script>

<body>
<div class="wrap">
<div class="all">

  <div class="container">
     <h1>Create a D:BAL Account</h1>
  </div>
  <br><br>
  <div class="container2">
  <form action = "create.do" name="frm">
  <div>
    <label for="userid"><b>UserID</b><br></label>
    <input type="text" placeholder="e.g., Harry1991" name="member_id" onkeyup="dupCheck()" required style="border-radius:1em">
    <span id="demo"></span>
    <br><br><br>
  </div>
  <div>
    <label for="email"><b>Email</b><br></label>
    <input type="text" placeholder="e.g., potter@dbal.com" name="email" required style="border-radius:1em">
    <br><br><br>
  </div>
  <div>
    <label for="name"><b>UserName</b><br></label>
    <input type="text" placeholder="e.g., Harry Potter" name="name" required style="border-radius:1em">
    <br><br><br>
  </div>
  <div>
    <label for="psw"><b>Password</b><br></label>
    <input type="password" placeholder="e.g., ••••••••••••" name="passwd" required style="border-radius:1em">
  </div>
    <br><br><br>    
    <div class="clearfix">
      <button type="submit" class="btn" style="border-radius:1em">Create New Account</button>
    </div>
    </form>
    <br><br>
  <div class="bottom">
 	<h5>Already have an account?</h5>
   	  <a href="../member/login.jsp">
   	  <font size="2">
   		Log in now!
   	  </font></a>
  </div>
	<br><br><br><br>  
  </div>
</div>
</div>
</body>
</html>
