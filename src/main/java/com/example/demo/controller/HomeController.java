package com.example.demo.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.vladsch.flexmark.util.ast.Node;
import com.vladsch.flexmark.util.builder.Extension;
import com.vladsch.flexmark.ext.tables.TablesExtension;
import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.util.data.MutableDataSet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
//	@RequestMapping("/test")
//	@ResponseBody
//	public String test() {
//		List<Extension> extensions = Arrays.asList(TablesExtension.create());
//
//        Parser parser = Parser.builder().extensions(extensions).build();
//        HtmlRenderer renderer = HtmlRenderer.builder().extensions(extensions).escapeHtml(true).build();
//
//        // You can re-use parser and renderer instances
//        Node document = parser.parse("This is *Sparta*");     
//		String html = renderer.render(document);
//        
//        return html;
//	}
}
