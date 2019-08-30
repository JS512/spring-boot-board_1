<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="내 댓글  페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<table>
  <tr>
    <th>번호</th>
    <th>날짜</th>
    <th>내용</th>
    <th>작성자</th>    
    
  </tr>
  <c:forEach items="${list}" var="reply">
  	<tr>
  		<td>${reply.id }</td>
  		<td>${reply.regDate }</td>
  		<td class="text-overflow-ellipsis"><a href="/article/detail?id=${reply.articleId}&cPage=${param.cPage}&boardId=${reply.boardId}#reply${reply.id}">${reply.originBody }</a></td>
  		<td class="clickable-contextMenu clickable" data-id="${reply.memberId }" data-to="${reply.extra.writer }">${reply.extra.writer }</td>  		  		
  		
  	</tr>
  </c:forEach>
</table>

<ul>
	<c:if test="${page.prev }">
		<li><a href="/article/getMemberReplies?cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/article/getMemberReplies?cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/article/getMemberReplies?&cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<%@ include file="../part/foot.jspf" %>