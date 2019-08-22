package com.example.demo.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDao {

	public void addMember(Map<String, Object> param);
	
	public int doubleCheckEmail(Map<String, Object> param);

	public int doubleCheckLoginId(Map<String, Object> param);

	public int getOneMemberByAuthKeyEmail(Map<String, Object> param);

	public void memberEmailAuth(Map<String, Object> param);
}
