package com.siolabs.facegae.model;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import java.util.Date;


@Entity
public class User {
	
	
	@Id @Index
	private String email;
	
	private String name;
	
	private Date dob;
	

}
