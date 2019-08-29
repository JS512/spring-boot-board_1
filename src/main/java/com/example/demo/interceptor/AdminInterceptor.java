package com.example.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component("adminInterceptor")
public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String role = (String)request.getAttribute("role");
		if(!role.equals("admin")) {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write("<script>");
			response.getWriter().write("alert('권한이 필요한 서비스 입니다.');");
			response.getWriter().write("location.replace('/');");
			response.getWriter().write("</script>");
			return false;
		}
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
}
