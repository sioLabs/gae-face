package com.siolabs.facegae;


import org.json.JSONObject;
import org.json.JSONException;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.PrintWriter;

import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Gae_faceServlet extends HttpServlet {

	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {            
		String code = req.getParameter("code");
		if (code == null || code.equals("")) {
			// an error occurred, handle this
		}
		
		String token = null;
		try {
			String g = "https://graph.facebook.com/oauth/access_token?client_id=215797211910886&redirect_uri=" + URLEncoder.encode("http://gae-face.appspot.com/gae_face", "UTF-8") + "&client_secret=4baf605569c392ba15ae905e3571032a&code=" + code;
			URL u = new URL(g);
			URLConnection c = u.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
			String inputLine;
			StringBuffer b = new StringBuffer();
			while ((inputLine = in.readLine()) != null)
				b.append(inputLine + "\n");            
			in.close();
			token = b.toString();
			if (token.startsWith("{"))
				throw new Exception("error on requesting token: " + token + " with code: " + code);
		} catch (Exception e) {
			// an error occurred, handle this
		}

		String graph = null;
		try {
			String g = "https://graph.facebook.com/me?" + token;
			URL u = new URL(g);
			URLConnection c = u.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
			String inputLine;
			StringBuffer b = new StringBuffer();
			while ((inputLine = in.readLine()) != null)
				b.append(inputLine + "\n");            
			in.close();
			graph = b.toString();
		} catch (Exception e) {
			// an error occurred, handle this
		}

		String facebookId;
		String firstName;
		String middleNames;
		String lastName;
		String email;
		String gender;

		try {
			JSONObject json = new JSONObject(graph);
			facebookId = json.getString("id");
			
			firstName = json.getString("first_name");
			if (json.has("middle_name"))
				middleNames = json.getString("middle_name");
			else
				middleNames = null;
			if (middleNames != null && middleNames.equals(""))
				middleNames = null;
			lastName = json.getString("last_name");
			email = json.getString("email");
			if (json.has("gender")) {
				String g = json.getString("gender");
				if (g.equalsIgnoreCase("female"))
					gender = "female";
					else if (g.equalsIgnoreCase("male"))
					gender = "male";
					else
						gender = "classified";

			} else {
				gender ="lelo muh me";
			}
			PrintWriter out = res.getWriter();
			out.println("Name : "+firstName + " " + lastName + "<br />");
			out.println("facebookId : " + facebookId);
			out.println("<br />email :" + email);
			out.println("<br />Gender : " + gender);
			
		} catch (JSONException e) {
			// an error occurred, handle this
		}		
		
	}
}