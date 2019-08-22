<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="회원가입 페이지"/>
<%@ include file="../part/head.jspf" %>
<h1>${title}</h1>

<form onsubmit="MemberJoin__checkForm(this); return false;" action="/member/doJoin" method="post">
	<label>아이디 : <input onchange="MemberJoin__resetLoginId();" type="text" name="loginId"></label>
	<button onclick="MemberJoin__loginIdDoubleCheck(this);" type="button">중복체크</button>
	<div></div>
	
	<label>비밀번호 : <input type="text" name="loginPw"></label><br>
	<label>이름 : <input type="text" name="name"></label><br>
	
	<label>이메일 : <input onchange="MemberJoin__resetEmail();" type="text" name="email"></label>
	<button onclick="MemberJoin__emailDoubleCheck(this);" type="button">중복체크</button>
	<div></div>
	
	<button>회원가입</button>
</form>


<%@ include file="../part/foot.jspf" %>