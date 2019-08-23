package com.example.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.dto.Member;
import com.example.demo.service.MemberService;

@Component("baseInterceptor")
public class BaseInterceptor implements HandlerInterceptor{
	@Autowired
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginedMemberId") != null) {
			int loginedMemberId = (int)session.getAttribute("loginedMemberId");
			Member member = memberService.getOneMemberById(loginedMemberId);
			
			if(member != null) {
				String role = memberService.getMemberRole(loginedMemberId);
				if(role == null) {
					role = "";
				}
				request.setAttribute("loginedMemberId", loginedMemberId);
				request.setAttribute("isLogined", true);
				request.setAttribute("loginedMemberLoginId", member.getLoginId());
				request.setAttribute("loginedMember", member);
				request.setAttribute("role", role);
			}else {
				request.setAttribute("loginedMemberId", 0);
				request.setAttribute("isLogined", false);
				request.setAttribute("loginedMemberLoginId", "");
				request.setAttribute("loginedMember", null);
				request.setAttribute("role", "");
			}
		}else {
			request.setAttribute("loginedMemberId", 0);
			request.setAttribute("isLogined", false);
			request.setAttribute("loginedMemberLoginId", "");
			request.setAttribute("loginedMember", null);
			request.setAttribute("role", "");
		}
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
