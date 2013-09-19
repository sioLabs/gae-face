//code to execute on page load
$(document).ready(function(){
		
});

var email="";
//gmail helper code
var name="";
//////////helper code////////////////
var helper = (function() {
//var BASE_API_PATH = 'plus/v1/';


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
        	  
        	  console.log('email : '+email);
              //$('#authOps').show('slow');
              $('#signIn').hide();
              $('#signInData').hide();
              //$('#signinButton').hide();
              helper.profile();

                  
          
          } 
          else if (authResult['error']) {
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
          name = profile.displayName;
          

//          $('#profile').append(
//                  $('<p><img src=\"' + profile.image.url + '\"></p>'));
//          //$('#profile').append(
//            //      $('<p>Hello ' + profile.displayName + '<br />About: ' + profile.aboutMe + '</p>'));
//          
//          
//          if(profile.gender){
//          	$('#profile').append(
//          		$('<p> Gender :'+ profile.gender +'</p><br/>'))	;	
//          	
//          	
//          }
//          if (profile.cover && profile.coverPhoto) {
//              $('#profile').append(
//                      $('<p><img src=\"' + profile.cover.coverPhoto.url + '\"></p>'));
//          }
      });
  }
};
})();
/////////////////////////////////////



//gmail sign in function
function signinCallback(authResult) {
	
	helper.onSignInCallback(authResult);
}

/*
data functions

*/
function getEmail() {
// Load the oauth2 libraries to enable the userinfo methods.
	console.log('insied email');
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
//var el = document.getElementById('email');
//var email = '';

if (obj['email']) {
	email = obj['email'];
	console.log(email + ' ' +name);
    
    $.ajax({
  	 type:'POST',
       url : '/login',
       data :{
    	   	 'email':email,
    		 'method':'2',
    		 'name' : name                	 
       },
       async:false
       
    });
    location.reload();
  //  email = 'Email: ' + obj['email'];
}

//console.log(obj);
///el.innerHTML = email;
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