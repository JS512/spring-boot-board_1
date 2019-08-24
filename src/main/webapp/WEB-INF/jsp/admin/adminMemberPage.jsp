<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="회원관리 페이지"/>
<%@ include file="../part/head.jspf" %>
<script src="/resource/adminApp.js"></script>
<h1>${title}</h1>

<table>
	<thead>
	  <tr>
	    <th>번호</th>
	    <th>가입 날짜</th>
	    <th>로그인 아이디</th>
	    <th>이름</th>
	    <th>이메일</th>
	    <th>이메일 인증</th>
	  </tr>
  </thead>
  <tbody>  	
  </tbody>
</table>

<%@ include file="../part/foot.jspf" %>