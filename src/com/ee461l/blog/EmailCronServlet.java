package com.ee461l.blog;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Properties;
import java.util.List;

import javax.servlet.http.*;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.googlecode.objectify.ObjectifyService;

public class EmailCronServlet extends HttpServlet {
	static {
        ObjectifyService.register(Subscriber.class);
    }
	
	public final static long MILLIS_PER_DAY = 24 * 60 * 60 * 1000L;
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();   
		Collections.sort(posts);
		
		Long now = new Date().getTime();
		List<BlogPost> postsToSend = new ArrayList<>();
		
		for (BlogPost p : posts) {
			Long postTime = p.getDate().getTime();
			if (now - postTime <= MILLIS_PER_DAY) {
				postsToSend.add(p);
			}
		}
		
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		
		Properties prop = new Properties();
		Session session = Session.getDefaultInstance(prop, null);

		if (!postsToSend.isEmpty()) {
	        String msgBody = buildMessage(postsToSend);
			for (Subscriber s : subscribers) {
				try {
		            Message msg = new MimeMessage(session);
		            msg.setFrom(new InternetAddress("anything@polished-scope-122022.appspotmail.com", "Best Blog"));
		            msg.addRecipient(Message.RecipientType.TO,
		                             new InternetAddress(s.getEmail(), s.getUser().getNickname()));
		            msg.setSubject("Best Blog 24 Hour Updates");
		            msg.setText(msgBody);
		            Transport.send(msg);
	
		        } catch (AddressException e) {
		            // ...
		        } catch (MessagingException e) {
		            // ...
		        }
			}
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doGet(req, resp);
	}
	
	private String buildMessage(List<BlogPost> posts) {
		StringBuilder s = new StringBuilder();
		s.append("New posts in the last 24 hours:\n\n");
		
		for (BlogPost p : posts) {
			s.append(p.getTitle() + "\n" + p.getUser().getNickname() + " " + p.getDate() + "\n" + p.getContent() + "\n\n");
		}
		
		return s.toString();
	}
}
