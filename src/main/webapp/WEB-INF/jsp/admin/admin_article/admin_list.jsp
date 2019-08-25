<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="리스트 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<a href="/admin/addArticle?boardId=${param.boardId }">글쓰기</a>	

<form action="/article/list" method="get">
	<input type="hidden" name="boardId" value="${param.boardId }">	
	<select name="searchType">
		<option value="title">제목</option>
		<option value="body">내용</option>
		<option value="writer">작성자</option>
	</select>
	<c:if test="${param.searchType != null && param.searchType != '' }">
		<script>
			$("select[name='searchType']").val("${param.searchType}");
		</script>
	</c:if>	
	
	<input type="text" name="searchKeyword" value="${param.searchKeyword }">
	<button>검색</button>
</form>

<table>
  <tr>
    <th>번호</th>
    <th>날짜</th>
    <th>제목</th>
    <th>작성자</th>
    <th>비고</th>
  </tr>
  <c:forEach items="${list}" var="article">
  	<tr>
  		<td>${article.id }</td>
  		<td>${article.regDate }</td>
  		<td class="text-overflow-ellipsis"><a href="/admin/articleDetail${url }&id=${article.id}&cPage=${param.cPage}">${article.title }</a></td>
  		<td class="clickable-contextMenu clickable" data-id="${article.memberId }" data-to="${article.extra.writer }">${article.extra.writer }</td>
  	</tr>
  </c:forEach>
</table>
<ul>
	<c:if test="${page.prev }">
		<li><a href="/article/list${url }&cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/article/list${url }&cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/article/list${url }&cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<%@ include file="../admin_part/admin_foot.jspf" %>