package com.example.demo.dto;

import java.util.Map;

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
}
