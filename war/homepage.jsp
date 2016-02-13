<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.ee461l.blog.BlogPost" %>

<%@ page import="java.util.Collections" %>
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

<%@ page import="com.googlecode.objectify.*" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

<head>
 	<script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
   	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
   	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
 
 	<script src="homepage.js"></script>
 </head>
  
  <div class="img-container">
  	<img src="/img/header.jpg" alt="UT Tower" id="banner">
  </div>
  
  <h1 id="blog-title">Best Blog</h1>

<%
	// See if we're viewing all blog posts or not
	String viewAllParam = request.getParameter("viewAll");
	boolean viewAll = true;
	if (viewAllParam == null) {
		viewAll = false;
	}
	
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

  <div class="container">
  <div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
    
    <%
    	
    if(user != null){
    	
    	%>
    	<a href="/createpost.jsp">
			<button type="button" class="btn btn-default">
		  	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Create new post
			</button>
		</a>
    	<%
    }
    
    %>
    	
	<br>
	<br>
<%
    ObjectifyService.register(BlogPost.class);
	List<BlogPost> greetings = ObjectifyService.ofy().load().type(BlogPost.class).list();   
	Collections.sort(greetings); 

    if (greetings.isEmpty()) {

        %>

        <p>We have no blog posts.</p>

        <%

    } else {

        %>

        <p>Blog posts:</p>

        <%
        int count = 0;
        for (BlogPost greeting : greetings) {
            pageContext.setAttribute("greeting_content", greeting.getContent());
            pageContext.setAttribute("post_title", greeting.getTitle());
            pageContext.setAttribute("post_date", greeting.getDate());
            
            %>
			<p><font size="6"><b>${fn:escapeXml(post_title)}</b></font></p>

            <%

            if (greeting.getUser() == null) {
                %>
                
                By Unknown on ${fn:escapeXml(post_date)}
                
                <%
            } else {
                pageContext.setAttribute("greeting_user", greeting.getUser());
                %>

                By ${fn:escapeXml(greeting_user.nickname)} on ${fn:escapeXml(post_date)}

                <%
            }

            %>
            <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

            <%
            count++;
            if (count == 5 && !viewAll) break;
        }

    }

%>
    
    <% if (!viewAll) { %>
    	<br>
    	<br>
    	<a href="homepage.jsp?viewAll=true">
		<button type="button" class="btn btn-default"> View all posts </button>
	</a>

    <% }  %>
    
    </div>
    <div class="col-md-1"></div>
  </div>
</div>

<div id="wrapper" style="text-align: center">    
	<a href="javascript:onSubscribeClick();" id="subscribe-link">Subscribe</a> | <a href="" id="unsubscribe-link">Unsubscribe</a>
</div>

    
  </body>
</html>