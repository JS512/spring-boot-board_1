package com.example.demo.service;

import java.util.Map;

public interface ArticleReplyService {

	public Map<String, Object> addReply(Map<String, Object> param);

	public Map<String, Object> getOneArticleAllReplies(Map<String, Object> param);

	public Map<String, Object> deleteOneArticleOneReplyByIdArticleId(Map<String, Object> param);

	public Map<String, Object> modifyReplyByIdArticleIdBoardId(Map<String, Object> param);

}
