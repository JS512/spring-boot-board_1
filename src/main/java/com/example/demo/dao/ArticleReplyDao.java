package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.ArticleReply;

@Mapper
public interface ArticleReplyDao {

	public void addReply(Map<String, Object> param);

	public List<ArticleReply> getOneArticleAllReplies(Map<String, Object> param);

	public ArticleReply getOneArticleOneReplyByIdArticleIdBoardId(Map<String, Object> param);

	public void deleteOneArticleOneReplyByIdArticleIdBoardId(Map<String, Object> param);

	public void modifyReplyByIdArticleIdBoardId(Map<String, Object> param);
	

}
