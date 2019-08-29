<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="신고 내역 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<table>
  <tr>
    <th>번호</th>
    <th>타입</th>
    <th>신고 번호</th>
    <th>날짜</th>    
    <th>작성자</th>
    <th>내용</th>
    <th>삭제</th>
    <th>바로가기</th>
  </tr>
  <c:forEach items="${reports}" var="report">
  	<tr>
  		<td>${report.id }</td>
  		<td>
  			<c:if test="${report.relType == 'article' }">
  				게시물
  			</c:if>
  			<c:if test="${report.relType == 'reply' }">
  				댓글
  			</c:if>
  		</td>
  		<td>${report.relId}</td>
  		<td>${report.regDate }</td>  		
  		<td class="clickable-contextMenu clickable" data-id="${report.memberId }" data-to="${report.extra.writer }">${report.extra.writer }</td>
  		<td class="text-overflow-ellipsis clickable-reportContent clickable">${report.body }</td>
  		<td><button onclick="report__deleteReport(this);" data-id="${report.id }">삭제</button></td>
  		<td><a href="/admin/articleDetail?id=${report.extra.articleId }&boardId=${report.extra.boardId}#${report.relType}${report.relId}">바로가기</a></td>
  	</tr>
  </c:forEach>
</table>
<c:out value="${url }"/>
<ul>
	<c:if test="${page.prev }">
		<li><a href="/admin/reportList?cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/admin/reportList?cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/admin/reportList?cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<div class="report-content absolute-center" hidden>
	<div class="text-align-right">
		<div class="close">	</div>
	</div>
	<div class="content"></div>
</div>
<%@ include file="../admin_part/admin_foot.jspf" %>