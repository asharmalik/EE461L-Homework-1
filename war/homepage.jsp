<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.Collections" %>

<%@ page import="com.googlecode.objectify.Objectify" %>

<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 

<html>

<head>
   	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
 </head>

  <head>

  </head>

 

  <body>
  
  <div class="img-container">
  	<img src="/img/header.jpg" alt="UT Tower" id="banner">
  </div>
  
  <h1 id="blog-title">Blog Title</h1>
  
  
  <div class="container">
  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
    	
    </div>
    <div class="col-md-1"></div>
  </div>
</div>

<%

    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>" id="sign-in-link">Sign out</a>

<%

    } else {

%>

<p><a href="<%= userService.createLoginURL(request.getRequestURI()) %>" id="sign-in-link">Sign in</a></p>

<%

    }

%>

 

<%

    //DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    //Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    //Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);

    //List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));

	//ObjectifyService.register(Greeting.class);
	
	//List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   
	
	//Collections.sort(greetings); 



%>

 

    <form action="/ofysign" method="post">

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Post Greeting" /></div>

      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>

 

  </body>

</html>

 