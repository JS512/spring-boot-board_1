package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.Article;

@Mapper
public interface ArticleDao {
	public List<Article> getArticleList(Map<String, Object> param);

	public int getTotalCount(Map<String, Object> param);
	
	public Article getOneArticleById(Map<String, Object> param);
	
	public void addOneArticle(Map<String, Object> param);
	
	public void deleteOneArticle(Map<String, Object> param);
}
