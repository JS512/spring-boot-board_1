package com.example.demo.service;

import java.util.Map;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.demo.Utils;
import com.example.demo.dao.MemberDao;
import com.example.demo.handler.MailHandler;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private JavaMailSender sender;
	
	public Map<String, Object> addMember(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		int num = memberDao.doubleCheckEmail(param);
		if(num > 0) {
			msg = "중복된 이메일 존재합니다.";
			resultCode = "F-1";		
			return Maps.of("msg", msg, "resultCode", resultCode);
		}
		
		num = memberDao.doubleCheckLoginId(param);
		if(num > 0) {
			msg = "중복된 아이디가 존재합니다.";
			resultCode = "F-1";
			return Maps.of("msg", msg, "resultCode", resultCode);
		}
		
		try {
			String authKey = Utils.getTempKey(-1);
			String memberMail = (String)param.get("email");
			param.put("authKey", authKey);
			memberDao.addMember(param);
			
			MailHandler mail = new MailHandler(sender);
			mail.setFrom("0000000");
			mail.setTo(memberMail);
			mail.setSubject("js페이지 회원가입 인증 메일");
			mail.setText(new StringBuffer().append("<h1>회원가입 인증메일입니다.</h1>")
					.append("<p>밑의 링크를 클릭하면 메일이 인증 됩니다.</p>")
					.append("<a href='http://localhost:8082/member/auth?email="+memberMail)
					.append("&authKey="+authKey+"' target='_blank'>메일 인증 링크</a>")
					.toString()
					);
			mail.send();
			msg = "회원가입 성공.. 작성하신 이메일로 인증메일을 전송하였습니다.";
			resultCode = "S-1";
		}catch(Exception e) {
			e.printStackTrace();
			msg = "회원가입 실패";
			resultCode = "F-1";
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> doubleCheckEmail(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		
		int num = memberDao.doubleCheckEmail(param);
		if(num > 0) {
			msg = "중복된 이메일 존재합니다.";
			resultCode = "F-1";
		}else {
			msg = "사용가능한 이메일 입니다.";
			resultCode = "S-1";
		}
		
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}

	public Map<String, Object> doubleCheckLoginId(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		
		int num = memberDao.doubleCheckLoginId(param);
		if(num > 0) {
			msg = "중복된 아이디가 존재합니다.";
			resultCode = "F-1";
		}else {
			msg = "사용가능한 아이디 입니다.";
			resultCode = "S-1";
		}
		
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> memberEmailAuth(Map<String, Object> param){
		String msg ="";
		String resultCode = "";
		try {
			int num = memberDao.getOneMemberByAuthKeyEmail(param);
			if(num <= 0) {
				msg = "메일 인증에 실패했습니다.";
				resultCode = "F-1";
				return Maps.of("msg", msg, "resultCode", resultCode);
			}
			memberDao.memberEmailAuth(param);
			msg = "메일 인증에 성공했습니다.";
			resultCode = "S-1";
		}catch(Exception e) {
			e.printStackTrace();
			msg = "메일 인증에 실패했습니다.";
			resultCode = "F-1";
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
}
