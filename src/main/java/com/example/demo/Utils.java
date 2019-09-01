package com.example.demo;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.web.util.HtmlUtils;

public class Utils {
	public static int getAsInt(Object object) {
		if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			try {
				return Integer.parseInt((String) object);
			} catch (Exception e) {
				return -1;
			}
		}

		return -1;
	}

	public static String getTempKey(int length) {
		if (length == -1) {
			length = 30;
		}

		StringBuffer buffer = new StringBuffer();
		while (buffer.length() < length) {
			Random r = new Random();
			int key = r.nextInt(75) + 48;
			if ((48 < key && key < 57) || (65 < key && 90 > key) || (97 < key && 122 > key)) {
				buffer.append((char) key);
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
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sha1;
	}

	public static boolean needParamCheck(Map<String, Object> param, String... checkParams) {
		for (int i = 0; i < checkParams.length; i++) {
			if (!param.containsKey(checkParams[i])) {
				return false;
			} else {
				if (param.get(checkParams[i]) == null) {
					return false;
				}
			}
		}

		return true;
	}

	public static boolean isNumeric(Map<String, Object> param, String... str) {
		
		for (int i = 0; i < str.length; i++) {
			String s = String.valueOf(param.get(str[i]));			
			if (s != null) {				
				if (s.length() == 0 || !s.chars().allMatch(Character::isDigit)) {
					return false;
				}
			}
		}
		

		return true;

	}

	public static boolean isBoolean(Map<String, Object> param, String... str) {

		try {
			for (int i = 0; i < str.length; i++) {
				String s = String.valueOf(param.get(str[i]));
				if (s != null) {
					if (s.length() == 0 || Boolean.parseBoolean(s)) {
						return false;
					}
				}
			}
		} catch (Exception e) {
//			e.printStackTrace();
			return false;
		}
		return true;
	}

	public static Map<String, Object> calcData(Map<String, Object> param, int total) {
		Map<String, Object> rs = new HashMap<>();

		int totalCount = total;
		int perPageNum = 10;
		int pageBlock = 5;
		int cPage = Utils.getAsInt(param.get("cPage"));
		int startPage;
		int endPage;
		int limitPage;
		boolean next;
		boolean prev;

		endPage = (int) Math.ceil(cPage / (double) pageBlock) * pageBlock;
		startPage = endPage - pageBlock + 1;
		limitPage = (int) Math.ceil(totalCount / (double) perPageNum);
		if (endPage > limitPage) {
			endPage = limitPage;
		}

		prev = startPage == 1 ? false : true;
		next = endPage == limitPage ? false : true;

		rs.put("startPage", startPage);
		rs.put("endPage", endPage);
		rs.put("prev", prev);
		rs.put("next", next);

		param.put("startNum", (cPage - 1) * perPageNum);
		param.put("perPageNum", perPageNum);

		return rs;
	}

	public static boolean isOnlyText(String text) {
		return Jsoup.isValid(text, Whitelist.none());
	}

	public static String htmlEscape(String html) {
		return HtmlUtils.htmlEscape(html);
	}

}
