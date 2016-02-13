function onSubscribeClick(){
	$.post("/subscribe",
		    {},
		    function(data, status){
		        location.reload();
		    });
}

function onUnsubscribeClick(){
	console.log("clicked");
	$.post("/unsubscribe",
		    {},
		    function(data, status){
		    	location.reload();
		    });
}

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}