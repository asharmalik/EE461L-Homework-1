package com.ee461l.blog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Subscriber {
	@Id Long id;
    User user;
    Date date;
    
    private Subscriber() {}
    
    public Subscriber(User user) {
    	this.user = user;
    	this.date = new Date();
    }
    
    public User getUser() {
    	return user;
    }
    
    public String getEmail() {
    	return user.getEmail();
    }
    
    public Date getDate() {
    	return date;
    }
}
