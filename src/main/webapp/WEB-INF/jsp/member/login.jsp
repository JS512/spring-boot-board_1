<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="로그인 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<form onsubmit="MemberLogin__checkForm(this); return false;" action="/member/doLogin" method="post">

	<label>아이디 : <input type="text" name="loginId"></label>	
	
	<label>비밀번호 : <input type="text" name="temp_loginPw"></label>
	<input type="hidden" name="loginPw"><br>		
	
	<button>로그인</button>
</form>

<%@ include file="../part/foot.jspf" %>