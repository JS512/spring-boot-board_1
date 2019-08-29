package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.ArticleReply;
import com.example.demo.dto.Letter;
import com.example.demo.dto.Member;
import com.example.demo.dto.Report;

@Mapper
public interface MemberDao {

	public void addMember(Map<String, Object> param);
	
	public int doubleCheckEmail(Map<String, Object> param);

	public int doubleCheckLoginId(Map<String, Object> param);

	public int getOneMemberByAuthKeyEmail(Map<String, Object> param);

	public void memberEmailAuth(Map<String, Object> param);

	public Member getOneMemberByLoginIdPw(Map<String, Object> param);
	
	public Member getOneMemberById(int loginedMemberId);

	public void deleteOneMember(int loginedMemberId);

	public String findLoginId(Map<String, Object> param);

	public String findLoginPw(Map<String, Object> param);

	public void changeTempPw(Map<String, Object> param);

	public Member getOneMemberByIdPw(Map<String, Object> param);

	public void changeLoginPw(Map<String, Object> param);

	public String getMemberRole(int loginedMemberId);

	public List<Member> getAllMembers(int loginedMemberId);

	public void addLetter(Map<String, Object> param);

	public List<Letter> getAllLetters(Map<String, Object> param);

	public int getTotalLetterCount(Map<String, Object> param);

	public void deleteOneLetterById(int id);

	public Letter getOneLetterById(int id);

	public List<ArticleReply> getMemberRepliesByMemberId(Map<String, Object> param);

	public void addReport(Map<String, Object> param);

	public List<Report> getAllReports(Map<String, Object> param);

	public int getTotalReportCount(Map<String, Object> param);
}
