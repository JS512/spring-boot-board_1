<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="${boardName } 글쓰기 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>



<form onsubmit="articleAdd__checkForm(this); return false;" action="/admin/doAddArticle" method="post" enctype="multipart/form-data">
	<input type="hidden" name="boardId" value="${param.boardId }">
	제목 : <input type="text" name="title"><br>
	내용 : <textarea rows="30" cols="60" name="body"></textarea><br>
	<button>작성 완료</button>
	<a href="javascript:history.back();">취소</a><br>
	<button type="button" onclick="articleAdd__addFile('body')">파일 추가하기</button>
	<div class="fileList">
		
	</div>
</form>

<%@ include file="../admin_part/admin_foot.jspf" %>