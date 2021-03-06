package com.ee461l.blog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class BlogPost implements Comparable<BlogPost> {
	@Id Long id;
    User user;
    String title;
    String content;
    Date date;

    private BlogPost() {}

    public BlogPost(User user, String content, String title) {
        this.user = user;
        this.content = content;
        this.title = title;
        this.date = new Date();
    }

    public User getUser() {
        return user;
    }

    public String getContent() {
        return content;
    }
    
    public String getTitle() {
    	return title;
    }
    
    public Date getDate() {
    	return date;
    }
    
	@Override
    public int compareTo(BlogPost other) {
        if (date.before(other.date)) {
            return 1;
        } else if (date.after(other.date)) {
            return -1;
        }

        return 0;
    }
}
