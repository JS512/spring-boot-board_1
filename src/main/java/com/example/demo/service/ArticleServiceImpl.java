package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Utils;
import com.example.demo.dao.ArticleDao;
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
	
	public Map<String, Object> getArticleList(Map<String, Object> param){	
		Map<String, Object> page = Utils.calcData(param, articleDao.getTotalCount(param));
		List<Article> list = articleDao.getArticleList(param);
		return Maps.of("list", list, "page", page);
	}
	
	public Article getOneArticleById(Map<String, Object> param) {
		return articleDao.getOneArticleById(param);
	}
	
	public Map<String, Object> addOneArticle(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
			if(Integer.parseInt((String)param.get("boardId")) == 2) {
				if(role != null && role.equals("admin")) {
					articleDao.addOneArticle(param);
					msg = "게시물 등록 성공";
					resultCode = "S-1";
				}else {
					msg = "권한이 없습니다.";
					resultCode = "F-1";
				}
				
			}else {
				articleDao.addOneArticle(param);
				msg = "게시물 등록 성공";
				resultCode = "S-1";
			}
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
			String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
			if(!checkArticleAuthentication(param) && (role == null  || !role.equals("admin"))) {
				msg = "권한이 없습니다.";
				resultCode = "F-1";
			}else {
				articleDao.deleteOneArticle(param);
				msg = "게시물 삭제 성공";
				resultCode = "S-1";
			}
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
			String role = memberDao.getMemberRole((int)param.get("loginedMemberId"));
			if(!checkArticleAuthentication(param)&& ( role == null  || !role.equals("admin"))) {
				msg = "권한이 없습니다.";
				resultCode = "F-1";
			}else {
				articleDao.modifyArticle(param);
				msg = "게시물 수 정 성공";
				resultCode = "S-1";
			}
		}catch(Exception e) {
			msg = "게시물 수정 실패";
			resultCode = "F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public boolean checkArticleAuthentication(Map<String, Object> param) {
		Article article = articleDao.getOneArticleById(param);
		int loginedMemberId = (int)param.get("loginedMemberId");
		
		if(article.getId() != loginedMemberId) {
			return false;
		}else {
			return true;
		}
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
		int value = ((String)param.get("val")).equals("true") ? 1 : -1;
		
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
}
