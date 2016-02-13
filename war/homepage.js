function onSubscribeClick(){
	var email = prompt("Please enter your email address.", "");
	
	if(validateEmail(email)){
		console.log("Email is fine");
	}else{
		window.alert("Please enter a correct email.");
	}
}

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}