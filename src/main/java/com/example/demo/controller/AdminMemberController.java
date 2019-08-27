package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Letter;
import com.example.demo.service.MemberService;

@Controller
@RequestMapping("/admin")
public class AdminMemberController {
	@Autowired
	private MemberService memberService;	
	
	
	@RequestMapping("/adminMemberPage")
	public String adminPage() {
		return "admin/admin_member/adminMemberPage";
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
	
	@RequestMapping("/auth")
	public String auth(Model model, @RequestParam Map<String, Object> param) {
		Map<String ,Object> rs = memberService.memberEmailAuth(param);
		model.addAttribute("msg", rs.get("msg"));
		model.addAttribute("redirectUrl", "/");
		return "common/redirect";
	}
	
	@RequestMapping("/myPage")
	public String myPage() {
		return "admin/admin_member/admin_myPage";
	}
	
	@RequestMapping("/withdrawal")
	public String withdrawal(HttpSession session, Model model) {		
		Map<String ,Object> rs = memberService.MemberWithdrawal((int)session.getAttribute("loginedMemberId"));
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String)rs.get("resultCode");
		if(resultCode.startsWith("S-")) {
			session.removeAttribute("loginedMemberId");
			String redirectUrl = "/";
			model.addAttribute("redirectUrl", redirectUrl);
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/changeLoginPw")
	public String changeLoginPw() {
		return "admin/admin_member/adim_changeLoginPw";
	}
	
	@RequestMapping("/doChangeLoginPw")
	public String doChangeLoginPw(Model model, @RequestParam Map<String, Object> param, HttpSession session) {
		
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));		
		Map<String, Object> rs = memberService.changeLoginPw(param);		
		model.addAttribute("msg", rs.get("msg"));		
		String resultCode = (String) rs.get("resultCode");		
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/admin/myPage";
			model.addAttribute("redirectUrl", redirectUrl);
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/getMemberProfile")
	@ResponseBody
	public Map<String, Object> getMemberProfile(@RequestParam Map<String, Object> param) {		
		Map<String, Object> rs = memberService.getMemberProfile(param);		
		
		boolean success = false;
		String resultCode = (String) rs.get("resultCode");		
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "member", rs.get("member"), "success", success);
	}
	
	@RequestMapping("/sendLetter")
	@ResponseBody
	public Map<String, Object> sendLetter(@RequestParam Map<String, Object> param, HttpSession session) {
		Map<String, Object> rs = new HashMap<>();
		boolean success = false;
		if(Integer.parseInt((String)param.get("toId")) == (int)session.getAttribute("loginedMemberId")) {
			rs.put("msg", "자신에게는 쪽지를 보낼 수 없습니다.");			
		}else {
			param.put("loginedMemberId",(int)session.getAttribute("loginedMemberId"));
			rs = memberService.sendLetter(param);
			
			String resultCode = (String) rs.get("resultCode");		
			
			if(resultCode.startsWith("S-")) {
				success = true;
			}
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);
	}
	
	@RequestMapping("/letterList")
	public String letterList(Model model, @RequestParam Map<String, Object> param, HttpSession session) {
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		
		Map<String, Object> rs = new HashMap<>();
		rs = memberService.getAllLetters(param);
		model.addAttribute("letters", rs.get("letters"));
		model.addAttribute("page", rs.get("page"));
		
		return "admin/admin_member/admin_letter";
	}
	
	@RequestMapping("/deleteLetter")
	@ResponseBody
	public Map<String, Object> deleteLetter(@RequestParam Map<String, Object> param, HttpSession session) {
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));		
		if(!checkLetterAuthentication(param)) {
			return Maps.of("msg", param.get("msg"), "success", false);
		}
		Map<String, Object> rs = memberService.deleteLetter(param);
		
		boolean success = false;
		String resultCode = (String) rs.get("resultCode");		
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);
	}
	
	private boolean checkLetterAuthentication(Map<String, Object> param) {
		Letter letter = memberService.getOneLetterById(param);
		String msg = null;
		if(letter == null) {
			msg = "존재하지 않는 쪽지 입니다.";
			
		}else if(letter.getToMemberId() != (int)param.get("loginedMemberId")){
			msg = "권한이 없습니다.";
			
		}else {
			return true;
		}
		param.put("msg", msg);
		return false;
	}
}
