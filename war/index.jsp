<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.net.URLEncoder"%>

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

<%
	//Write the check signin code here
	//First check from where it came. 
	//String token   = (String)request.getAttribute("token");
%>
</head>


<body>



	<%
		String fbURL = "http://www.facebook.com/dialog/oauth?client_id=215797211910886&redirect_uri="
				+ URLEncoder
						.encode("http://gae-face.appspot.com/gae_face&login=1")
				+ "&scope=email";
	%>

	<a href="<%=fbURL%>">Login with facebook</a>

	<br />
	<span id="signinButton"> <span class="g-signin"
		data-callback="signinCallback"
		data-clientid="327515160261.apps.googleusercontent.com"
		data-cookiepolicy="single_host_origin"
		data-requestvisibleactions="http://schemas.google.com/AddActivity"
		data-scope="https://www.googleapis.com/auth/plus.login"> </span>
	</span>

	<script>
		function httpGet(theUrl) {
			var xmlHttp = null;

			xmlHttp = new XMLHttpRequest();
			xmlHttp.open("GET", theUrl, false);
			xmlHttp.send(null);
			return xmlHttp.responseText;
		}
		function signinCallback(authResult) {

			if (authResult['access_token']) {
				// Successfully authorized // Hide the sign-in button now that theuser is authorized, for example:
				var data = httpGet("https://www.googleapis.com/plus/v1/people/me");
				alert(data);

				document.getElementById('signinButton').setAttribute('style',
						'display:none');
			} else if (authResult['error']) { // There was an error. //	Possible error codes: // "access_denied" - User denied access to your	app // "immediate_failed" - Could not automatically log in the user //
				//console.log('There was an error: ' + authResult['error']);

			}
		}
	</script>

</body>
</html>