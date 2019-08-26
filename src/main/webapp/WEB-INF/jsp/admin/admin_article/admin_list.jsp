<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="리스트 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<a href="/admin/addArticle?boardId=${param.boardId }">글쓰기</a>	
<c:choose>
	<c:when test="${param.boardId == 1 }">
		<h3>자유게시판</h3>
	</c:when>
	<c:when test="${param.boardId == 2 }">
		<h3>공지사항</h3>
	</c:when>
</c:choose>

<form action="/admin/articleList" method="get">
	<input type="hidden" name="boardId" value="${param.boardId }">	
	<select name="searchType">
		<option value="title">제목</option>
		<option value="body">내용</option>
		<option value="writer">작성자</option>
	</select>		
	
	<input type="text" name="searchKeyword" value="${param.searchKeyword }">
	<button>검색</button><br>
	<label>
		정렬 기준 :
		<select name="sortType">
			<option value="latest">최신순</option>
			<option value="oldest">오래된순</option>
			<option value="highLike">좋아요 많은순</option>
			<option value="lowLike">좋아요 적은순</option>
			<option value="highView">조회수 많은순</option>
			<option value="lowView">조회수 적은순</option>
		</select>
	</label>
	<c:if test="${param.searchType != null && param.searchType != '' }">
		<script>
			$("select[name='searchType']").val("${param.searchType}");
		</script>
	</c:if>
	<c:if test="${param.sortType != null && param.sortType != ''}">
		<script>
			$("select[name='sortType']").val("${param.sortType}");
		</script>
	</c:if>
</form>

<form onsubmit="adminArticleList__checkForm(this);return false;" >
	<input type="hidden" name="boardId" value="${param.boardId }">
	<table>
	  <tr>
	    <th>번호</th>
	    <th>날짜</th>
	    <th>제목</th>
	    <th>작성자</th>
	    <th>조회수</th>
	    <th>좋아요</th>
	    <th><button>삭제</button></th>
	  </tr>
	  <c:forEach items="${list}" var="article">
	  	<tr>
	  		<td>${article.id }</td>
	  		<td>${article.regDate }</td>
	  		<td class="text-overflow-ellipsis"><a href="/admin/articleDetail${url }&id=${article.id}&cPage=${param.cPage}">${article.title }</a></td>
	  		<td class="clickable-contextMenu clickable" data-id="${article.memberId }" data-to="${article.extra.writer }">${article.extra.writer }</td>
	  		<td>${article.view }</td>
	  		<td>${article.extra.likeCnt }</td>  		
	  		<td><input type="checkbox" name="id" value="${article.id }"></td>
	  	</tr>
	  </c:forEach>
	</table>
</form>
<ul>
	<c:if test="${page.prev }">
		<li><a href="/admin/articleList${url }&cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/admin/articleList${url }&cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/admin/articleList${url }&cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<%@ include file="../admin_part/admin_foot.jspf" %>