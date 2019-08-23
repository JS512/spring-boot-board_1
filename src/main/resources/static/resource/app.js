function encodeSHA1(input){	
   var hash = CryptoJS.SHA1(input.value.trim());
   var result = CryptoJS.enc.Hex.stringify(hash);
   return result;
}
function checkFileTypeImg(input){
	var type = ["image/jpeg", "image/gif", "image/png"];
	
	if(!type.includes(input.files[0].type)){		
		alert("이미지 파일이 아닙니다.");
		input.value = "";		
	}else{
		$(input).siblings(".type2").attr("value", input.files[0].type);
	}
}

function checkEmpty(input){
	input.value = input.value.trim();
	if(input.value.length == 0){
		return false;
	}
	
	return true;
}

function checkEmailPattern(input){
	var pattern = /\w+@\w+\.\w+\.?\w*/;
	return pattern.test(input.value);	
}


function ArticleAdd__checkForm(form){	
	
	if(!checkEmpty(form.body) || !checkEmpty(form.title)){
		alert("빈칸 없이 채워주세요.");
		return false;
	}
	
	$("input[type='file']").each(function(index, item){
		if($(item).val() == ''){
			$(item).parent().remove();
		}
	});		
	
	
	form.submit();
}

function ArticleAdd__addFile(locationType){
	var container = document.createElement("div");
	var file = document.createElement("input");
	
	file.setAttribute("type", "file");
	file.setAttribute("name", "addFiles");
	file.addEventListener("change", function(){
		checkFileTypeImg(this);
		
	});
	
	var button = document.createElement("button");
	button.innerHTML = "삭제하기";
	button.addEventListener("click", function(){
		$(this).parent().remove();
	});
	
	var type = document.createElement("input");
	type.setAttribute("type", "hidden");
	type.setAttribute("name", "type");
	type.setAttribute("value", locationType);
	
	var type2 = document.createElement("input");
	type2.setAttribute("type", "hidden");
	type2.setAttribute("name", "type2");
	type2.setAttribute("class", "type2");
	
	container.append(file, button ,type, type2);
	
	$(".fileList").append(container);
}

function ArticleDetail__deleteArticleCheck(id, boardId){
	if(!confirm("현재 게시물을 삭제하시겠습니까?")){
		return ;
	}
	location.href="/article/deleteOneArticle?id="+id+"&boardId="+boardId;
}

function ArticleDetail__modifyArticleCheck(id, boardId){
	if(!confirm("현재 게시물을 수정하시겠습니까?")){
		return ;
	}
	location.href="/article/modifyArticle?id="+id+"&boardId="+boardId;
}

function ArticleDetail__checkAddReplyForm(form){
	if(!checkEmpty(form.body)){
		alert("빈칸없이 채워주세요");
		return ;
	}
	$.post("/article/addReply",
		{
			articleId : form.articleId.value,
			boardId : form.boardId.value,
			body : form.body.value
		},
		function(data){
			alert(data.msg);
			if(data.success){
				form.body.value = "";
				ArticleDetail__drawReply(data.reply);
			}
		},
		"json"
	)
}

function ArticleDetail__drawReply(data){
	var html = `
	<div>	
		<table>
			<tr>
				<td><button data-type="reply" class="like" type="button" onclick="ArticleDetail__updateLike(this, true);">좋아요</button> <span>0</span></td>
				<td><button data-type="reply" class="like" type="button" onclick="ArticleDetail__updateLike(this, false);">싫어요</button> <span>0</span></td>
			</tr>
			<tr>
				<th>번호</th> <td class="replyId id" data-id="${data.id}"> ${data.id}</td>
			</tr>
			<tr>
				<th>날짜</th> <td class="replyRegDate"> ${data.regDate}</td>
			</tr>
			<tr>
				<th>작성자</th> <td> ${data.extra.writer}</td>
			</tr>											
		</table>
		<pre class="replyBody">${data.body}</pre>`;
		if( ($("#memberId").length && $("#memberId").val() == data.memberId) || $("#memberRole").val() == "true"){
			html += `<button type="button" onclick="ArticleDetail__deleteReply(this);">삭제</button>
			<button type="button" onclick="ArticleDetail__showReplyModifyForm(this);">수정</button>`
		}
		html += `	
		<hr>
	</div>`;
	
	$.parseHTML(html);
	$(".replyList").prepend(html);
	
}

function ArticleDetail__getAllReplies(){	
	var id = $(".articleId").attr("data-id");
	var boardId = $("#boardId").val();
	$.post("/article/getOneArticleAllReplies",
		{
			articleId : id,
			boardId : boardId
		},
		function(data){			
			if(data.success){
				for(var i=0; i<data.replies.length ;i++){
					ArticleDetail__drawReply(data.replies[i]);
					
				}
				$(".replyList").find("table").each(function(index, item){
					ArticleDetail__getLikes($(this), "reply");
				});
				
				
			}else{
				$(".replyList").html(data.msg);
			}
		}
	)
}

function ArticleDetail__deleteReply(btn){
	var articleId = $(".articleId").attr("data-id");
	var boardId = $("#boardId").val();
	var id = $(btn).parent().find(".replyId").attr("data-id");		
	
	if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
		$(btn).parent().hide();
		$.get("/article/deleteOneArticleOneReply",
			{
				articleId : articleId,
				boardId : boardId,
				id : id
			},
			function(data){
				
				if(data.success){
					$(btn).parent().remove();
				}else{
					$(btn).parent().show();	
				}
			},
			"json"
		);
	}
}

function ArticleDetail__modifyReply(form){
	if(!checkEmpty(form.body)){
		alert("빈칸없이 채워주세요.");
		return ;
	}
	var replyContainer = hide;
	$.post("/article/modifyReply",
		{
			id : form.id.value,
			articleId : form.articleId.value,
			boardId : form.boardId.value,
			body : form.body.value
		},
		function(data){
			alert(data.msg);
			if(data.success){
				$("#replyModifyForm").find("iput[name='id']").val("");
				$("#replyModifyForm").find("textarea[name='body']").val("");
				
				replyContainer.find(".replyRegDate").html(data.reply.regDate);
				replyContainer.find(".replyBody").html(data.reply.body);
				replyContainer.show();
				ArticleDetail__hideReplyModifyForm();
			}
		},
		"json"
	);
}

var hide;
function ArticleDetail__showReplyModifyForm(btn){
	
	if(hide != null)
		hide.show();
	
	hide = $(btn).parent();
	hide.hide();
	
	$("#replyModifyForm").show();
	$("#replyAddForm").hide();
	
	$("#replyModifyForm").find("input[name='id']").val(hide.find(".replyId").attr("data-id"));
	$("#replyModifyForm").find("textarea[name='body']").val(hide.find(".replyBody").html());
	$("#replyModifyForm").find("textarea[name='body']").focus();	
	
}

function ArticleDetail__hideReplyModifyForm(){
	
	$("#replyModifyForm").find("iput[name='id']").val("");
	$("#replyModifyForm").find("textarea[name='body']").val("");
	
	$("#replyAddForm").show();
	$("#replyModifyForm").hide();
	
	hide.show();
}

function ArticleDetail__getLikes(table, type){
	var articleId = table.find(".id").attr("data-id");
	var boardId = $("#boardId").val();
	
	$.get("/article/getLikes",
		{
			relId : articleId,
			boardId : boardId,
			type : type
		},
		function(data){
			
			if(!data.success){
				alert(data.msg);
			}						
			ArticleDetail__drawArticleLike(table, data);
		},
		"json"
	);
}

function ArticleDetail__updateLike(btn, val){
	var articleId = $(btn).parent().parent().parent().find(".id").attr("data-id");
	var boardId = $("#boardId").val();
	var type = $(btn).attr("data-type");
	
	$.get("/article/updateLike",
		{
			relId : articleId,
			boardId : boardId,
			type : type,
			val : val
		},
		function(data){
			alert(data.msg);
			if(data.success){
				ArticleDetail__getLikes($(btn).parent().parent().parent(), type);
			}
		},
		"json"
	);
}

function ArticleDetail__drawArticleLike(table, data){
	table.find(".like").css("background-color","");
	
	table.find(".like").each(function(index, item){	
		
		if(index == 0){
			$(item).next().html(data.like);
			if(data.checkType == "like"){
				$(item).css("background-color", "yellow");
			}
		}else if(index == 1){			
			$(item).next().html(data.disLike);
			if(data.checkType == "disLike"){
				$(item).css("background-color", "yellow");
			}
		}		
	});
	
}

function ArticleModify__checkForm(form){
	ArticleAdd__checkForm(form);
}

function ArticleModify__addFile(locationType){
	ArticleAdd__addFile(locationType);
}

function ArticleModify__check(btn){
	$(btn).attr("disabled", false);
	if(btn.checked){
		if($(btn).attr("name") == "modify"){
			$(btn).siblings(".modifyFile").show();
		}
		$(btn).siblings("input[type='checkbox']").attr("disabled" ,true);
	}else{
		
		if($(btn).attr("name") == "modify"){
			$(btn).siblings(".modifyFile").find("input[type='file']").val("");
			$(btn).siblings(".modifyFile").hide();
		}
		$(btn).siblings("input[type='checkbox']").attr("disabled" ,false);
	}	
}

var idCheck = false;
var emailCheck = false;
function MemberJoin__checkForm(form){	
	
	if(!checkEmpty(form.loginId) || !checkEmpty(form.temp_loginPw)
			|| !checkEmpty(form.name) || !checkEmpty(form.email))
	{
		alert("빈칸없이 채워주세요");
		return ;
	}	
	
	if(!checkEmailPattern(form.email)){
		alert("이메일 형식에 맞지 않습니다.");
		return ;
	}
	
	if(!idCheck || !emailCheck){
		alert("중복체크를 모두 완료해주세요");
		return ;
	}
	
	form.loginPw.value = encodeSHA1(form.temp_loginPw);
	$(form).find("button").attr("disabled", true);
	$(form).hide();
	$(".statusMsg").html("회원가입  진행중......");
	
	form.submit();
}

function MemberJoin__loginIdDoubleCheck(btn){
	$(btn).prev().find("input").val($(btn).prev().find("input").val().trim());
	var loginId = $(btn).prev().find("input").val();
	if(loginId.length == 0){
		alert("빈칸없이 채워주세요");
		return ;
	}
	
	$.get("/member/loginIdDoubleCheck",
		{
			loginId : loginId
		},
		function(data){
			$(btn).next().html(data.msg);
			if(data.success){
				idCheck = true;
			}
		},
		"json"
	);
}

function MemberJoin__emailDoubleCheck(btn){
	$(btn).prev().find("input").val($(btn).prev().find("input").val().trim());
	var email = $(btn).prev().find("input").val();
	var pattern = /\w+@\w+\.\w+\.?\w*/;
	
	if(!pattern.test(email)){
		alert("이메일 형식에 맞지 않습니다.");
		return ;
	}
	
	$.get("/member/emailDoubleCheck",
		{
			email : email
		},
		function(data){
			$(btn).next().html(data.msg);
			if(data.success){
				emailCheck = true;
			}
		},
		"json"
	);
}

function MemberJoin__resetEmail(){	
	emailCheck = false;
}

function MemberJoin__resetLoginId(){	
	idCheck = false;
}

function MemberLogin__checkForm(form){
	if(!checkEmpty(form.loginId) || !checkEmpty(form.temp_loginPw))
	{
		alert("빈칸없이 채워주세요");
		return ;
	}
	
	form.loginPw.value = encodeSHA1(form.temp_loginPw);	
	
	form.submit();
}

function MemberMyPage__withdrawal(){
	if(confirm("정말 탈퇴 하시겠습니까?")){
		location.href = "/member/withdrawal";
	}
}

function MemberFindLoginId__checkForm(form){
	if(!checkEmpty(form.name) || !checkEmpty(form.email)){
		alert("빈칸을 채워주세요");
		return ;
	}
	$(form).find("button").attr("disabled", true);
	$("div").html("<h1>찾는중..</h1>");
	$.get("/member/doFindLoginId",
		{
			name : form.name.value.trim(),
			email : form.email.value.trim()
		},
		function(data){
			if(data.success){
				$("div").html("<h2>아이디</h2>" + data.msg);
			}else{
				$("div").html("");
				alert(data.msg);
			}
			
			$(form).find("button").attr("disabled", false);
		}
	)
}

function MemberFindLoginPw__checkForm(form){
	if(!checkEmpty(form.loginId) || !checkEmpty(form.email)){
		alert("빈칸을 채워주세요");
		return ;
	}
	$(form).find("button").attr("disabled", true);
	$("div").html("<h1>찾는중..</h1>");
	$.get("/member/doFindLoginPw",
		{
			loginId : form.loginId.value.trim(),
			email : form.email.value.trim()
		},
		function(data){							
			alert(data.msg);			
			$("div").html("");
			$(form).find("button").attr("disabled", false);
		}
	);
}

function MemberChangeLoginPw__checkForm(form){
	if(!checkEmpty(form.temp_origin_loginPw) || !checkEmpty(form.temp_loginPw)){
		alert("빈칸을 채워주세요");
		return ;
	}
	
	form.origin_loginPw.value = encodeSHA1(form.temp_origin_loginPw);
	form.loginPw.value = encodeSHA1(form.temp_loginPw);
	
	form.submit();
}

$(function(){	
	if($(".replyList").length){
		ArticleDetail__getAllReplies();
		ArticleDetail__getLikes($(".article"), "article");
	}
})