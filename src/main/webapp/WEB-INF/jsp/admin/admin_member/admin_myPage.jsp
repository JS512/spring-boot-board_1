<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="title" value="마이 페이지"/>
<%@ include file="../admin_part/admin_head.jspf" %>
<h1>${title}</h1>

<h2>회원 정보</h2>
<table>
	<tr>
		<th colspan="2">
			<img class="profile-img" src="/admin/showProfileImg">
			<form onsubmit="memberMyPage__modifyMemberProfileImg(this); return false;">
				<label>기본 이미지로 변경 : <input type="checkbox" name="deleteProfileImg" onclick="memberMyPage__toggleProfileImg(this);" value="1"></label><br>
				<label> 이미지 선택 : <input type="checkbox" name="modifyProfileImg" onclick="memberMyPage__toggleProfileImg(this);" ><br>
					<input class="checkFileType" type="file" name="profileImg" hidden><br>				
				</label>
				<button>변경</button>
			</form>
		</th>
		
	</tr>
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
				<c:when test="${loginedMember.emailAuthStatus == true}">O</c:when>
				<c:when test="${loginedMember.emailAuthStatus == false }">X</c:when>
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