package com.example.demo.service;

import java.util.Map;

import com.example.demo.dto.Article;

public interface ArticleService {

	public Map<String,Object> getArticleList(Map<String, Object> param);

	public Article getOneArticleById(Map<String, Object> param);

	public Map<String, Object> addOneArticle(Map<String, Object> param);

	public Map<String, Object> deleteOneArticle(Map<String, Object> param);

	public Map<String, Object> modifyArticle(Map<String, Object> param);	

	public Map<String, Object> getArticleLikes(Map<String, Object> param);

	public Map<String, Object> updateArticleLike(Map<String, Object> param);

	public Map<String, Object> deleteCheckedArticle(Map<String, Object> param);

	public void updateArticleView(Map<String, Object> param);

	public Map<String, Object> getMemberArticlesByMemberId(Map<String, Object> param);

	public Map<String, Object> deleteCheckedMemberArticle(Map<String, Object> param);

	public String getBoardName(Map<String, Object> param);

	public Map<String, Object> cancelDeleteOneArticle(Map<String, Object> param);

}
