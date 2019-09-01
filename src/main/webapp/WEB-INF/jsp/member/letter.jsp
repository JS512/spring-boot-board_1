<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="쪽지 리스트 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<form action="/member/letterList">
	<select name="searchType">
		<option value="all">모두</option>
		<option value="receive">수신</option>
		<option value="send">송신</option>
	</select>
	<c:if test="${param.searchType != null && param.searchType != '' }">
		<script>
			$("select[name='searchType']").val("${param.searchType}");
		</script>
	</c:if>
	<button>검색</button>
</form>

<table>
  <tr>
    <th>번호</th>
    <th>송/수신</th>
    <th>날짜</th>    
    <th>송/수신자</th>
    <th>내용</th>    
  </tr>
  <c:forEach items="${letters}" var="letter">
  	<tr>
  		<td>${letter.id }</td>
  		<td>
	  		<c:if test="${letter.fromMemberId == loginedMemberId }">
	  			송신
	  		</c:if>
	  		<c:if test="${letter.toMemberId == loginedMemberId }">
	  			수신
	  		</c:if>
  		</td>
  		<td>${letter.regDate }</td>  		
  		<td class="clickable-contextMenu clickable" data-id="${letter.fromMemberId }" data-to="${letter.extra.writer }">${letter.extra.writer }</td>  		
  		<c:if test="${letter.fromMemberId == loginedMemberId }">
  			<td data-id="${letter.id}" data-memberId="${letter.toMemberId }" class="text-overflow-ellipsis clickable-letterContent clickable">${letter.originBody }</td>
  		</c:if>
  		<c:if test="${letter.toMemberId == loginedMemberId }">
  			<td data-id="${letter.id}" data-memberId="${letter.fromMemberId }" class="text-overflow-ellipsis clickable-letterContent clickable">${letter.originBody }</td>
  		</c:if>  		  		
  	</tr>
  </c:forEach>
</table>

<ul>
	<c:if test="${page.prev }">
		<li><a href="/member/letterList?cPage=${page.startPage-1}"><</a></li>
	</c:if>
	<c:forEach begin="${page.startPage }" end="${page.endPage }" var="idx">
		<li>
			<a href="/member/letterList?cPage=${idx }"><c:out value="${idx}"/></a>
		</li>
	</c:forEach>
	<c:if test="${page.next }">
		<li><a href="/member/letterList?cPage=${page.endPage+1}">></a></li>
	</c:if>
</ul>
<div class="letter-content absolute-center" hidden>
	<div class="text-align-right">
		<div class="close">	</div>
	</div>
	<div class="loading" hidden></div>
	<div class="content"></div>
	<form onsubmit="letter_sendReply(this); return false;">
		<textarea name="body"></textarea>
		<button>전송</button>
	</form>
</div>
<%@ include file="../part/foot.jspf" %>