package com.example.demo.service;

import java.util.List;
import java.util.Map;

import com.example.demo.dto.ArticleReply;

public interface ArticleReplyService {

	public Map<String, Object> addReply(Map<String, Object> param);

	public Map<String, Object> getOneArticleAllReplies(Map<String, Object> param);

	public Map<String, Object> deleteOneArticleOneReplyByIdArticleId(Map<String, Object> param);

	public Map<String, Object> modifyReplyByIdArticleIdBoardId(Map<String, Object> param);

	public ArticleReply getOneArticleOneReplyByIdArticleIdBoardId(Map<String, Object> param);

	public Map<String, Object> getMemberRepliesByMemberId(Map<String, Object> param);

	public Map<String, Object> deleteCheckedMemberReply(Map<String, Object> param);

}
