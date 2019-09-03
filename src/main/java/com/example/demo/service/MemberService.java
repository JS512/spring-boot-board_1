package com.example.demo.service;

import java.util.Map;

import com.example.demo.dto.Letter;
import com.example.demo.dto.Member;
import com.example.demo.dto.MemberProfileImg;

public interface MemberService {

	public Map<String, Object> addMember(Map<String, Object> param);

	public Map<String, Object> doubleCheckEmail(Map<String, Object> param);

	public Map<String, Object> doubleCheckLoginId(Map<String, Object> param);

	public Map<String, Object> memberEmailAuth(Map<String, Object> param);

	public Map<String, Object> checkMember(Map<String, Object> param);
	
	public Member getOneMemberById(int loginedMemberId);

	public Map<String, Object> MemberWithdrawal(int loginedMemberId);

	public Map<String, Object> findLoginId(Map<String, Object> param);

	public Map<String, Object> findLoginPw(Map<String, Object> param);

	public Map<String, Object> changeLoginPw(Map<String, Object> param);

	public String getMemberRole(int loginedMemberId);

	public Map<String, Object> deleteMember(Map<String, Object> param);

	public Map<String, Object> getAllMembers(Map<String, Object> param);

	public Map<String, Object> getMemberProfile(Map<String, Object> param);

	public Map<String, Object> sendLetter(Map<String, Object> param);

	public Map<String, Object> getAllLetters(Map<String, Object> param);

	public Map<String, Object> deleteLetter(Map<String, Object> param);

	public Letter getOneLetterById(Map<String, Object> param);

	public Map<String, Object> sendReport(Map<String, Object> param);

	public Map<String, Object> getAllReports(Map<String, Object> param);

	public Map<String, Object> getMemberLetterList(Map<String, Object> param);

	public Map<String, Object> deleteMemberProfileImg(Map<String, Object> param);

	public Map<String, Object> modifyMemberProfileImg(Map<String, Object> param);

	public MemberProfileImg getMemberProfileImg(Map<String, Object> param);	

}
