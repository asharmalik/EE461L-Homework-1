package com.ee461l.blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class UnsubscribeServlet extends HttpServlet {
	static {
        ObjectifyService.register(Subscriber.class);
    }
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		
		for (Subscriber s : subscribers) {
			if (s.getUser().getEmail().equals(user.getEmail())) {
				ofy().delete().entity(s).now();
				break;
			}
		}

		resp.sendRedirect("/homepage.jsp");
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doPost(req, resp);
	}
}
