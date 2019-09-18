package com.example.demo.dto;

import java.util.Arrays;
import java.util.Map;

import org.springframework.web.util.HtmlUtils;

import com.vladsch.flexmark.ext.gfm.strikethrough.StrikethroughExtension;
import com.vladsch.flexmark.ext.tables.TablesExtension;
import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.util.ast.Node;
import com.vladsch.flexmark.util.data.MutableDataSet;

import jline.internal.Log;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String title;
	private String body;
	private int memberId;
	private int boardId;
	private int view;
	private boolean delStatus;
	private boolean blindStatus;
	private Map<String, Object> extra;

	
	public String getBody() {		
		MutableDataSet options = new MutableDataSet();
		
        options.set(Parser.EXTENSIONS, Arrays.asList(TablesExtension.create(), StrikethroughExtension.create()));
        options.set(Parser.HARD_LINE_BREAK_LIMIT, true);

        Parser parser = Parser.builder(options).build();
        HtmlRenderer renderer = HtmlRenderer.builder(options).escapeHtml(true).build();

        Node document = parser.parse(body);
        body = renderer.render(document);   
        
        
		return body;		
	}
	
	
	public String getOriginBody() {
		body = HtmlUtils.htmlEscape(body);
		return body;
	}
	
	public String getTitle() {
		title = HtmlUtils.htmlEscape(title);
		return title;
	}
	
}
