package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleReply;
import com.example.demo.dto.Like;

@Mapper
public interface ArticleDao {
	public List<Article> getArticleList(Map<String, Object> param);

	public int getTotalCount(Map<String, Object> param);
	
	public Article getOneArticleById(Map<String, Object> param);
	
	public void addOneArticle(Map<String, Object> param);
	
	public void deleteOneArticle(Map<String, Object> param);
	
	public void modifyArticle(Map<String, Object> param);

	public List<Integer> getArticleLikes(Map<String, Object> param);

	public Like getArticleLikeByMemberId(Map<String, Object> param);

	public void addArticleLike(Map<String, Object> param);

	public void deleteArticleLike(Map<String, Object> param);

	public void updateArticleLike(Map<String, Object> param);

	public void updateArticleView(Map<String, Object> param);

	public List<Article> getMemberArticlesByMemberId(Map<String, Object> param);

	public int getArticleTotalCountByMemberId(Map<String, Object> param);	
}
