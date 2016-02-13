package com.ee461l.blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class CreatePostServlet extends HttpServlet {
	static {
        ObjectifyService.register(BlogPost.class);
    }
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		BlogPost greeting = new BlogPost(user, content, title);
		ofy().save().entity(greeting).now();
		resp.sendRedirect("/homepage.jsp");
	}
}
