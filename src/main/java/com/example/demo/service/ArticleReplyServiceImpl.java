package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Utils;
import com.example.demo.dao.ArticleDao;
import com.example.demo.dao.ArticleReplyDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleReply;

@Service
public class ArticleReplyServiceImpl implements ArticleReplyService{
	@Autowired
	private ArticleReplyDao articleReplyDao;
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private MemberDao memberDao;
	
	public Map<String, Object> addReply(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		ArticleReply reply = null;
		
		param.put("id", param.get("articleId"));
		Article article = articleDao.getOneArticleById(param);
		try {
			if(article == null) {
				msg = "삭제되었거나 존재하지 않는 게시물입니다.";
				resultCode = "F-1";
			}else {				
				articleReplyDao.addReply(param);
				reply = articleReplyDao.getOneArticleOneReplyByIdArticleIdBoardId(param);
				memberDao.updateMemberExp(param);
				msg = "댓글이 추가 되었습니다.";
				resultCode = "S-1";
			}
		}catch(Exception e) {
			msg = "댓글 추가중 오류 발생.";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode, "reply", reply);
	}
	
	public Map<String, Object> getOneArticleAllReplies(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		List<ArticleReply> replies = null;
		try {
			replies = articleReplyDao.getOneArticleAllReplies(param);			
			if(replies == null || replies.size() == 0) {
				msg = "댓글이 없습니다.";
				resultCode = "F-1";
			}else {
				msg = "댓글 로드 성공.";
				resultCode = "S-1";
			}
		}catch(Exception e) {
			msg = "오류가 발생했습니다.";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode, "replies", replies);
	}
	
	public Map<String, Object> deleteOneArticleOneReplyByIdArticleId(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			ArticleReply reply = articleReplyDao.getOneArticleOneReplyByIdArticleIdBoardId(param);
			if(reply == null) {
				msg = "존재하지 않는 댓글입니다.";
				resultCode = "F-1";
			}else {
				String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
				if((reply.getMemberId() != (int)param.get("loginedMemberId")) && (role == null || !role.equals("admin"))) {
					msg = "권한이 없습니다.";
					resultCode = "F-1";
				}else {
					articleReplyDao.deleteOneArticleOneReplyByIdArticleIdBoardId(param);
					msg = "삭제되었습니다.";
					resultCode = "S-1";
				}
			}
		}catch(Exception e) {
			msg = "댓글 삭제중 오류.";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> modifyReplyByIdArticleIdBoardId(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		ArticleReply reply = null;
		try {
			reply = articleReplyDao.getOneArticleOneReplyByIdArticleIdBoardId(param);

			articleReplyDao.modifyReplyByIdArticleIdBoardId(param);
			reply = articleReplyDao.getOneArticleOneReplyByIdArticleIdBoardId(param);
			msg = "변경 되었습니다.";
			resultCode = "S-1";
			
		}catch(Exception e) {
			msg = "댓글 변경중 오류.";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode, "reply", reply);
	}
	
	public ArticleReply getOneArticleOneReplyByIdArticleIdBoardId(Map<String, Object> param) {
		return articleReplyDao.getOneArticleOneReplyByIdArticleIdBoardId(param);
	}
	
	@Override
	public Map<String, Object> getMemberRepliesByMemberId(Map<String, Object> param) {
		Map<String, Object> page = Utils.calcData(param, articleReplyDao.getReplyTotalCountByMemberId(param));
		List<ArticleReply> list = articleReplyDao.getMemberRepliesByMemberId(param);	
		return Maps.of("list", list, "page", page);
	}
	
	public Map<String, Object> deleteCheckedMemberReply(Map<String, Object> param){
		String msg = "";
		String resultCode = "";		
		Map<String, Object> p = new HashMap<>();
		try {					
			List<Integer> articleIds = (List<Integer>) param.get("articleIds");
			List<Integer> boardIds = (List<Integer>) param.get("boardIds");
			List<Integer> ids = (List<Integer>) param.get("ids");
			
			for(int i=0 ;i<ids.size() ;i++) {
				p.put("id", ids.get(i));
				p.put("articleId", articleIds.get(i));
				p.put("boardId", boardIds.get(i));
				articleReplyDao.deleteOneArticleOneReplyByIdArticleIdBoardId(p);
			}				
				
			msg = "삭제 성공";					
			resultCode = "S-1";
			
		}catch(Exception e) {
			msg = "삭제중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> cancelDeleteOneArticleOneReplyByIdArticleId(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			ArticleReply reply = articleReplyDao.getOneArticleOneReplyByIdArticleIdBoardId(param);
			if(reply == null) {
				msg = "존재하지 않는 댓글입니다.";
				resultCode = "F-1";
			}else {
				String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
				if((reply.getMemberId() != (int)param.get("loginedMemberId")) && (role == null || !role.equals("admin"))) {
					msg = "권한이 없습니다.";
					resultCode = "F-1";
				}else {
					articleReplyDao.cancelDeleteOneArticleOneReplyByIdArticleIdBoardId(param);
					msg = "취소 되었습니다.";
					resultCode = "S-1";
				}
			}
		}catch(Exception e) {
			msg = "댓글 삭제중 오류.";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
}
