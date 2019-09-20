package com.example.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.groovy.util.Maps;
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

import com.example.demo.Utils;
import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleFile;
import com.example.demo.dto.ArticleReply;
import com.example.demo.service.ArticleFileService;
import com.example.demo.service.ArticleReplyService;
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
	@Autowired
	private ArticleReplyService articleReplyService;	
	@Value("${custom.uploadDir}")
	private String uploadDir;
	
	@RequestMapping("/list")
	public String list(Model model,@RequestParam Map<String, Object> param, HttpServletRequest request) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		
		
		if(!Utils.needParamCheck(param, new String[] {"boardId", "cPage"}) || !Utils.isNumeric(param, new String[] {"boardId", "cPage"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}	
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object> rs = articleService.getArticleList(param);
		
		model.addAttribute("boardName", rs.get("boardName"));
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "article/list";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model,@RequestParam Map<String, Object> param) {
		
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		
		if(!Utils.needParamCheck(param, new String[] {"id", "cPage", "boardId"}) || !Utils.isNumeric(param, new String[] {"id","boardId", "cPage"})) {			
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		if(!checkArticleIsAccepted(param)) {
			model.addAttribute("msg", param.get("msg"));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		Article article = articleService.getOneArticleById(param);
		List<ArticleFile> files = articleFileService.getArticleFiles(param);
		
		
		model.addAttribute("boardName", articleService.getBoardName(param));
		model.addAttribute("article", article);
		model.addAttribute("files", files);
		
		return "article/detail";
	}
	
	@RequestMapping("/addArticle")
	public String addArticle(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		
		if(!Utils.needParamCheck(param, new String[] {"boardId"}) || !Utils.isNumeric(param, new String[] {"boardId"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}	
		
		
		if(!checkAcceptBoardId(param)) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", param.get("msg"));
			return "common/redirect";
		}
		model.addAttribute("boardName", articleService.getBoardName(param));
		return "article/add";
	}
	
	@RequestMapping("/doAddArticle")
	public String doAddArticle(Model model, HttpServletRequest request,
							@RequestParam Map<String, Object> param,
							@RequestParam(value="addFiles") List<MultipartFile> files,
							@RequestParam(value="type", required=false) List<String> types,
							@RequestParam(value="type2", required=false) List<String> types2)
	{	
		HttpSession session = request.getSession();
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		if(!Utils.needParamCheck(param, new String[] {"boardId"}) || !Utils.isNumeric(param, new String[] {"boardId"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		if(!checkAcceptBoardId(param)) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", param.get("msg"));
			return "common/redirect";
		}
		
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
	public String deleteOneArticle(Model model, @RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {		
		if(!Utils.needParamCheck(param, new String[] {"boardId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "id"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
		
		if(!checkAcceptBoardId(param) || !checkArticleAuthentication(param)) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", param.get("msg"));
			return "common/redirect";
		}		
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object >rs = articleService.deleteOneArticle(param);
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			param.remove("role");
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
	public String modifyArticle(Model model, @RequestParam Map<String, Object> param, HttpSession session) {
		if(!Utils.needParamCheck(param, new String[] {"boardId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "id"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
		if(!checkAcceptBoardId(param) || !checkArticleAuthentication(param)) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", param.get("msg"));
			return "common/redirect";
		}
		
		Article article = articleService.getOneArticleById(param);
		List<ArticleFile> files = articleFileService.getArticleFiles(param);
		
		model.addAttribute("boardName", articleService.getBoardName(param));
		model.addAttribute("article", article);
		model.addAttribute("files", files);
		
		return "article/modify";
	}
	
	@RequestMapping("/doModifyArticle")
	public String doModifyArticle(Model model, HttpSession session,
								@RequestParam Map<String, Object> param,
								@RequestParam(value="modifyFile") List<MultipartFile> modifyFiles,
								@RequestParam(value="modifyFileId", required=false) List<Integer> fileIds,
								@RequestParam(value="modifyType2", required=false) List<String> modifyTypes2,
								@RequestParam(value="delete", required=false) List<Integer> deleteFileIds,
								@RequestParam(value="addFiles") List<MultipartFile> files,
								@RequestParam(value="type", required=false) List<String> types,
								@RequestParam(value="type2", required=false) List<String> types2)
	{
		if(!Utils.needParamCheck(param, new String[] {"boardId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "id"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
		if(!checkAcceptBoardId(param) || !checkArticleAuthentication(param)) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", param.get("msg"));
			return "common/redirect";
		}
		
		Map<String, Object> rs = null;
		String resultCode = null;			
		
		rs = articleService.modifyArticle(param);
		
		model.addAttribute("msg", rs.get("msg"));
		resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/article/detail?id="+param.get("id")+"&boardId="+param.get("boardId");
			model.addAttribute("redirectUrl", redirectUrl);
			
		}else {
			model.addAttribute("historyBack", true);
			
			return "common/redirect";
		}
		
		if(deleteFileIds != null && deleteFileIds.size() > 0) {
			rs = articleFileService.deleteArticleFiles(param, deleteFileIds);			
			resultCode = (String) rs.get("resultCode");
			
			if(!resultCode.startsWith("S-")) {
				model.addAttribute("msg", rs.get("msg"));
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}
		}
		
		if(fileIds != null && fileIds.size() > 0) {			
			rs = articleFileService.modifyArticleFiles(param, modifyFiles, fileIds, modifyTypes2);			
			resultCode = (String) rs.get("resultCode");
			
			if(!resultCode.startsWith("S-")) {
				model.addAttribute("msg", rs.get("msg"));
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}
		}
		
		if(files != null && files.size() > 0) {
			rs = articleFileService.addArticleFiles(param, files, types, types2);			
			resultCode = (String) rs.get("resultCode");
			
			if(!resultCode.startsWith("S-")) {
				model.addAttribute("msg", rs.get("msg"));
				model.addAttribute("historyBack", true);
				return "common/redirect";
			}
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/downloadImg")
	@ResponseBody
	public ResponseEntity<Resource> downloadImg(@RequestParam Map<String, Object> param){

		ArticleFile file = articleFileService.getArticleOneFile(param);
		
		File target = new File(uploadDir, file.getPrefix() + file.getOriginFileName());		
		HttpHeaders header = new HttpHeaders();		
		Resource rs = null;
		
		if(target.exists()) {
			try {				
				String mimeType = Files.probeContentType(Paths.get(target.getAbsolutePath()));			
				
				if(mimeType == null) {
					mimeType = "octet-stream";
				}
				
				rs = new UrlResource(target.toURI());
				
				header.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+ rs.getFilename() +"\"");
				header.add(HttpHeaders.TRANSFER_ENCODING, "binary");
				header.setCacheControl("no-cache");
				header.setContentType(MediaType.parseMediaType(mimeType));
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<Resource>(rs, header, HttpStatus.OK);
	}
	
	@RequestMapping("/showImg")
	@ResponseBody
	public ResponseEntity<Resource> showImg(@RequestParam Map<String, Object> param, HttpServletRequest request){		
		
		ArticleFile file = articleFileService.getArticleOneFile(param);
		
		File target = new File(uploadDir, file.getPrefix() + file.getOriginFileName());		
		HttpHeaders header = new HttpHeaders();		
		Resource rs = null;
		
		if(target.exists()) {
			try {				
				String mimeType = Files.probeContentType(Paths.get(target.getAbsolutePath()));			
				
				if(mimeType == null) {
					mimeType = "octet-stream";
				}
				
				rs = new UrlResource(target.toURI());				
								
				header.setContentType(MediaType.parseMediaType(mimeType));				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<Resource>(rs, header, HttpStatus.OK);
	}
	
	@RequestMapping("/addReply")
	@ResponseBody
	public Map<String, Object> addReply(HttpSession session, @RequestParam Map<String, Object> param){
		
		if(!Utils.needParamCheck(param, new String[] {"boardId", "articleId", "body"}) || !Utils.isNumeric(param, new String[] {"boardId", "articleId"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));	
		
		Map<String, Object> rs = articleReplyService.addReply(param);		
		
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success, "reply", rs.get("reply"));
	}
	
	@RequestMapping("/getOneArticleAllReplies")
	@ResponseBody
	public Map<String, Object> getOneArticleAllReplies(@RequestParam Map<String, Object> param, HttpServletRequest request){
		
		if(!Utils.needParamCheck(param, new String[] {"boardId", "articleId"}) || !Utils.isNumeric(param, new String[] {"boardId", "articleId"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}		
		
		Map<String, Object> rs = articleReplyService.getOneArticleAllReplies(param);
		
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}	
		
		return Maps.of("msg", rs.get("msg"), "replies", rs.get("replies"), "success", success);
	}
	
	@RequestMapping("/deleteOneArticleOneReply")
	@ResponseBody
	public Map<String, Object> deleteOneArticleOneReply(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request){
		
		if(!Utils.needParamCheck(param, new String[] {"boardId", "articleId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "articleId", "id"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
		if(!checkAcceptBoardId(param) || !checkArticleReplyAuthentication(param)) {
			return Maps.of("msg", param.get("msg"), "success", false);
		}
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object> rs = articleReplyService.deleteOneArticleOneReplyByIdArticleId(param);
		
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);
	}
	
	@RequestMapping("/modifyReply")
	@ResponseBody
	public Map<String, Object> modifyReply(@RequestParam Map<String, Object> param, HttpSession session){
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
		if(!Utils.needParamCheck(param, new String[] {"boardId", "articleId", "id", "body"}) || !Utils.isNumeric(param, new String[] {"boardId", "articleId", "id"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		
		if(!checkArticleReplyAuthentication(param)) {
			return Maps.of("msg", param.get("msg"), "success", false);
		}
		Map<String, Object> rs = articleReplyService.modifyReplyByIdArticleIdBoardId(param);
		
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success, "reply", rs.get("reply"));
	}
	
	@RequestMapping("/getLikes")
	@ResponseBody
	public Map<String, Object> getLikes(@RequestParam Map<String, Object> param, HttpSession session){
		if(!Utils.needParamCheck(param, new String[] {"boardId", "relId", "type"}) || !Utils.isNumeric(param, new String[] {"boardId", "relId"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));		
		
		Map<String, Object> rs = new HashMap<>();		
		rs = articleService.getArticleLikes(param);

		boolean success = false;
		String resultCode = (String)rs.get("resultCode");

		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success, "disLike", rs.get("disLike"), "like", rs.get("like"), "checkType", rs.get("checkType"));
	}
	
	@RequestMapping("/updateLike")
	@ResponseBody
	public Map<String, Object> updateLike(@RequestParam Map<String, Object> param, HttpSession session){
		
		if(!Utils.needParamCheck(param, new String[] {"boardId", "relId", "val", "type"}) || !Utils.isNumeric(param, new String[] {"boardId", "relId"})	) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));		
		
		Map<String, Object> rs = new HashMap<>();		
		rs = articleService.updateArticleLike(param);

		boolean success = false;
		String resultCode = (String)rs.get("resultCode");

		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);
	}
	
	@RequestMapping("/getMemberArticles")
	public String getmemberArticles(Model model, @RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		if(!Utils.isNumeric(param, new String[] {"cPage"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		param.put("memberId", session.getAttribute("loginedMemberId"));
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object> rs = articleService.getMemberArticlesByMemberId(param);
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "member/memberArticle";
	}
	
	@RequestMapping("/getMemberReplies")
	public String getMemberReplies(Model model, @RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		if(!Utils.isNumeric(param, new String[] {"cPage"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		param.put("memberId", session.getAttribute("loginedMemberId"));
		param.put("role", (String)request.getAttribute("role"));
		Map<String , Object> rs = articleReplyService.getMemberRepliesByMemberId(param);
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "member/memberReply";
	}
	
	@RequestMapping("/addViewCnt")
	@ResponseBody
	public Map<String, Object> addViewCnt(@RequestParam Map<String, Object> param) {
		if(!Utils.needParamCheck(param, new String[] {"boardId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "id"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		boolean success = false;
		try {
			Article article = articleService.getOneArticleById(param);
			if(article != null && !article.isDelStatus()) {
				articleService.updateArticleView(param);
				success = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return Maps.of("success", success);
	}
	
	private boolean checkAcceptBoardId(Map<String, Object> param) {
		String boardId = (String) param.get("boardId");
		String msg = null;
		try {
			int id = Integer.parseInt(boardId);
			if(id == 1) {
				msg = "권한이 없습니다.";							
			}else {
				return true;
			}
		}catch(Exception e) {
			msg = "오류가 발생했습니다.";			
		}
		param.put("msg", msg);
		return false;
	}
	
	private boolean checkArticleAuthentication(Map<String, Object> param) {
		Article article = articleService.getOneArticleById(param);		
		String msg = null;
		
		if(article == null) {
			msg = "존재하지 않는 게시물 입니다.";
			
		}else if(article.isBlindStatus()){
			msg = "관리자에 의해서 블라인드 처리된 게시물 입니다.";
		}else if(article.isDelStatus()){
			msg = "삭제된 게시물 입니다.";
			
		}else if(article.getMemberId() != (int)param.get("loginedMemberId") || article.getBoardId() == 1){
			msg = "권한이 없습니다.";
			
		}else {
			return true;
		}
		param.put("msg", msg);
		return false;
	}
	
	private boolean checkArticleReplyAuthentication(Map<String, Object> param) {
		ArticleReply reply = articleReplyService.getOneArticleOneReplyByIdArticleIdBoardId(param);
		String msg = null;
		if(reply == null) {
			msg = "존재하지 않는 댓글 입니다.";
			
		}else if(reply.isBlindStatus()){
			msg = "관리자에 의해서 블라인드 처리된 댓글 입니다.";
		}else if(reply.isDelStatus()){
			msg = "삭제된 댓글 입니다.";
			
		}else if(reply.getMemberId() != (int)param.get("loginedMemberId")){
			msg = "권한이 없습니다.";
			
		}else {
			return true;
		}
		param.put("msg", msg);
		return false;
	}
	
	private boolean checkArticleIsAccepted(Map<String, Object> param) {
		Article article = articleService.getOneArticleById(param);		
		String msg = null;
		
		if(article == null) {			
			msg = "존재하지 않는 게시물 입니다.";			
		}else if(article.isBlindStatus()){			
			msg = "관리자에 의해서 블라인드 처리된 게시물 입니다.";
		}else if(article.isDelStatus()) {			
			msg = "삭제된 게시물 입니다.";
		}else {
			return true;
		}
		param.put("msg", msg);
		return false;
	}
	
}
