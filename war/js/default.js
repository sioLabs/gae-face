var email="";
//gmail helper code
var name="";

var method ="";


$('#logout-btn').click(function(){

	$.post("/login", {method:'4'});
	
	$('#signIn').show();
	FB.logout(function(res){
		location.reload();
	});
	location.reload();
	
});
//////FAcebook sdk
//Additional JS functions here
window.fbAsyncInit = function() {
	FB.init({
		appId      : '215797211910886', // App ID
		channelUrl : 'http://gae-face.appspot.com/channel.html', // Channel File
		status     : true, // check login status
		cookie     : true, // enable cookies to allow the server to access the session
		xfbml      : true  // parse XFBML
	});
	$(document).trigger('fbload');
	// Additional init code here

};

//Load the SDK asynchronously
(function(d){
	var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
	if (d.getElementById(id)) {return;}
	js = d.createElement('script'); js.id = id; js.async = true;
	js.src = "//connect.facebook.net/en_US/all.js";
	ref.parentNode.insertBefore(js, ref);
}(document));


$(document).on('fbload', function(){
	FB.getLoginStatus(function(res){

		if(res.status === "connected"){
			getUserDetails();
			$('#signIn').hide();
			$('#signInData').hide();
		}else if(res.status ==='not_authorized'){
			/* user is logged in but not authorized the app*/
			return;
		}else{
			//user is not logged in
			return;
		}
	});
});	

//code to execute on page load
$(document).ready(function(){

	


});

function getUserDetails(){
	return;
	FB.api('/me', function(response){
		
		name = response.first_name +' '+ response.last_name;
		email = response.email;
		//console.log(name + ' ' +email + ' '+method);
		sendLoginInfo(email, name, method);
	});
}

//////////helper code////////////////
var helper = (function() {
//	var BASE_API_PATH = 'plus/v1/';


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
					gapi.auth.setToken(authResult); // Store the returned token.

					////console.log('email : '+email);
					//$('#authOps').show('slow');
					$('#signIn').hide();
					$('#signInData').hide();
					//$('#signinButton').hide();
					helper.profile();



				} 
				else if (authResult['error']) {
					// There was an error, which means the user is not signed in.
					// As an example, you can handle by writing to the //console:
					//console.log('There was an error: ' + authResult['error']);
					//$('#authResult').append('Logged out');
					$('#authOps').hide('slow');
					$('#signIn').show();
				}

				if (authResult) {
					if (authResult['error'] === undefined) {
						gapi.auth.setToken(authResult); // Store the returned token.
						getEmail();                     // Trigger request to get the email address.
					} else {
						//console.log('An error occurred');
					}
				} else {
					//console.log('Empty authResult');  // Something went wrong
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
					//console.log('revoke response: ' + result);
					$('#authOps').hide();
					$('#profile').empty();
					$('#gConnect').show();
				},
				error: function(e) {
					//console.log(e);
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
				name = profile.displayName;
				//console.log('profile ' + name);

//				$('#profile').append(
//				$('<p><img src=\"' + profile.image.url + '\"></p>'));
//				//$('#profile').append(
//				//      $('<p>Hello ' + profile.displayName + '<br />About: ' + profile.aboutMe + '</p>'));


//				if(profile.gender){
//				$('#profile').append(
//				$('<p> Gender :'+ profile.gender +'</p><br/>'))	;	


//				}
//				if (profile.cover && profile.coverPhoto) {
//				$('#profile').append(
//				$('<p><img src=\"' + profile.cover.coverPhoto.url + '\"></p>'));
//				}
			});
		}
	};
})();
/////////////////////////////////////



//gmail sign in function
function signinCallback(authResult) {
	method=2;
	helper.onSignInCallback(authResult);
}

/*
data functions

 */
function getEmail() {
//	Load the oauth2 libraries to enable the userinfo methods.
	//console.log('inside email');
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
//	var el = document.getElementById('email');
//	var email = '';

	if (obj['email']) {
		email = obj['email'];
//		//console.log(email + ' ' +name); 
//		//console.log('to loginInfo');
		method=2;
		sendLoginInfo(email, name, method);
		//  email = 'Email: ' + obj['email'];
	}

//	//console.log(obj);
//	/el.innerHTML = email;
//	toggleElement('email');
}

function sendLoginInfo(email,name,method){
	//console.log('inside sendLoginInfo');
	
	if(method===5){
		return;
	}
	
	$.ajax({
		type:'POST',
		url : '/login',
		data :{
			'email':email,
			'method':method,
			'name' : name                	 
		},
		success:function(){
			location.reload();
		},
		async:false
	});
	
	console.log(name);
	//refresh the page
	//location.reload();

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