package com.example.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.ArticleFile;

public interface ArticleFileService {

	public Map<String, Object> addArticleFiles(Map<String, Object> param, List<MultipartFile> files, List<String> types,
			List<String> types2);

	public List<ArticleFile> getArticleFiles(Map<String, Object> param);

}
