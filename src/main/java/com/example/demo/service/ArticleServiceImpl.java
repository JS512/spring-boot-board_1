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
import com.example.demo.dto.Like;

import groovy.util.logging.Slf4j;

@Service
@Slf4j
public class ArticleServiceImpl implements ArticleService{
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private ArticleReplyDao articleReplyDao;
	
	public Map<String, Object> getArticleList(Map<String, Object> param){	
		Map<String, Object> page = Utils.calcData(param, articleDao.getTotalCount(param));
		List<Article> list = articleDao.getArticleList(param);
		String boardName = articleDao.getBoardName(param);
		return Maps.of("list", list, "page", page, "boardName", boardName);
	}
	
	public Article getOneArticleById(Map<String, Object> param) {
		return articleDao.getOneArticleById(param);
	}
	
	public Map<String, Object> addOneArticle(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
				articleDao.addOneArticle(param);
				msg = "게시물 등록 성공";
				resultCode = "S-1";

		}catch(Exception e) {
			msg = "게시물 등록 실패";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> deleteOneArticle(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			articleDao.deleteOneArticle(param);			
			msg = "게시물 삭제 성공";
			resultCode = "S-1";
			
		}catch(Exception e) {
			msg = "게시물 삭제 실패";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> modifyArticle(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			
			articleDao.modifyArticle(param);
			msg = "게시물 수 정 성공";
			resultCode = "S-1";
		
		}catch(Exception e) {
			msg = "게시물 수정 실패";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}	
	
	public Map<String, Object> getArticleLikes(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		int likeCount = 0;
		int disLikeCount = 0;
		String checkType = "";
		try {
			List<Integer> likes = articleDao.getArticleLikes(param);
			
			if(likes != null) {
				if(likes.size() == 1) {
					if(likes.get(0) > 0) {
						likeCount = likes.get(0);
					}else {
						disLikeCount = likes.get(0);
					}
				}else if(likes.size() == 2) {
					if(likes.get(0) > 0) {
						likeCount = likes.get(0);
						disLikeCount = likes.get(1);
					}else {
						likeCount = likes.get(1);
						disLikeCount = likes.get(0);
					}
				}
			}
			Like like = articleDao.getArticleLikeByMemberId(param);
			if(like == null) {
				checkType = null;
			}else {
				if(like.getVal() > 0) {
					checkType = "like";
				}else {
					checkType = "disLike";
				}
			}
			msg = "로드 성공";
			resultCode = "S-1";
		}catch(Exception e) {
			msg = "좋아요 로드중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode, "like", likeCount, "disLike", disLikeCount, "checkType", checkType);
	}
	
	public Map<String, Object> updateArticleLike(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		int value = Boolean.parseBoolean((String)param.get("val")) ? 1 : -1;
		
		try {
			param.put("val", value);
			Like like = articleDao.getArticleLikeByMemberId(param);
			
			if(like == null) {				
				articleDao.addArticleLike(param);
				msg = "적용 성공";
			}else {				
				if(value == like.getVal()) {
					articleDao.deleteArticleLike(param);
					msg = "취소 성공";
				}else{					
					articleDao.updateArticleLike(param);
					msg = "변경 성공";
				}
			}			
			resultCode = "S-1";
		}catch(Exception e) {
			msg = "좋아요 로드중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> deleteCheckedArticle(Map<String, Object> param){
		
		String msg = "";
		String resultCode = "";		
		Map<String, Object> p = new HashMap<>();
		try {					
			List<Integer> ids = (List<Integer>) param.get("ids");
			for(int i=0 ;i<ids.size() ;i++) {
				param.put("id", ids.get(i));
				articleDao.deleteOneArticle(param);
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
	
	public void updateArticleView(Map<String, Object> param) {
		articleDao.updateArticleView(param);
	}
	
	public Map<String, Object> getMemberArticlesByMemberId(Map<String, Object> param) {
		Map<String, Object> page = Utils.calcData(param, articleDao.getArticleTotalCountByMemberId(param));
		List<Article> list = articleDao.getMemberArticlesByMemberId(param);		
		return Maps.of("list", list, "page", page);
	}
	
	public Map<String, Object> deleteCheckedMemberArticle(Map<String, Object> param){
		String msg = "";
		String resultCode = "";		
		Map<String, Object> p = new HashMap<>();
		try {				
			
			List<Integer> boardIds = (List<Integer>) param.get("boardIds");
			List<Integer> ids = (List<Integer>) param.get("ids");
			
			for(int i=0 ;i<ids.size() ;i++) {
				p.put("id", ids.get(i));				
				p.put("boardId", boardIds.get(i));
				articleDao.deleteOneArticle(p);
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
	public String getBoardName(Map<String, Object> param) {
		return articleDao.getBoardName(param);
	}

	@Override
	public Map<String, Object> cancelDeleteOneArticle(Map<String, Object> param) {
		// TODO Auto-generated method stub		
		String msg = "";
		String resultCode = "";
		try {
			articleDao.cancelDeleteOneArticle(param);	
			msg = "게시물 삭제 성공";
			resultCode = "S-1";
			
		}catch(Exception e) {
			msg = "게시물 삭제 실패";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
}
