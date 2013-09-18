<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.net.URLEncoder, java.util.ArrayList"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Facebook login</title>
<!-- Place this asynchronous JavaScript just before your </body> tag -->
<script type="text/javascript">
	(function() {
		var po = document.createElement('script');
		po.type = 'text/javascript';
		po.async = true;
		po.src = 'https://apis.google.com/js/client:plusone.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(po, s);
	})();
</script>
<script src="http://code.jquery.com/jquery-1.9.0.min.js"type="text/javascript"></script>
<script src="https://apis.google.com/js/plusone.js"	type="text/javascript"></script>


<link rel="stylesheet" href="css/foundation.css" />
<link rel="stylesheet" href="css/webicons.css">

<script src="js/vendor/custom.modernizr.js"></script>


</head>


<body>



	<%
		String fbURL = "http://www.facebook.com/dialog/oauth?client_id=215797211910886&redirect_uri="
				+ URLEncoder.encode("http://gae-face.appspot.com/gae_face")
				+ "&scope=email";
	%>
	
		<nav class="top-bar">
		<ul class="left">
			<li class="name">
				<h1>
				 <a href="#">Fonspiration</a>
				</h1>
			</li>
			<li class="toggle-topbar">
				<a href="#"></a>
			</li>
			
		</ul>
		<section class="top-bar-section">
			<ul class="right">
			
				
				<c:choose>
					<c:when test="${sessionScope.name !=null}">
					<li >		<a id="username" href="#">${sessionScope.name}</a></li>
					</c:when>
					<c:otherwise>
						<li><a id="username" href="#">Welcome</a></li>
					</c:otherwise>
	
				</c:choose>
				</li>
				
		
				<li class="divider"></li>
				<li><a href="#">About Us</a></li>
				<li><a class="designBtn" href="#">Design</a></li>
				<li><a class="priceBtn" href="#">Price</a></li>
				<li><a href="#">Product</a></li>
				<li><a href="#">Winner</a></li>
				<c:if test = "${sessionScope.name ==null}">
				<li id="signIn" class="has-dropdown no-click"><a href="#" data-dropdown="signInData">SignIn</a></li>
				</c:if>
			</ul>
		</section>
	</nav>
  
  	<div id ="signInData" class="f-dropdown content small data-dropdown-content">
  		<a href="<%=fbURL%>" style="padding-bottom:10px;"><img src="img/fb-login.png" width="70%" height="40px" /></a>
  		<hr />
  		<span id="signinButton" style="width:100%; height:57px;"> 
  		<span class="g-signin"
		data-callback="signinCallback"
		data-clientid="327515160261.apps.googleusercontent.com"
		data-cookiepolicy="single_host_origin"
		data-requestvisibleactions="http://schemas.google.com/AddActivity"
		data-approvalprompt="force" data-theme="dark"
		data-scope="https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email"
		data-width="wide"
		>
		</span>
		</span>
		<hr />
		<b>Or login with our account</b> <br/>	
		<input type="text" name="email" placeholder="Enter email" />
		<input type="text" name="pwd" placeholder="Enter passowrd" />
		<input type="button" class="small button" value="Login" />
	</div>
				
  <!-- End Header and Nav -->

	<div id="authOps" style="display: none">
		<h2>User is now signed in to the app using Google+</h2>
		<p>If the user chooses to disconnect, the app must delete all
			stored information retrieved from Google for the given user.</p>
		<button id="disconnect">Disconnect your Google account from
			this app</button>

		<h2>User's profile information</h2>
		<div id="profile"></div>

		<!--<h2>User's friends that are visible to this app</h2>
            <div id="visiblePeople"></div> 

            <h2>Authentication Logs</h2>
            <pre id="authResult"></pre>-->

		<div id="email">Email:</div>
	</div>

	<!-- Scripts  -->
	<script>
  document.write('<script src=' +
  ('__proto__' in {} ? 'js/vendor/zepto' : 'js/vendor/jquery') +
  '.js><\/script>')
  </script>

	<script src="js/foundation.min.js"></script>
	<script src="js/default.js"></script>
	<!--
  
  <script src="js/foundation/foundation.js"></script>
  
  <script src="js/foundation/foundation.interchange.js"></script>
  
  <script src="js/foundation/foundation.dropdown.js"></script>
  
  <script src="js/foundation/foundation.placeholder.js"></script>
  
  <script src="js/foundation/foundation.forms.js"></script>
  
  <script src="js/foundation/foundation.alerts.js"></script>
  
  <script src="js/foundation/foundation.magellan.js"></script>
  
  <script src="js/foundation/foundation.reveal.js"></script>
  
  <script src="js/foundation/foundation.tooltips.js"></script>
  
  <script src="js/foundation/foundation.clearing.js"></script>
  
  <script src="js/foundation/foundation.cookie.js"></script>
  
  <script src="js/foundation/foundation.joyride.js"></script>
  
  <script src="js/foundation/foundation.orbit.js"></script>
  
  <script src="js/foundation/foundation.section.js"></script>
  
  <script src="js/foundation/foundation.topbar.js"></script>
  
  -->

	<script>
    $(document).foundation();
  </script>


</body>


</html>