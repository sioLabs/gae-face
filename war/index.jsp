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
<script src="http://code.jquery.com/jquery-1.9.0.min.js"
	type="text/javascript"></script>
<script src="https://apis.google.com/js/plusone.js"
	type="text/javascript"></script>

<%
	//Write the check signin code here
	//First check from where it came. 
	//String token   = (String)request.getAttribute("token");
%>
</head>


<body>



	<%
		String fbURL = "http://www.facebook.com/dialog/oauth?client_id=215797211910886&redirect_uri="
				+ URLEncoder.encode("http://gae-face.appspot.com/gae_face")
				+ "&scope=email";
	%>

	<a href="<%=fbURL%>">Login with facebook</a>

	<br />
	<span id="signinButton"> <span class="g-signin"
		data-callback="signinCallback"
		data-clientid="327515160261.apps.googleusercontent.com"
		data-cookiepolicy="single_host_origin"
		data-requestvisibleactions="http://schemas.google.com/AddActivity"
		data-approvalprompt="force" data-theme="dark"
		data-scope="https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email">
	</span>
	</span>

	<br />

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


</body>
<script>
		function httpGet(theUrl) {
			var xmlHttp = null;

			xmlHttp = new XMLHttpRequest();
			xmlHttp.open("GET", theUrl, false);
			xmlHttp.send(null);
			return xmlHttp.responseText;
		}
		
		
		//////////helper code////////////////
		          var helper = (function() {
                var BASE_API_PATH = 'plus/v1/';

                return {
                    /**
                     * Hides the sign in button and starts the post-authorization operations.
                     *
                     * @param {Object} authResult An Object which contains the access token and
                     *   other authentication information.
                     */
                    onSignInCallback: function(authResult) {

                        gapi.client.load('plus', 'v1', function() {
                            //$('#authResult').html('Auth Result:<br/>');
                            /*for (var field in authResult) {
                             $('#authResult').append(' ' + field + ': ' +
                             authResult[field] + '<br/>');
                             }*/
                            if (authResult['access_token']) {
                                $('#authOps').show('slow');
                                $('#gConnect').hide();
                                helper.profile();
                                //helper.people();
                            } else if (authResult['error']) {
                                // There was an error, which means the user is not signed in.
                                // As an example, you can handle by writing to the console:
                                console.log('There was an error: ' + authResult['error']);
                                //$('#authResult').append('Logged out');
                                $('#authOps').hide('slow');
                                $('#gConnect').show();
                            }

                            if (authResult) {
                                if (authResult['error'] === undefined) {
                                    gapi.auth.setToken(authResult); // Store the returned token.
                                    getEmail();                     // Trigger request to get the email address.
                                } else {
                                    console.log('An error occurred');
                                }
                            } else {
                                console.log('Empty authResult');  // Something went wrong
                            }
                        });

                    },
                    /**
                     * Calls the OAuth2 endpoint to disconnect the app for the user.
                     */
                    disconnect: function() {
                        // Revoke the access token.
                        $.ajax({
                            type: 'GET',
                            url: 'https://accounts.google.com/o/oauth2/revoke?token=' +
                                    gapi.auth.getToken().access_token,
                            async: false,
                            contentType: 'application/json',
                            dataType: 'jsonp',
                            success: function(result) {
                                console.log('revoke response: ' + result);
                                $('#authOps').hide();
                                $('#profile').empty();
                                $('#gConnect').show();
                            },
                            error: function(e) {
                                console.log(e);
                            }
                        });
                    },
                    /**
                     * Gets and renders the list of people visible to this app.
                     */
                    /*people: function() {
                     var request = gapi.client.plus.people.list({
                     'userId': 'me',
                     'collection': 'visible'
                     });
                     request.execute(function(people) {
                     $('#visiblePeople').empty();
                     $('#visiblePeople').append('Number of people visible to this app: ' +
                     people.totalItems + '<br/>');
                     for (var personIndex in people.items) {
                     person = people.items[personIndex];
                     $('#visiblePeople').append('<img src="' + person.image.url + '">');
                     }
                     });
                     },*/
                    /**
                     * Gets and renders the currently signed in user's profile data.
                     */
                    profile: function() {
                        var request = gapi.client.plus.people.get({'userId': 'me'});


                        request.execute(function(profile) {
                            $('#profile').empty();
                            if (profile.error) {
                                $('#profile').append(profile.error);
                                return;
                            }

                            $('#profile').append(
                                    $('<p><img src=\"' + profile.image.url + '\"></p>'));
                            $('#profile').append(
                                    $('<p>Hello ' + profile.displayName + '<br />About: ' + profile.aboutMe + '</p>'));
                            
                            if(profile.gender){
                            	$('#profile').append(
                            		$('<p> Gender :'+ profile.gender +'</p><br/>'))	;	
                            	
                            	
                            }
                            if (profile.cover && profile.coverPhoto) {
                                $('#profile').append(
                                        $('<p><img src=\"' + profile.cover.coverPhoto.url + '\"></p>'));
                            }
                        });
                    }
                };
            })();
		/////////////////////////////////////
		
		  /**
             * jQuery initialization
             */
            $(document).ready(function() {
                $('#disconnect').click(helper.disconnect);
                if ($('[data-clientid="327515160261.apps.googleusercontent.com"]').length > 0) {
                    alert('This sample requires your OAuth credentials (client ID) ' +
                            'from the Google APIs console:\n' +
                            '    https://code.google.com/apis/console/#:access\n\n' +
                            'Find and replace YOUR_CLIENT_ID with your client ID.'
                            );
                }
            });
		
		
		function signinCallback(authResult) {
				
				helper.onSignInCallback(authResult)
		}
		
		/*
			data functions
			
		*/
		  function getEmail() {
            // Load the oauth2 libraries to enable the userinfo methods.
            gapi.client.load('oauth2', 'v2', function() {
                var request = gapi.client.oauth2.userinfo.get();
                /*
                 * This sentence call to the getEmailCallBack funtion in order to
                 * process the response
                 */
                request.execute(getEmailCallback);
            });
        }

        function getEmailCallback(obj) {
            var el = document.getElementById('email');
            var email = '';

            if (obj['email']) {
                email = 'Email: ' + obj['email'];
            }

            el.innerHTML = email;
            //toggleElement('email');
        }

        function toggleElement(id) {
            var el = document.getElementById(id);

            if (el.getAttribute('class') === 'hide') {
                el.setAttribute('class', 'show');
            } else {
                el.setAttribute('class', 'hide');
            }
        }
        /*
        end data functions
        */
	</script>


</html>