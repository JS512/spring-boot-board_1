package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArticleFile {
	private int id;
	private String regDate;
	private int articleId;
	private String prefix;
	private String originFileName;
	private String type;
	private String type2;
}
