<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="${boardName }수정 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>



<form onsubmit="articleModify__checkForm(this); return false;" action="/article/doModifyArticle" method="post" enctype="multipart/form-data">
	<input type="hidden" name="id" value="${param.id }">
	<input type="hidden" name="boardId" value="${param.boardId }">
	제목 : <input type="text" name="title" value="${article.title }"><br>
	내용 : <textarea rows="30" cols="60" name="body" >${article.originBody}</textarea><br>
	<button>작성 완료</button>
	<a href="javascript:history.back();">취소</a>
	<button type="button" onclick="articleModify__addFile('body')">파일 추가하기</button>
	<c:forEach items="${files }" var="file">
		<div>
			<img src="/article/showImg?id=${file.id }"><br>
			삭제하기 : <input class="delete" type="checkbox" name="delete" value="${file.id }" onclick="articleModify__check(this);"><br>
			수정하기 : <input class="modify" type="checkbox" name="modify" onclick="articleModify__check(this);"><br>
			<div class="modifyFile" hidden>
				<input type="hidden" name="modifyFileId" value="${file.id }">
				<input type="file" name="modifyFile" onchange="checkFileTypeImg(this);">
				<input class="type2" type="hidden" name="modifyType2" value="">				
			</div>
		</div>
	</c:forEach>
	<div class="fileList">
	</div>
</form>

<%@ include file="../part/foot.jspf" %>