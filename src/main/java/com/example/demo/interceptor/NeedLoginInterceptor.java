package com.example.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.dto.Member;
import com.example.demo.service.MemberService;

@Component("needLoginInterceptor")
public class NeedLoginInterceptor implements HandlerInterceptor{	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean logined = (boolean)request.getAttribute("isLogined");
		if(!logined) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write("<script>");
			response.getWriter().write("alert('로그인이 필요한 서비스 입니다.');");
			response.getWriter().write("history.back();");
			response.getWriter().write("</script>");
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
