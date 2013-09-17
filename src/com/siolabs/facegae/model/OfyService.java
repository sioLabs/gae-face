package com.siolabs.facegae.model;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.ObjectifyService;
import com.siolabs.facegae.model.User;

public class OfyService {
	
	static {
        factory().register(User.class);        
     
    }
	
	 	public static Objectify ofy() {
	        return ObjectifyService.ofy();
	    }

	    public static ObjectifyFactory factory() {
	        return ObjectifyService.factory();
	    }

}
