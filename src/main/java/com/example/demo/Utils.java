package com.example.demo;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.Random;

public class Utils {

	public static int getAsInt(Object object) {
		if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			try {
				return Integer.parseInt((String) object);
			}catch(Exception e) {
				return -1;
			}
		}

		return -1;
	}
	
	public static String getTempKey(int length) {
		if(length == -1) {
			length = 30;
		}
		
		StringBuffer buffer = new StringBuffer();
		while(buffer.length() < length) {
			Random r = new Random();
			int key = r.nextInt(75) + 48;
			if( (48<key && key<57) || (65<key && 90>key) || (97<key && 122>key)) {
				buffer.append((char)key);
			}
		}
		
		return buffer.toString();
	}
	
	public static String getEncodedSHA1(String value) {
		String sha1 = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-1");
			digest.reset();
			digest.update(value.getBytes("utf8"));
			sha1 = String.format("%040x", new BigInteger(1, digest.digest()));			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return sha1;
	}
}
