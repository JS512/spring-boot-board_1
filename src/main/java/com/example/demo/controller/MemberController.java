package com.example.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.Utils;
import com.example.demo.dto.Letter;
import com.example.demo.dto.MemberProfileImg;
import com.example.demo.service.MemberService;

import jline.internal.Log;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Value("${custom.profileImgDir}")
	public String profileImgDir;
	
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
	
	@RequestMapping("/changeLoginPw")
	public String changeLoginPw() {
		return "member/changeLoginPw";
	}
	
	@RequestMapping("/doChangeLoginPw")
	public String doChangeLoginPw(Model model, @RequestParam Map<String, Object> param, HttpSession session) {
		
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));		
		Map<String, Object> rs = memberService.changeLoginPw(param);		
		model.addAttribute("msg", rs.get("msg"));		
		String resultCode = (String) rs.get("resultCode");		
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/member/myPage";
			model.addAttribute("redirectUrl", redirectUrl);
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/getMemberProfile")
	@ResponseBody
	public Map<String, Object> getMemberProfile(@RequestParam Map<String, Object> param) {
		if(!Utils.isNumeric(param, new String[] {"id"})) {
			return Maps.of("msg", "잘못된 접근", "member", null, "success", false);
		}
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
		
		if(!Utils.needParamCheck(param, new String[] {"toId"}) || !Utils.isNumeric(param, new String[] {"toId"})) {
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		
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
		
		return "member/letter";
	}
	
	@RequestMapping("/deleteLetter")
	@ResponseBody
	public Map<String, Object> deleteLetter(@RequestParam Map<String, Object> param, HttpSession session) {		
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		
		if(!Utils.needParamCheck(param, new String[] {"id"}) || !Utils.isNumeric(param, new String[] {"id"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		
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
	
	@RequestMapping("/sendReport")
	@ResponseBody
	public Map<String, Object> sendReport(@RequestParam Map<String, Object> param, HttpSession session) {
		
		if(!Utils.needParamCheck(param, new String[] {"relType", "relId", "body"}) || !Utils.isNumeric(param, new String[] {"relId"})) {
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		
		Map<String, Object> rs = new HashMap<>();
		boolean success = false;
		
		param.put("loginedMemberId",(int)session.getAttribute("loginedMemberId"));
		rs = memberService.sendReport(param);
		
		String resultCode = (String) rs.get("resultCode");		
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}	
		
		return Maps.of("msg", rs.get("msg"), "success", success);
		
	}
	
	@RequestMapping("/getMemberLetterList")
	@ResponseBody
	public Map<String, Object> getMemberLetterList(@RequestParam Map<String, Object> param, HttpSession session){
		if(!Utils.needParamCheck(param, new String[] {"memberId"}) || !Utils.isNumeric(param, new String[] {"memberId"})) {
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		Map<String, Object> rs = memberService.getMemberLetterList(param);
		
		String resultCode = (String)rs.get("resultCode");
		boolean success = false;
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success, "letters", rs.get("letters"));
	}
	
	@RequestMapping("/modifyMemberProfileImg")
	@ResponseBody
	public Map<String, Object> modifyMemberProfileImg(@RequestParam(value="deleteProfileImg", required=false) Object delete,
			@RequestParam(value="modifyProfileImg", required=false) Object modify,
            @RequestParam(value="profileImg", required=false) MultipartFile profileImg,
            HttpServletRequest request){
		
		if(delete == null && modify == null) {			
			return Maps.of("msg","잘못된 접근");
		}
		Map<String, Object> param = new HashMap<>();
		HttpSession session = request.getSession();
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		param.put("memberLoginId", request.getAttribute("loginedMemberLoginId"));
		
		Map<String, Object> rs = null;
		if(delete != null) {
			rs = memberService.deleteMemberProfileImg(param);
		}else if(profileImg != null) {			
			param.put("profileImg", profileImg);
			rs = memberService.modifyMemberProfileImg(param);
		}
		
		return Maps.of("msg", rs.get("msg"));
	}
	
	@RequestMapping("/showProfileImg")
	@ResponseBody
	public ResponseEntity<Resource> showImg(@RequestParam Map<String, Object> param, HttpServletRequest request){		
		HttpSession session = request.getSession();
		if(param.get("memberId") != null) {
			param.put("loginedMemberId", Integer.parseInt((String)param.get("memberId")));
		}else {
			param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		}
		
		
		MemberProfileImg img = memberService.getMemberProfileImg(param);
		File target = null;
		
		if(img != null) {
			target = new File(profileImgDir, img.getFileName());
		}else {
			target = new File(profileImgDir, Utils.basicProfileImg);
		}
		
		HttpHeaders header = new HttpHeaders();		
		Resource rs = null;
		
		if(target.exists()) {
			try {				
				String mimeType = Files.probeContentType(Paths.get(target.getAbsolutePath()));			
				
				if(mimeType == null) {
					mimeType = "octet-stream";
				}
				
				rs = new UrlResource(target.toURI());				
								
				header.setContentType(MediaType.parseMediaType(mimeType));				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return new ResponseEntity<Resource>(rs, header, HttpStatus.OK);
	}
	
	private boolean checkLetterAuthentication(Map<String, Object> param) {
		
		Letter letter = memberService.getOneLetterById(param);		
		String msg = null;
		
		if(letter == null) {
			msg = "존재하지 않는 쪽지 입니다.";
			
		}else if(letter.getFromMemberId() != (int)param.get("loginedMemberId")){
			msg = "권한이 없습니다.";
			
		}else if(letter.isViewStatus()){
			msg = "상대방이 읽은 상태 입니다.";
		}else {
			return true;
		}
		param.put("msg", msg);
		return false;
	}
}
