package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminArticleController {
	@RequestMapping("/addArticle")
	public String addArticle() {
		return "forward:/article/addArticle";
	}
	
	@RequestMapping("/doAddArticle")
	public String doAddArticle() {
		return "forward:/article/doAddArticle";
	}
}
