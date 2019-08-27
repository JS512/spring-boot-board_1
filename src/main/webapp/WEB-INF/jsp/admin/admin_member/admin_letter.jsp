<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="쪽지 리스트 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<table>
  <tr>
    <th>번호</th>
    <th>날짜</th>    
    <th>작성자</th>
    <th>내용</th>
    <th>비고</th>
  </tr>
  <c:forEach items="${letters}" var="letter">
  	<tr>
  		<td>${letter.id }</td>
  		<td>${letter.regDate }</td>  		
  		<td class="clickable-contextMenu clickable" data-id="${letter.fromMemberId }" data-to="${letter.extra.writer }">${letter.extra.writer }</td>
  		<td class="text-overflow-ellipsis clickable-letterContent clickable">${letter.body }</td>
  		<td><button onclick="letter__deleteLetter(this);" data-id="${letter.id }">삭제</button></td>
  			
  	</tr>
  </c:forEach>
</table>
<c:out value="${url }"/>
<ul>
	<c:if test="${page.prev }">
		<li><a href="/admin/letterList?cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/admin/letterList?cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/admin/letterList?cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<div class="letter-content absolute-center" hidden>
	<div class="text-align-left">
		<div class="close">	</div>
	</div>
	<div class="content"></div>
</div>
<%@ include file="../admin_part/admin_foot.jspf" %>