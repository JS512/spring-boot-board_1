package com.example.demo.service;

import java.util.Map;

import com.example.demo.dto.Article;

public interface ArticleService {

	public Map<String,Object> getArticleList(Map<String, Object> param);

	public Article getOneArticleById(Map<String, Object> param);

	public Map<String, Object> addOneArticle(Map<String, Object> param);

	public Map<String, Object> deleteOneArticle(Map<String, Object> param);

	public Map<String, Object> modifyArticle(Map<String, Object> param);

}
