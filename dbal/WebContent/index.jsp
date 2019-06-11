<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<title>D:BAL</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
.w3-bar,h1,button {font-family: "Montserrat", sans-serif}
.fa-anchor,.fa-coffee {font-size:200px}
</style>
<body>

<!-- Header -->
<header class="w3-container w3-blue w3-center" style="padding:128px 16px">
  <h1 class="w3-margin w3-jumbo">Welcome to D:BAL</h1>
  <button class="w3-button w3-white w3-padding-large w3-large w3-margin-top" onclick="location='member/login.jsp'">Login</button>
  &emsp;
  <button class="w3-button w3-white w3-padding-large w3-large w3-margin-top" onclick="location='member/create.jsp'">Join</button>
</header>

<!-- First Grid -->
<div class="w3-row-padding w3-padding-64 w3-container">
  <div class="w3-content">
    <div class="w3-twothird">
      <h1>Work with any team</h1>
      <h5 class="w3-padding-32">
            직장에서의 업무, 학교의 조별 과제 혹은 당신의 다음 가족 휴가 계획까지! <br>
            무엇이든 가능합니다. <br> 
            당신의 팀을 만들고 함께할 팀원들을 초대해보세요.
      </h5>
    </div>

    <div class="w3-third w3-center">
     <img src="./images/index1.png" class="w3-round-large" alt="index1">
    </div>
  </div>
</div>

<!-- Second Grid -->
<div class="w3-row-padding w3-light-grey w3-padding-64 w3-container">
  <div class="w3-content">
    <div class="w3-third w3-center">
     <img src="./images/index2.png" class="w3-round-large" alt="index2">
    </div>

    <div class="w3-twothird">
       <h1>&emsp;&emsp;&emsp; Information at a glance</h1>
      <h5 class="w3-padding-32">
 &emsp;&emsp;&emsp; 주제별로 카드를 만들어 TO Do List를 작성해보세요. <br> 
 &emsp;&emsp;&emsp; 한눈에 업무의 흐름을 확인하고 효율적인 처리를 할 수 있습니다. <br> 
 &emsp;&emsp;&emsp; D:BAL이 제공하는 다양한 기능들을 즐겨보세요!
      </h5>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="w3-container w3-padding-64 w3-center w3-opacity">  
  <p>Powered by Yumi's Cells</p>
</footer>

<script>
// Used to toggle the menu on small screens when clicking on the menu button
function myFunction() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</body>
</html>
