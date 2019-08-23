package com.example.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.demo.interceptor.BaseInterceptor;
import com.example.demo.interceptor.NeedLoginInterceptor;
import com.example.demo.interceptor.NeedLogoutInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	@Autowired
	@Qualifier("baseInterceptor")
	private BaseInterceptor baseInterceptor;
	
	@Autowired
	@Qualifier("needLoginInterceptor")
	private NeedLoginInterceptor needLoginInterceptor;
	
	@Autowired
	@Qualifier("needLogoutInterceptor")
	private NeedLogoutInterceptor needLogoutInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {		
		registry.addInterceptor(baseInterceptor).addPathPatterns("/**");
		
		registry.addInterceptor(needLoginInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**", "/")
		.excludePathPatterns("/article/list", "/article/detail", "/article/showImg", "/article/downloadImg", "/article/getOneArticleAllReplies")
		.excludePathPatterns("/member/login", "/member/doLogin", "/member/auth", "/member/loginIdDoubleCheck", "/member/emailDoubleCheck")
		.excludePathPatterns("/member/join", "/member/doJoin", "/member/findLoginId", "/member/doFindLoginId", "/member/findLoginPw", "/member/doFindLoginPw");
		
		registry.addInterceptor(needLogoutInterceptor)
		.addPathPatterns("/member/login", "/member/doLogin","/member/join", "/member/doJoin","/member/loginIdDoubleCheck", "/member/emailDoubleCheck");
		
		
		WebMvcConfigurer.super.addInterceptors(registry);
	}
	
	
}
