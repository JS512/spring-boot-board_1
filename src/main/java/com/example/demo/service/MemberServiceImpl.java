package com.example.demo.service;

import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.demo.Utils;
import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Letter;
import com.example.demo.dto.Member;
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
		String authKey = Utils.getTempKey(-1);
		try {			
			param.put("authKey", authKey);
			memberDao.addMember(param);
		}catch(Exception e) {
			msg = "회원가입 실패";
			resultCode = "F-1";
			e.printStackTrace();
		}
		try {
			
			String memberMail = (String)param.get("email");
			
			
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
			msg = "회원가입 성공.. 인증메일 전송 중 오류";
			resultCode = "S-1";
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
	
	public Map<String, Object> checkMember(Map<String, Object> param){
		String msg ="";
		String resultCode = "";
		Member member = null;
		try {
			member = memberDao.getOneMemberByLoginIdPw(param);
			if(member == null) {
				msg = "존재하지 않는 회원 정보입니다.";
				resultCode = "F-1";
				
			}else {		
				msg = "로그인에 성공했습니다.";
				resultCode = "S-1";
				return Maps.of("msg", msg, "resultCode", resultCode, "loginedMemberId", member.getId());
			}
		}catch(Exception e) {
			e.printStackTrace();
			msg = "로그인에 실패했습니다.";
			resultCode = "F-1";
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Member getOneMemberById(int loginedMemberId) {
		return memberDao.getOneMemberById(loginedMemberId);
	}
	
	public Map<String, Object> MemberWithdrawal(int loginedMemberId){
		String msg = "";
		String resultCode = "";
		try {			
			memberDao.deleteOneMember(loginedMemberId);
			msg = "회원탈퇴가 되었습니다.";
			resultCode = "S-1";
		}catch(Exception e) {
			msg = "회원탈퇴중 오류가 발생 되었습니다.";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);		
	}
	
	public Map<String, Object> findLoginId(Map<String, Object> param){
		
		String msg = memberDao.findLoginId(param);
		
		return Maps.of("msg", msg);
	}
	
	public Map<String, Object> findLoginPw(Map<String, Object> param){		
		String msg = "";		
		try {
			String key = Utils.getTempKey(8);
			String tempPw = Utils.getEncodedSHA1(key);
			if(tempPw != null) {
				param.put("tempPw", tempPw);
				String email = memberDao.findLoginPw(param);
				if(email != null) {
					memberDao.changeTempPw(param);
					MailHandler mail = new MailHandler(sender);
					mail.setSubject("임시 비밀번호 발급");
					mail.setTo(email);
					mail.setText("<h1>임시 비밀번호 입니다.</h1>" + key);
					mail.send();
					msg = "회원가입시 작성하신 이메일로 임시 비밀번호를 발급해였습니다.";
				}else {
					msg = "정보와 일치하는 회원이 없습니다.";
				}
			}else {
				msg = "키 생성 오류";
			}
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			msg = "패스워드 찾기 실패";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg);
	}
	
	public Map<String, Object> changeLoginPw(Map<String, Object> param){
		Member member = memberDao.getOneMemberByIdPw(param);
		String msg = "";
		String resultCode = "";
		if(member != null) {
			memberDao.changeLoginPw(param);
			msg = "비밀번호가 변경 되었습니다.";
			resultCode = "S-1";
		}else {
			msg = "비밀번호가 일치하지 않습니다.";
			resultCode = "F-1";
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public String getMemberRole(int loginedMemberId) {
		return memberDao.getMemberRole(loginedMemberId);
	}
	
	public Map<String, Object> deleteMember(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
			if(role == null || !role.equals("admin")) {
				msg = "권한이 없습니다.";
				resultCode = "F-1";
			}else {
				memberDao.deleteOneMember(Integer.parseInt((String)param.get("targetMemberId")));
				msg = "성공적으로 삭제했습니다.";
				resultCode = "S-1";
			}
		} catch (Exception e) {
			msg = "멤버 삭제 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}

	public Map<String, Object> getAllMembers(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		List<Member> members = null;
		try {
			String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
			if(role == null || !role.equals("admin")) {
				msg = "권한이 없습니다.";
				resultCode = "F-1";
			}else {
				members = memberDao.getAllMembers((int)param.get("loginedMemberId"));			
				resultCode = "S-1";
			}
		} catch (Exception e) {
			msg = "멤버 로드 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode, "members", members);
	}
	
	public Map<String, Object> getMemberProfile(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		Member member = null;
		try {
			member = memberDao.getOneMemberById(Integer.parseInt((String)param.get("id")));
			if(member == null) {
				msg = "존재하지 않는 사용자 입니다.";
				resultCode = "F-1";
			}else {							
				resultCode = "S-1";
			}
		} catch (Exception e) {
			msg = "멤버 로드 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode, "member", member);
	}
	
	public Map<String, Object> sendLetter(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		
		try {
			Member member = memberDao.getOneMemberById(Integer.parseInt((String)param.get("toId")));
			if(member == null) {
				msg = "존재하지 않는 사용자";
				resultCode = "F-1";
			}else {
				memberDao.addLetter(param);
				msg = "전송 성공";
				resultCode = "S-1";
			}
		} catch (Exception e) {
			msg = "멤버 로드 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> getAllLetters(Map<String, Object> param){		
		List<Letter> letters = null;
		Map<String, Object> page = Utils.calcData(param, memberDao.getTotalLetterCount(param));
		try {
			letters = memberDao.getAllLetters(param);			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return Maps.of("page", page, "letters", letters);		
	}
	
	public Map<String, Object> deleteLetter(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		
		try {
			Letter letter = memberDao.getOneLetterById(Integer.parseInt((String)param.get("id")));
			if(letter == null) {
				msg = "존재하지 않는 정보";
				resultCode = "F-1";
			}else if(letter.getToMemberId() != (int)param.get("loginedMemberId")){				
				msg = "권한이 없는 사용자";
				resultCode = "F-1";
			}else {
				memberDao.deleteOneLetterById(Integer.parseInt((String)param.get("id")));
				msg = "삭제 완료";
				resultCode = "S-1";
			}
		} catch (Exception e) {
			msg = "삭제 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
}
