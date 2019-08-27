<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="회원관리 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>

<h1>${title}</h1>

<table class="memberTable">
	<thead>
	  <tr>
	    <th>번호</th>
	    <th>가입 날짜</th>
	    <th>로그인 아이디</th>
	    <th>이름</th>
	    <th>이메일</th>
	    <th>이메일 인증</th>
	    <th>비고</th>
	  </tr>
  </thead>
  <tbody>  	
  </tbody>
</table>

<%@ include file="../admin_part/admin_foot.jspf" %>