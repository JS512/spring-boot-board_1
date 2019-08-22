<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="상세 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<a href="/article/list${url }&cPage=${param.cPage}">목록으로</a>
<c:if test="${isLogined && loginedMemberId == article.memberId }">
	<a href="javascript:ArticleDetail__deleteArticleCheck(${article.id }, ${param.boardId })">삭제하기</a>
	<a href="javascript:ArticleDetail__modifyArticleCheck(${article.id }, ${param.boardId })">수정하기</a>
</c:if>

<table>
	<tr>
    	<th>번호</th>
		<td>${article.id }</td>
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
		<td>${article.extra.writer }</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><pre>${article.body }</pre></td>
	</tr>  
  
</table>
<c:forEach items="${files }" var="file">
	<img src="/article/showImg?id=${file.id }"><br>
	<a href="/article/downloadImg?id=${file.id }">${file.originFileName }</a><br>
</c:forEach>

<%@ include file="../part/foot.jspf" %>