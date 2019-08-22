package com.example.demo.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/join")
	public String join() {
		return "member/join";
	}
	@RequestMapping("/doJoin")
	public String doJoin(Model model, @RequestParam Map<String, Object> param) {
		Map<String, Object> rs = memberService.addMember(param);
		
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/";
			model.addAttribute("redirectUrl", redirectUrl);			
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";		
	}
	
	@RequestMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@RequestMapping("/doLogin")
	public String doLogin(Model model, @RequestParam Map<String, Object> param, HttpSession session) {
		Map<String, Object> rs = memberService.checkMember(param);
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String)rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/";
			model.addAttribute("redirectUrl", redirectUrl);
			session.setAttribute("loginedMemberId", (int)rs.get("loginedMemberId"));
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginedMemberId");
		return "redirect:/";
	}
	
	@RequestMapping("/emailDoubleCheck")
	@ResponseBody
	public Map<String, Object> emailDoubleCheck(@RequestParam Map<String, Object> param){
		Map<String, Object> rs = memberService.doubleCheckEmail(param);
		
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {			
			return Maps.of("msg", rs.get("msg"), "success", true);
		}else {
			return Maps.of("msg", rs.get("msg"), "success", false);
		}
		
	}
	
	@RequestMapping("/loginIdDoubleCheck")
	@ResponseBody
	public Map<String, Object> loginIdDoubleCheck(@RequestParam Map<String, Object> param){		
		Map<String, Object> rs = memberService.doubleCheckLoginId(param);		
		
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {			
			return Maps.of("msg", rs.get("msg"), "success", true);
		}else {
			return Maps.of("msg", rs.get("msg"), "success", false);
		}		
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
		return "member/myPage";
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
	
	@RequestMapping("/findLoginId")
	public String findLoginId() {
		return "member/findLoginId";
	}
	
	@RequestMapping("/doFindLoginId")
	@ResponseBody
	public Map<String, Object> doFindLoginId(@RequestParam Map<String, Object> param){
		Map<String, Object> rs = memberService.findLoginId(param);
		if(rs.get("msg") == null) {
			return Maps.of("msg", "일치하는 정보가 없습니다.", "success", false);
		}else {
			return Maps.of("msg", rs.get("msg"), "success", true);
		}
		
	}
	
	@RequestMapping("/findLoginPw")
	public String findLoginPw() {
		return "member/findLoginPw";
	}
	
	@RequestMapping("/doFindLoginPw")
	@ResponseBody
	public Map<String, Object> doFindLoginPw(@RequestParam Map<String, Object> param, HttpSession session){
		Map<String, Object> rs = memberService.findLoginPw(param);
		return Maps.of("msg", rs.get("msg"));		
	}
}
