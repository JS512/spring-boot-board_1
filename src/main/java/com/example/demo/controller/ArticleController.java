package com.example.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleFile;
import com.example.demo.service.ArticleFileService;
import com.example.demo.service.ArticleService;

import groovy.util.logging.Slf4j;
import jline.internal.Log;

@Slf4j
@Controller
@RequestMapping("/article")
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleFileService articleFileService;
	@Value("${custom.uploadDir}")
	private String uploadDir;
	
	@RequestMapping("/list")
	public String list(Model model,@RequestParam Map<String, Object> param) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		Map<String, Object> rs = articleService.getArticleList(param);
		
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "article/list";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model,@RequestParam Map<String, Object> param) {
		Article article = articleService.getOneArticleById(param);
		List<ArticleFile> files = articleFileService.getArticleFiles(param);
		
		model.addAttribute("article", article);
		model.addAttribute("files", files);
		
		return "article/detail";
	}
	
	@RequestMapping("/addArticle")
	public String addArticle() {
		return "article/add";
	}
	
	@RequestMapping("/doAddArticle")
	public String doAddArticle(Model model,
							@RequestParam Map<String, Object> param,
							@RequestParam(value="addFiles") List<MultipartFile> files,
							@RequestParam(value="type", required=false) List<String> types,
							@RequestParam(value="type2", required=false) List<String> types2)
	{
		
		String resultCode = "";
		String redirectUrl = "";
		Map<String, Object> rs = null;		
		
		rs = articleService.addOneArticle(param);	
		resultCode = (String) rs.get("resultCode");
		model.addAttribute("msg", rs.get("msg"));
		
		if(!resultCode.startsWith("S-")) {			
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		redirectUrl = "/article/detail?id="+param.get("id")+"&boardId="+param.get("boardId");
		
		if(types != null) {		
			
			rs = articleFileService.addArticleFiles(param, files, types, types2);
			resultCode = (String) rs.get("resultCode");
			model.addAttribute("msg", rs.get("msg"));
			
			if(resultCode.startsWith("S-")) {			
				model.addAttribute("redirectUrl", redirectUrl);
			}else {
				model.addAttribute("historyBack", true);
			}
		}else {
			model.addAttribute("redirectUrl", redirectUrl);
		}
		return "common/redirect";
	}
	
	@RequestMapping("/deleteOneArticle")
	public String deleteOneArticle(Model model, @RequestParam Map<String, Object> param) {
		
		Map<String, Object> rs = articleFileService.deleteOneArticleAllFiles(param);
		String resultCode = (String) rs.get("resultCode");
		if(!resultCode.startsWith("S-")) {
			model.addAttribute("msg", rs.get("msg"));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		rs = articleService.deleteOneArticle(param);
		model.addAttribute("msg", rs.get("msg"));
		resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			StringBuffer redirectUrl = new StringBuffer();
			redirectUrl.append("/article/list?");
			for(String key : param.keySet()) {
				redirectUrl.append(key + "=" + param.get(key) + "&");
			}
			model.addAttribute("redirectUrl", redirectUrl);
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/modifyArticle")
	public String modifyArticle(Model model, @RequestParam Map<String, Object> param) {
		Article article = articleService.getOneArticleById(param);
		List<ArticleFile> files = articleFileService.getArticleFiles(param);
		
		model.addAttribute("article", article);
		model.addAttribute("files", files);
		
		return "article/modify";
	}
	
	@RequestMapping("/doModifyArticle")
	public String doModifyArticle(Model model,
								@RequestParam Map<String, Object> param,
								@RequestParam(value="modifyFile") List<MultipartFile> modifyFiles,
								@RequestParam(value="modifyFileId", required=false) List<Integer> fileIds,
								@RequestParam(value="modifyType2", required=false) List<String> modifyTypes2)
	{
		Map<String, Object> rs = null;
		String resultCode = null;
		if(fileIds != null && fileIds.size() > 0) {
			rs = articleFileService.modifyArticleFiles(param, modifyFiles, fileIds, modifyTypes2);
			model.addAttribute("msg", rs.get("msg"));
			resultCode = (String) rs.get("resultCode");
			
			if(!resultCode.startsWith("S-")) {
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}
		}
		
		rs = articleService.modifyArticle(param);
		
		model.addAttribute("msg", rs.get("msg"));
		resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/article/detail?id="+param.get("id")+"&boardId="+param.get("boardId");
			model.addAttribute("redirectUrl", redirectUrl);
			
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/downloadImg")
	@ResponseBody
	public ResponseEntity<Resource> downloadImg(@RequestParam Map<String, Object> param){
		File target = new File(uploadDir, (String)param.get("fileName"));		
		HttpHeaders header = new HttpHeaders();		
		Resource rs = null;
		
		if(target.exists()) {
			try {				
				String mimeType = Files.probeContentType(Paths.get(target.getAbsolutePath()));			
				
				if(mimeType == null) {
					mimeType = "octet-stream";
				}
				
				rs = new UrlResource(Paths.get(target.getAbsolutePath()).toUri());
				
				header.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+ rs.getFilename() +"\"");				
				header.setContentType(MediaType.parseMediaType(mimeType));
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<Resource>(rs, header, HttpStatus.OK);
	}
	
	@RequestMapping("/showImg")
	@ResponseBody
	public ResponseEntity<Resource> showImg(@RequestParam Map<String, Object> param){
		
		File target = new File(uploadDir, (String)param.get("fileName"));		
		HttpHeaders header = new HttpHeaders();		
		Resource rs = null;
		
		if(target.exists()) {
			try {				
				String mimeType = Files.probeContentType(Paths.get(target.getAbsolutePath()));			
				
				if(mimeType == null) {
					mimeType = "octet-stream";
				}
				
				rs = new UrlResource(Paths.get(target.getAbsolutePath()).toUri());				
								
				header.setContentType(MediaType.parseMediaType(mimeType));
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<Resource>(rs, header, HttpStatus.OK);
	}
	
	
}
