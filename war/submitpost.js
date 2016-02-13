function submitPost(){
	var title = document.getElementById("title").value;
	var content = document.getElementById("content").value;
	
	document.getElementById("post-title").value = title;
	document.getElementById("post-content").value = content;
	
	document.getElementById("post-form").submit();
}