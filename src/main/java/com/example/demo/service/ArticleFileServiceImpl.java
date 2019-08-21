package com.example.demo.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.groovy.util.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.ArticleFileDao;
import com.example.demo.dto.ArticleFile;

@Service
public class ArticleFileServiceImpl implements ArticleFileService{
	@Autowired
	private ArticleFileDao articleFileDao;
	@Value("${custom.uploadDir}")
	private String uploadDir;
	
	public Map<String, Object> addArticleFiles(Map<String, Object> param, List<MultipartFile> files, List<String> types,
			List<String> types2){
		String msg = "";
		String resultCode = "";
		try {
			List<String[]> fileNames = uploadFiles(files);
			for(int i = 0 ;i<files.size() ;i++)
				articleFileDao.addArticleFiles(param, types.get(i), types2.get(i), fileNames.get(i));
			msg = "등록 성공";
			resultCode = "S-1";
		} catch (Exception e) {
			msg = "등록 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public List<ArticleFile> getArticleFiles(Map<String, Object> param){
		return articleFileDao.getArticleAllFiles(param);
	}
	
	public Map<String, Object> deleteOneArticleAllFiles(Map<String, Object> param){
		String msg = "";
		String resultCode = "";
		try {
			deleteArticleFiles(articleFileDao.getArticleAllFiles(param));			
			resultCode = "S-1";
		} catch (Exception e) {
			msg = "파일 삭제 중 오류";
			resultCode = "F-1";
			e.printStackTrace();
		}
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> modifyArticleFiles(Map<String, Object> param, List<MultipartFile> modifyFiles,
			List<Integer> fileIds, List<String> modifyTypes2)
	{
		String msg = "";
		String resultCode = "";
		
		List<ArticleFile> files = articleFileDao.getArticleFiles(param ,fileIds);
		deleteArticleFiles(files);
		
		try {
			List<String[]> fileNames = uploadFiles(modifyFiles);
			for(int i=0 ;i<fileNames.size() ;i++) {
				articleFileDao.modifyArticleFiles(param, modifyFiles.get(i), fileIds.get(i), modifyTypes2.get(i), fileNames.get(i));
			}
			msg="파일 수정 성공";
			resultCode="S-1";
		} catch (Exception e) {
			msg="파일 수정 실패";
			resultCode="F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
	}
	
	public Map<String, Object> deleteArticleFiles(Map<String, Object> param, List<Integer> deleteFileIds){
		String msg = "";
		String resultCode = "";
		
		List<ArticleFile> files = articleFileDao.getArticleFiles(param ,deleteFileIds);
		
		try {
			deleteArticleFiles(files);
			articleFileDao.deleteArticleFiles(param, deleteFileIds);
			msg="파일 수정 성공";
			resultCode="S-1";
		} catch (Exception e) {
			msg="파일 수정 실패";
			resultCode="F-1";
			e.printStackTrace();
		}
		
		return Maps.of("msg", msg, "resultCode", resultCode);
		
	}
	
	private void deleteArticleFiles(List<ArticleFile> articleFiles) {
		for(ArticleFile file : articleFiles) {
			File target = new File(uploadDir, file.getPrefix() + file.getOriginFileName());
			if(target.exists()) {
				target.delete();
			}
		}		
	}

	private List<String[]> uploadFiles(List<MultipartFile> files) throws Exception{
		List<String[]> fileNames = new ArrayList<>();
		for(MultipartFile file : files) {
			String[] names = new String[2];
			names[0] = UUID.randomUUID() + "-";
			names[1] = file.getOriginalFilename();			
			
			File target = new File(uploadDir, names[0] + names[1]);
			FileOutputStream fos = new FileOutputStream(target);
			fos.write(file.getBytes());
			fos.close();
			
			fileNames.add(names);							
		}
		
		return fileNames;
	}
}
