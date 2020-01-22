<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="비밀번호 찾기 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<form onsubmit="memberFindLoginPw__checkForm(this); return false;" action="/member/doFindLoginPw" method="post">

	<label>아이디 : <input type="text" name="loginId"></label>	
	
	<label>이메일 : <input type="text" name="email"></label>			
	
	<button>찾기</button>
</form>
<div class="findLoginPw">
</div>

<%@ include file="../part/foot.jspf" %>