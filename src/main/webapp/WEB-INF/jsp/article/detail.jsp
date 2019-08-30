<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="${boardName } 상세 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<a href="/article/list${url }&cPage=${param.cPage}">목록으로</a>

<c:if test="${ isLogined}">
	<c:if test="${loginedMemberId == article.memberId }">
		<a href="javascript:articleDetail__deleteArticleCheck(${article.id }, ${param.boardId })">삭제하기</a>
		<a href="javascript:articleDetail__modifyArticleCheck(${article.id }, ${param.boardId })">수정하기</a>
	</c:if>	
	<a data-type="article" data-id="${article.id }" href="javascript:void(0);" onclick="showReportForm(this);">신고하기</a>
</c:if>


<input type="hidden" id="boardId" value="${article.boardId}">
<input type="hidden" id="articleId" value="${article.id }">

<table class="article" id="article${article.id}">
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
		<td>${article.body }</td>
	</tr>  
  
</table>
<c:forEach items="${files }" var="file">
	<img src="/article/showImg?id=${file.id }"><br>
	<a href="/article/downloadImg?id=${file.id }">${file.originFileName }</a><br>
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

<%@ include file="../part/foot.jspf" %>