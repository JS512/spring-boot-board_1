package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")	
	public String main(HttpServletRequest request) {
		String role = (String)request.getAttribute("role");
		if(role != null && role.equals("admin")) {
			return "forward:/admin/";
		}
		return "main/home";
	}
}
