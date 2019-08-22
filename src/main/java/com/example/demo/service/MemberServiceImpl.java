package com.example.demo.service;

import java.util.Map;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	
	public Map<String, Object> addMember(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			memberDao.addMember(param);
			msg = "회원가입 성공";
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
}
