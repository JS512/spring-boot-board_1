package com.example.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.ArticleFile;

@Mapper
public interface ArticleFileDao {
	public void addArticleFiles(Map<String, Object> param, String type,
			String type2, String[] fileNames);
	
	public List<ArticleFile> getArticleAllFiles(Map<String, Object> param);

	public List<ArticleFile> getArticleFiles(Map<String, Object> param, List<Integer> fileIds);

	public void modifyArticleFiles(Map<String, Object> param, MultipartFile multipartFile, Integer fileId,
			String type2, String[] fileNames);

	public void deleteArticleFiles(Map<String, Object> param, List<Integer> deleteFileIds);
	
}
