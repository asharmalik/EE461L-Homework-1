<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
  	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>
  <body>
  	<form action="/createPost" method="post">
      <div><textarea name="title" rows="1" cols="60"></textarea></div>
      <div><textarea name="content" rows="3" cols="60"></textarea></div>
      <div><input type="submit" value="Post Greeting" /></div>
    </form>
  </body>
</html>