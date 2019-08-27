<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="로그인 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<form class="absolute-center" onsubmit="memberLogin__checkForm(this); return false;" action="/member/doLogin" method="post">

	<label>아이디<br> <input class="max-width border-normal margin-vertical-normal" type="text" name="loginId"></label><br>
	
	<label>비밀번호<br> <input class="max-width  border-normal margin-vertical-normal" type="text" name="temp_loginPw"></label>
	<input type="hidden" name="loginPw"><br>		
	
	<button class="max-width margin-vertical-normal">로그인</button><br>
	<a href="/member/findLoginId">아이디 찾기</a>
	<a href="/member/findLoginPw">비밀번호 찾기</a>
</form>



<%@ include file="../part/foot.jspf" %>