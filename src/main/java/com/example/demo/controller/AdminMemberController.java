package com.example.demo.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;

@Controller
@RequestMapping("/admin")
public class AdminMemberController {
	@Autowired
	private MemberService memberService;
	
	
	
	@RequestMapping("/adminMemberPage")
	public String adminPage() {
		return "admin/adminMemberPage";
	}
	
	@RequestMapping("/deleteMember")
	@ResponseBody
	public Map<String, Object> deleteMember(@RequestParam Map<String, Object> param, HttpSession session){
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		Map<String, Object> rs = memberService.deleteMember(param); 
				
		
		return Maps.of("msg", rs.get("msg"));
	}
	
	@RequestMapping("/getAllMembers")
	@ResponseBody
	public Map<String, Object> getAllMembers(@RequestParam Map<String, Object> param, HttpSession session){
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		Map<String, Object> rs = memberService.getAllMembers(param);
		boolean success = false;
		String resultCode = (String) rs.get("resultCode");
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success, "members", rs.get("members"));
	}
}
