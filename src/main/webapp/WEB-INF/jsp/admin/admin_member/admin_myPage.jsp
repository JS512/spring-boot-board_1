<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="마이 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<h2>회원 정보</h2>
<table>
	<tr>
		<th>아이디 : </th>
		<td> ${loginedMember.loginId }</td>
	</tr>
	<tr>
		<th>이름 :</th>
		<td> ${loginedMember.name }</td>
	</tr>
	<tr>
		<th>이메일 :</th>
		<td> ${loginedMember.email }</td>
	</tr>
	<tr>
		<th>이메일 인증 :</th>
		<td>
			<c:choose>
				<c:when test="${loginedMember.emailAuthStatus == true}">
					O
				</c:when>
				<c:when test="${loginedMember.emailAuthStatus == false }">
					X
				</c:when>
			</c:choose>
		</td>
	</tr>
</table>
<a href="/admin/changeLoginPw">비밀번호 변경</a>
<a href="/admin/letterList">쪽지 보기</a>
<a href="javascript:adimMemberMyPage__withdrawal();">회원 탈퇴</a>
<a href="/admin/getMemberArticles">내 게시물</a>
<a href="/admin/getMemberReplies">내 댓글</a>
<%@ include file="../admin_part/admin_foot.jspf" %>