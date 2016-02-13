<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	UserService userService = UserServiceFactory.getUserService();
    
User user = userService.getCurrentUser();
    if (user == null){
    	// New location to be redirected
    	String site = new String("/homepage.jsp");
    	response.setStatus(response.SC_MOVED_TEMPORARILY);
    	response.setHeader("Location", site); 
    }
%>

<html>
  <head>
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  	
  	<script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
   	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
  	<script src="submitpost.js"></script>
  </head>
  
  <div class="img-container">
  	<img src="/img/header.jpg" alt="UT Tower" id="banner">
  </div>
  
  <h1 id="blog-title">Best Blog</h1>
  
  <div class="container">
  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
    
    <label for="title">Title:</label>
    <input type="text" class="form-control" id="title" placholder="Title">
    
    <label for="content">Content:</label>
	<textarea class="form-control" rows="3" id="content"></textarea>
	<br>
	<a href="javascript:submitPost();">
		<button type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Submit post
		</button>
	</a>
	  
	  <body>
	  	<form action="/createPost" method="post" id="post-form" style="display: none;">
	      <div><textarea name="title" rows="1" cols="60" placeholder="Title" id="post-title"></textarea></div>
	      <div><textarea name="content" rows="3" cols="60" placeholder="Content" id="post-content"></textarea></div>
	      <div><input type="submit" value="Post Greeting" /></div>
	    </form>
	  </body>
  	</div>
  </div>
</html>