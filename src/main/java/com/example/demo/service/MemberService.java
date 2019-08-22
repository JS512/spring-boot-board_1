package com.example.demo.service;

import java.util.Map;

public interface MemberService {

	public Map<String, Object> addMember(Map<String, Object> param);

	public Map<String, Object> doubleCheckEmail(Map<String, Object> param);

	public Map<String, Object> doubleCheckLoginId(Map<String, Object> param);

	public Map<String, Object> memberEmailAuth(Map<String, Object> param);

	public Map<String, Object> checkMember(Map<String, Object> param);

}
