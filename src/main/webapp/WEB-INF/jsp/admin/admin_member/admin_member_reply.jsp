<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="댓글 리스트 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>


<form onsubmit="adminMemberReply__checkForm(this); return false;" >	
	<table>
	  <tr>
	    <th>번호</th>
	    <th>날짜</th>
	    <th>내용</th>
	    <th>작성자</th>	    
	    <th><button>삭제</button></th>
	  </tr>
	  <c:forEach items="${list}" var="reply">
	  	<tr>
	  		<td>${reply.id }</td>
	  		<td>${reply.regDate }</td>
	  		<td class="text-overflow-ellipsis"><a href="/admin/articleDetail${url }&id=${reply.articleId}&cPage=${param.cPage}&boardId=${reply.boardId}">${reply.body }</a></td>
	  		<td class="clickable-contextMenu clickable" data-id="${reply.memberId }" data-to="${reply.extra.writer }">${reply.extra.writer }</td>	  		  		
	  		<td><input type="checkbox" value="${reply.id }" data-articleId="${reply.articleId }" data-boardId=${reply.boardId }></td>
	  	</tr>
	  </c:forEach>
	</table>
</form>
<ul>
	<c:if test="${page.prev }">
		<li><a href="/admin/getMemberReplies${url }&cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/admin/getMemberReplies${url }&cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/admin/getMemberReplies${url }&cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<%@ include file="../admin_part/admin_foot.jspf" %>