package com.ee461l.blog;

import java.io.IOException;
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
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
		
		Properties prop = new Properties();
		Session session = Session.getDefaultInstance(prop, null);

        String msgBody = "TEST MESSAGE!";
		for (Subscriber s : subscribers) {
			try {
	            Message msg = new MimeMessage(session);
	            msg.setFrom(new InternetAddress("anything@polished-scope-122022.appspotmail.com", "Rohan & Ashar's Blog"));
	            msg.addRecipient(Message.RecipientType.TO,
	                             new InternetAddress(s.getEmail(), s.getUser().getNickname()));
	            msg.setSubject("A TEST MESSAGE.");
	            msg.setText(msgBody);
	            Transport.send(msg);

	        } catch (AddressException e) {
	            // ...
	        } catch (MessagingException e) {
	            // ...
	        }
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doGet(req, resp);
	}
}
