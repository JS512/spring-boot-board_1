<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="${boardName } 상세 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<a href="/admin/articleList${url }&cPage=${param.cPage}">목록으로</a>


<a href="javascript:articleDetail__deleteArticleCheck(${article.id }, ${param.boardId })">삭제하기</a>
<a href="javascript:articleDetail__modifyArticleCheck(${article.id }, ${param.boardId })">수정하기</a>


<input type="hidden" id="boardId" value="${article.boardId}">

<table class="article">
	<tr>
		<td><button data-type="article" class="like" type="button" onclick="articleDetail__updateLike(this, true);">좋아요</button> <span>0</span></td>
		<td><button data-type="article" class="like" type="button" onclick="articleDetail__updateLike(this, false);">싫어요</button> <span>0</span></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td>${article.view }</td>
	</tr>
	<tr>
    	<th>번호</th>
		<td class="articleId id" data-id="${article.id }">${article.id }</td>
	</tr>
	<tr>
		<th>날짜</th>
		<td>${article.regDate }</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${article.title }</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td class="clickable-contextMenu clickable" data-id="${article.memberId }" data-to="${article.extra.writer }">${article.extra.writer }</td>
	</tr>
	<tr>
		<th>내용</th>
		<td class="text-overflow-ellipsis"><pre>${article.body }</pre></td>
	</tr>  
  
</table>
<c:forEach items="${files }" var="file">
	<img src="/admin/showImg?id=${file.id }"><br>
	<a href="/admin/downloadImg?id=${file.id }">${file.originFileName }</a><br>
</c:forEach>

<h3>댓글</h3>
<c:if test="${isLogined }">
	<form id="replyAddForm" onsubmit="articleDetail__checkAddReplyForm(this); return false;">
		<input type="hidden" name="articleId" value="${article.id }">
		<input type="hidden" name="boardId" value="${article.boardId }">
		댓글 : <textarea name="body"></textarea>
		<button>작성</button>
	</form>
	
	<form id="replyModifyForm" onsubmit="articleDetail__modifyReply(this); return false;" hidden>
		<input type="hidden" name="id">
		<input type="hidden" name="articleId" value="${article.id }">
		<input type="hidden" name="boardId" value="${article.boardId }">
		수정내용 : <textarea name="body"></textarea>
		<button>수정</button><button type="button" onclick="articleDetail__hideReplyModifyForm();">취소</button>
		
	</form>
</c:if>

<hr>
<div class="replyList"></div>
<div class="replyStatus"></div>

<%@ include file="../admin_part/admin_foot.jspf" %>