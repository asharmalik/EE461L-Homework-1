function onSubscribeClick(){
	$.post("/subscribe",
		    {},
		    function(data, status){
		    	alert("Thank you for subscribing! Look out for daily emails from us.");
		        location.reload();
		    });
}

function onUnsubscribeClick(){
	console.log("clicked");
	$.post("/unsubscribe",
		    {},
		    function(data, status){
		    	alert("Sorry to see you go. Re-subscribe any time!");
		    	location.reload();
		    });
}

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}