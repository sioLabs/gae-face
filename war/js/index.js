$(document).ready(function(){
	
	//function to work on design text
	$('.designBtn').click(function(){
		var url = 'resources/Design.jsp';
		$.get(
				url,
				function(responseText){
					$('#mainContent').html(responseText);
				}
		);
		
	});	
		
	$('.priceBtn').click(function(){
		var url = 'resources/Pricing.jsp';
		$.get(
				url,
				function(responseText){
					$('#mainContent').html(responseText);
				}
		);
		
	});	
	
});
	
	
	
	
