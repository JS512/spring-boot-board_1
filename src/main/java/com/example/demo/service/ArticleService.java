package com.example.demo.service;

import java.util.List;
import java.util.Map;

import com.example.demo.dto.Article;

public interface ArticleService {

	public List<Article> getArticleList(Map<String, Object> param);

}
