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
import com.example.demo.service.ArticleFileService;
import com.example.demo.service.ArticleReplyService;
import com.example.demo.service.ArticleService;

@Controller
@RequestMapping("/admin")
public class AdminArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleFileService articleFileService;
	@Autowired
	private ArticleReplyService articleReplyService;
	
	@Value("${custom.uploadDir}")
	private String uploadDir;
	
	@RequestMapping("/articleList")
	public String articleList(Model model,@RequestParam Map<String, Object> param, HttpServletRequest request) {
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
		
		return "admin/admin_article/admin_list";
	}
	
	@RequestMapping("/articleDetail")
	public String articleDetail(Model model,@RequestParam Map<String, Object> param) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		
		if(!Utils.needParamCheck(param, new String[] {"id", "boardId", "cPage"}) || !Utils.isNumeric(param, new String[] {"id", "boardId", "cPage"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		Article article = articleService.getOneArticleById(param);
		List<ArticleFile> files = articleFileService.getArticleFiles(param);
		
		model.addAttribute("boardName", articleService.getBoardName(param));
		model.addAttribute("article", article);
		model.addAttribute("files", files);
		
		return "admin/admin_article/admin_detail";
	}
	
	@RequestMapping("/addArticle")
	public String addArticle(Model model, @RequestParam Map<String, Object> param) {
		model.addAttribute("boardName", articleService.getBoardName(param));
		if(!Utils.needParamCheck(param, new String[] {"boardId"}) || !Utils.isNumeric(param, new String[] {"boardId"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		return "admin/admin_article/admin_add";
	}
	
	@RequestMapping("/doAddArticle")
	public String doAddArticle(Model model, HttpServletRequest request,
			@RequestParam Map<String, Object> param,
			@RequestParam(value="addFiles") List<MultipartFile> files,
			@RequestParam(value="type", required=false) List<String> types,
			@RequestParam(value="type2", required=false) List<String> types2) {
		
		if(!Utils.needParamCheck(param, new String[] {"boardId"}) || !Utils.isNumeric(param, new String[] {"boardId"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		HttpSession session = request.getSession();
		String resultCode = "";
		String redirectUrl = "";
		Map<String, Object> rs = null;		
		param.put("loginedMemberId", (int)session.getAttribute("loginedMemberId"));
		rs = articleService.addOneArticle(param);	
		resultCode = (String) rs.get("resultCode");
		model.addAttribute("msg", rs.get("msg"));
		
		if(!resultCode.startsWith("S-")) {			
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		redirectUrl = "/admin/articleDetail?id="+param.get("id")+"&boardId="+param.get("boardId");
		
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
		
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object >rs = articleService.deleteOneArticle(param);
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			param.remove("role");
			StringBuffer redirectUrl = new StringBuffer();
			redirectUrl.append("/admin/articleDetail?");
			for(String key : param.keySet()) {
				redirectUrl.append(key + "=" + param.get(key) + "&");
			}
			model.addAttribute("redirectUrl", redirectUrl);
		}else {
			model.addAttribute("historyBack", true);
		}
		
		return "common/redirect";
	}
	
	@RequestMapping("/cancelDeleteOneArticle")
	public String cancelDeleteOneArticle(Model model, @RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		if(!Utils.needParamCheck(param, new String[] {"boardId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "id"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));		
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object >rs = articleService.cancelDeleteOneArticle(param);
		model.addAttribute("msg", rs.get("msg"));
		String resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			param.remove("role");
			StringBuffer redirectUrl = new StringBuffer();
			redirectUrl.append("/admin/articleList?");
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
		
		Article article = articleService.getOneArticleById(param);
		List<ArticleFile> files = articleFileService.getArticleFiles(param);
		
		model.addAttribute("boardName", articleService.getBoardName(param));
		model.addAttribute("article", article);
		model.addAttribute("files", files);
		
		return "admin/admin_article/admin_modify";
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
		
		Map<String, Object> rs = null;
		String resultCode = null;			
		
		rs = articleService.modifyArticle(param);
		
		model.addAttribute("msg", rs.get("msg"));
		resultCode = (String) rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			String redirectUrl = "/admin/articleDetail?id="+param.get("id")+"&boardId="+param.get("boardId");
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
	public Map<String, Object> getOneArticleAllReplies(@RequestParam Map<String, Object> param,HttpServletRequest request){		
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
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object> rs = articleReplyService.deleteOneArticleOneReplyByIdArticleId(param);
		
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");
		
		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);
	}
	
	@RequestMapping("/cancelDeleteOneArticleOneReply")
	@ResponseBody
	public Map<String, Object> cancelDeleteOneArticleOneReply(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request){
		if(!Utils.needParamCheck(param, new String[] {"boardId", "articleId", "id"}) || !Utils.isNumeric(param, new String[] {"boardId", "articleId", "id"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
		
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object> rs = articleReplyService.cancelDeleteOneArticleOneReplyByIdArticleId(param);
		
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
		if(!Utils.needParamCheck(param, new String[] {"boardId", "articleId", "id", "body"}) || !Utils.isNumeric(param, new String[] {"boardId", "articleId", "id"})) {			
			return Maps.of("msg", "잘못된 접근", "success", false);
		}
		
		param.put("loginedMemberId", session.getAttribute("loginedMemberId"));
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
		if(!Utils.needParamCheck(param, new String[] {"boardId", "relId", "val", "type"}) || !Utils.isNumeric(param, new String[] {"boardId", "relId"})) {			
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
	
	@RequestMapping("/deleteCheckedArticle")
	@ResponseBody
	public Map<String, Object> deleteCheckedArticle(@RequestParam Map<String, Object> param,
													@RequestParam(value="id[]") List<Integer> ids,
													HttpServletRequest request){
		
		param.put("ids", ids);
		param.put("role", request.getAttribute("role"));
		Map<String, Object> rs = articleService.deleteCheckedArticle(param);		
				
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");		

		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);		
	}
	
	@RequestMapping("/getMemberArticles")
	public String getmemberArticles(Model model, @RequestParam Map<String, Object> param, HttpServletRequest request) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		if(!Utils.isNumeric(param, new String[] {"cPage"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}else if(!Utils.needParamCheck(param, new String[] {"memberId"}) || !Utils.isNumeric(param, new String[] {"memberId"})) {
			param.put("memberId", request.getSession().getAttribute("loginedMemberId"));
		}
		param.put("role", (String)request.getAttribute("role"));
		Map<String, Object> rs = articleService.getMemberArticlesByMemberId(param);
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "admin/admin_member/admin_member_article";
	}
	
	@RequestMapping("/getMemberReplies")
	public String getMemberReplies(Model model, @RequestParam Map<String, Object> param, HttpServletRequest request) {
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		if(!Utils.isNumeric(param, new String[] {"cPage"})) {
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}else if(!Utils.needParamCheck(param, new String[] {"memberId"}) || !Utils.isNumeric(param, new String[] {"memberId"})) {
			param.put("memberId", request.getSession().getAttribute("loginedMemberId"));
		}
		param.put("role", (String)request.getAttribute("role"));
		Map<String , Object> rs = articleReplyService.getMemberRepliesByMemberId(param);
		model.addAttribute("list", rs.get("list"));
		model.addAttribute("page", rs.get("page"));
		
		return "admin/admin_member/admin_member_reply";
	}
	
	@RequestMapping("/deleteCheckedMemberReply")
	@ResponseBody
	public Map<String, Object> deleteCheckedMemberReply(@RequestParam Map<String, Object> param,
													@RequestParam(value="id[]") List<Integer> ids,
													@RequestParam(value="articleId[]") List<Integer> articleIds,
													@RequestParam(value="boardId[]") List<Integer> boardIds){
		
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}
		
		param.put("articleIds", articleIds);
		param.put("boardIds", boardIds);
		param.put("ids", ids);
		Map<String, Object> rs = articleReplyService.deleteCheckedMemberReply(param);		
				
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");		

		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);		
	}
	
	@RequestMapping("/deleteCheckedMemberArticle")
	@ResponseBody
	public Map<String, Object> deleteCheckedMemberArticle(@RequestParam Map<String, Object> param,
													@RequestParam(value="id[]") List<Integer> ids,													
													@RequestParam(value="boardId[]") List<Integer> boardIds){
		
		if(param.get("cPage") == null || param.get("cPage").equals("")) {
			param.put("cPage", 1);
		}	
		
		param.put("boardIds", boardIds);
		param.put("ids", ids);
		Map<String, Object> rs = articleService.deleteCheckedMemberArticle(param);		
				
		boolean success = false;
		String resultCode = (String)rs.get("resultCode");		

		if(resultCode.startsWith("S-")) {
			success = true;
		}
		
		return Maps.of("msg", rs.get("msg"), "success", success);		
	}
}
