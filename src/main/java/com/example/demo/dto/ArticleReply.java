package com.example.demo.dto;

import java.util.Map;

import org.springframework.web.util.HtmlUtils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArticleReply {
	private int id;
	private String regDate;
	private int articleId;
	private int memberId;
	private String body;
	private int boardId;
	private boolean delStatus;
	private boolean blindStatus;
	private Map<String, Object> extra;	
	
	public String getBody() {
		body = HtmlUtils.htmlEscape(body);
		body = body.replaceAll("\n", "<br>");
		body = body.replaceAll("\r\n", "<br>");
		return body.replaceAll(" ", "&nbsp;");		
	}
	
	public String getOriginBody() {
		body = HtmlUtils.htmlEscape(body);
		return body;
	}
}
