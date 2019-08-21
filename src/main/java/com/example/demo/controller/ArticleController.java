package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Article;
import com.example.demo.service.ArticleService;

import groovy.util.logging.Slf4j;
import jline.internal.Log;

@Slf4j
@Controller
@RequestMapping("/article")
public class ArticleController {
	@Autowired
	private ArticleService articleService;	
	
	@RequestMapping("/list")
	public String list(Model model,@RequestParam Map<String, Object> param) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		Map<String, Object> rs = articleService.getArticleList(param);
		
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "article/list";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model,@RequestParam Map<String, Object> param) {
		Article article = articleService.getOneArticleById(param);
		model.addAttribute("article", article);
		
		return "article/detail";
	}
	
	@RequestMapping("/addArticle")
	public String addArticle() {
		return "article/add";
	}
	
	@RequestMapping("/doAddArticle")
	public String doAddArticle(Model model, @RequestParam Map<String, Object> param) {
		Map<String, Object> rs = articleService.addOneArticle(param);
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/article/detail?id="+param.get("id")+"&boardId="+param.get("boardId");
			model.addAttribute("redirectUrl", redirectUrl);
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
}
