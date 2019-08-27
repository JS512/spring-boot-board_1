function adminPage__getAllMembers(){
	if($(".memberTable").length){
		$.post("/admin/getAllMembers",
				{},
				function(data){
					if(data.success){
						adminPage__drawMembers(data.members);
					}else{
						alert(data.msg);
					}
				},
				"json"
			);
	}
	
}

function adminPage__deleteMember(btn){
	if(!confirm("회원을 삭제하시겠습니까?")){
		return ;
	}
	$.get("/admin/deleteMember",
		{
			targetMemberId :$(btn).attr("data-id") 
		},
		function(data){
			alert(data.msg);
			adminPage__getAllMembers();
		},
		"json"
	);	
}

function adminPage__drawMembers(data){
	$(".memberTable").find("tbody").html("");
	var html;
	for(var i=0; i<data.length ;i++){
		var member = data[i];
		var auth = "X";
		if(member.emailAuthStatus){
			auth = "O";
		}
		html += `<tr>
	  		<td>${member.id }</td>
	  		<td>${member.regDate }</td>
	  		<td class="clickable-contextMenu clickable" data-id="${member.id }" data-to="${member.loginId}">${member.loginId}</td>
	  		<td>${member.name}</td>
	  		<td>${member.email}</td>
	  		<td>${auth}</td>
	  		<td><button data-id="${member.id}" onclick="adminPage__deleteMember(this);">회원 삭제</button></td>
  		</tr>`;
	}
	$(".memberTable").find("tbody").append(html);	
	initContextMenu();
}

function adminArticleList__checkForm(form){
	if($("form").find("input[type='checkbox']:checked").length == 0){
		alert("한개이상 선택해 주세요.");
		return ;
	}
	
	if(!confirm("선택한 게시물들을 삭제 하시겠습니까?")){
		return ;
	}
	
	var checkedValue = [];
	
	$("input[type='checkbox']:checked").each(function(index, item){		
		checkedValue.push($(item).val());		
	});	
	
	$("form").find("button").attr("disabled", true);	
	
	$.post("/admin/deleteCheckedArticle",
		{
			id:checkedValue,
			boardId : form.boardId.value
		},
		function(data){
			
			alert(data.msg);
			if(data.success){
				$("form").find("input[type='checkbox']:checked").parent().parent().remove();
			}
		},
		"json"
	)
}

function adminMemberReply__checkForm(){
	if($("form").find("input[type='checkbox']:checked").length == 0){
		alert("한개이상 선택해 주세요.");
		return ;
	}
	
	if(!confirm("선택한 댓글들을 삭제 하시겠습니까?")){
		return ;
	}
	
	var checkedValue = [];
	var checkedArticleValue = [];
	var checkedBoardValue = [];
	
	$("input[type='checkbox']:checked").each(function(index, item){		
		checkedValue.push($(item).val());
		checkedArticleValue.push($(item).attr("data-articleId"));
		checkedBoardValue.push($(item).attr("data-boardId"));
	});	
	
	$("form").find("button").attr("disabled", true);	
	
	$.post("/admin/deleteCheckedMemberReply",
		{
			id:checkedValue,
			boardId : checkedBoardValue,
			articleId : checkedArticleValue
		},
		function(data){
			
			alert(data.msg);
			if(data.success){
				$("form").find("input[type='checkbox']:checked").parent().parent().remove();
			}
		},
		"json"
	)
}

function adminMemberArticle__checkForm(){
	if($("form").find("input[type='checkbox']:checked").length == 0){
		alert("한개이상 선택해 주세요.");
		return ;
	}
	
	if(!confirm("선택한 게시물들을 삭제 하시겠습니까?")){
		return ;
	}
	
	var checkedValue = [];	
	var checkedBoardValue = [];
	
	$("input[type='checkbox']:checked").each(function(index, item){		
		checkedValue.push($(item).val());
		checkedBoardValue.push($(item).attr("data-boardId"));
	});	
	
	$("form").find("button").attr("disabled", true);	
	
	$.post("/admin/deleteCheckedMemberArticle",
		{
			id:checkedValue,
			boardId : checkedBoardValue			
		},
		function(data){
			
			alert(data.msg);
			if(data.success){
				$("form").find("input[type='checkbox']:checked").parent().parent().remove();
			}
		},
		"json"
	)
}

function showMemberArticles(){
	location.href="/admin/getMemberArticles?memberId="+clickedMemberId;
}

function showMemberReplies(){
	location.href="/admin/getMemberReplies?memberId=" + clickedMemberId;
}

//////////////////////////////////////////////////////////////////////


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


function articleAdd__checkForm(form){	
	
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

function articleAdd__addFile(locationType){
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

function articleDetail__deleteArticleCheck(id, boardId){
	if(!confirm("현재 게시물을 삭제하시겠습니까?")){
		return ;
	}
	location.href="/admin/deleteOneArticle?id="+id+"&boardId="+boardId;
}

function articleDetail__modifyArticleCheck(id, boardId){
	if(!confirm("현재 게시물을 수정하시겠습니까?")){
		return ;
	}
	location.href="/admin/modifyArticle?id="+id+"&boardId="+boardId;
}

function articleDetail__checkAddReplyForm(form){
	if(!checkEmpty(form.body)){
		alert("빈칸없이 채워주세요");
		return ;
	}
	$.post("/admin/addReply",
		{
			articleId : form.articleId.value,
			boardId : form.boardId.value,
			body : form.body.value
		},
		function(data){
			alert(data.msg);
			if(data.success){
				form.body.value = "";
				articleDetail__drawReply(data.reply);
				if($(".replyStatus").html().length){
					$(".replyStatus").html("");
				}
			}
		},
		"json"
	)
}

function articleDetail__drawReply(data){
	var html = `
	<div class="reply">	
		<table>
			<tr>
				<td><button data-type="reply" class="like" type="button" onclick="articleDetail__updateLike(this, true);">좋아요</button> <span>0</span></td>
				<td><button data-type="reply" class="like" type="button" onclick="articleDetail__updateLike(this, false);">싫어요</button> <span>0</span></td>
			</tr>
			<tr>
				<th>번호</th> <td class="replyId id" data-id="${data.id}"> ${data.id}</td>
			</tr>
			<tr>
				<th>날짜</th> <td class="replyRegDate"> ${data.regDate}</td>
			</tr>
			<tr>
				<th>작성자</th> <td  class="clickable-contextMenu clickable" data-id="${data.memberId }" data-to="${data.extra.writer }"> ${data.extra.writer}</td>
			</tr>
			<tr>
				<td colspan='2'><pre class="replyBody">${data.body}</pre></td>				
			</tr>											
		</table>		
		
		<button type="button" onclick="articleDetail__deleteReply(this);">삭제</button>
		<button type="button" onclick="articleDetail__showReplyModifyForm(this);">수정</button>
			
		<hr>
	</div>`;
	
	$.parseHTML(html);
	$(".replyList").prepend(html);
	
	initContextMenu();	
}

function articleDetail__getAllReplies(){	
	var id = $(".articleId").attr("data-id");
	var boardId = $("#boardId").val();
	$.post("/admin/getOneArticleAllReplies",
		{
			articleId : id,
			boardId : boardId
		},
		function(data){			
			if(data.success){
				for(var i=0; i<data.replies.length ;i++){
					articleDetail__drawReply(data.replies[i]);
					
				}
				$(".replyList").find("table").each(function(index, item){
					articleDetail__getLikes($(this), "reply");
					
				});
				
				
			}else{
				$(".replyStatus").html(data.msg);
			}
		}
	)
}

function articleDetail__deleteReply(btn){
	var articleId = $(".articleId").attr("data-id");
	var boardId = $("#boardId").val();
	var id = $(btn).parent().find(".replyId").attr("data-id");		
	
	if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
		$(btn).parent().hide();
		$.get("/admin/deleteOneArticleOneReply",
			{
				articleId : articleId,
				boardId : boardId,
				id : id
			},
			function(data){
				
				if(data.success){
					$(btn).parent().remove();
					if(!$(".replyList").children().length){
						$(".replyStatus").html("댓글이 없습니다.");
					}
				}else{
					$(btn).parent().show();	
				}
			},
			"json"
		);
	}
}

function articleDetail__modifyReply(form){
	if(!checkEmpty(form.body)){
		alert("빈칸없이 채워주세요.");
		return ;
	}
	var replyContainer = hide;
	$.post("/admin/modifyReply",
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
				articleDetail__hideReplyModifyForm();
			}
		},
		"json"
	);
}

var hide;
function articleDetail__showReplyModifyForm(btn){
	
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

function articleDetail__hideReplyModifyForm(){
	
	$("#replyModifyForm").find("iput[name='id']").val("");
	$("#replyModifyForm").find("textarea[name='body']").val("");
	
	$("#replyAddForm").show();
	$("#replyModifyForm").hide();
	
	hide.show();
}

function articleDetail__getLikes(table, type){
	var articleId = table.find(".id").attr("data-id");
	var boardId = $("#boardId").val();
	
	$.get("/admin/getLikes",
		{
			relId : articleId,
			boardId : boardId,
			type : type
		},
		function(data){
			
			if(!data.success){
				alert(data.msg);
			}						
			articleDetail__drawArticleLike(table, data);
		},
		"json"
	);
}

function articleDetail__updateLike(btn, val){
	var articleId = $(btn).parent().parent().parent().find(".id").attr("data-id");
	var boardId = $("#boardId").val();
	var type = $(btn).attr("data-type");
	
	$.get("/admin/updateLike",
		{
			relId : articleId,
			boardId : boardId,
			type : type,
			val : val
		},
		function(data){
			alert(data.msg);
			if(data.success){
				articleDetail__getLikes($(btn).parent().parent().parent(), type);
			}
		},
		"json"
	);
}

function articleDetail__drawArticleLike(table, data){
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

function articleModify__checkForm(form){
	articleAdd__checkForm(form);
}

function articleModify__addFile(locationType){
	articleAdd__addFile(locationType);
}

function articleModify__check(btn){
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


function adminMemberMyPage__withdrawal(){
	if(confirm("정말 탈퇴 하시겠습니까?")){
		location.href = "/admin/withdrawal";
	}
}

function adminMemberChangeLoginPw__checkForm(form){
	if(!checkEmpty(form.temp_origin_loginPw) || !checkEmpty(form.temp_loginPw)){
		alert("빈칸을 채워주세요");
		return ;
	}
	
	form.origin_loginPw.value = encodeSHA1(form.temp_origin_loginPw);
	form.loginPw.value = encodeSHA1(form.temp_loginPw);
	
	form.submit();
}

var clickedMemberId;
var clickedMemberLoginId;
function showContextMenu(x, y){
	
	if($("#memberId").val() == clickedMemberId){
		$(".contextMenu").find("a").not("a:nth-child(1)").hide();		
	}else{
		$(".contextMenu").find("a").not("a:nth-child(1)").show();
	}
	$(".overlay").show();
	$(".contextMenu").css({'top':y, 'left':x}).show();
}

function hideContextMenu(){
	$(".contextMenu").hide();
}

function hideOverlay(){
	$(".overlay").parent().children().hide();
}

function showProfile(){
	$("#loading").show();
	$.post("/admin/getMemberProfile",
		{
			id : clickedMemberId
		},
		function(data){
			if(data.success){				
				var member = data.member;
				var html = `이름 : ${member.name}<br>
							이메일 : ${member.email}`;
				$(".profile-content").html(html);
				$(".loading").hide();
			}else{
				$(".profile-content").html(data.msg);
			}
		},
		"json"
	);
	hideContextMenu();
	$(".profile").show();
}

function showLetter(){
	$('.overlay').show();
	$(".contextMenu").hide();
	$(".loading").hide();
	$(".letter").show();
	$(".letter").find(".to").html("<h3>To : " + clickedMemberLoginId + "</h3>");
}

function close(btn){
	$(btn).parent().parent().hide();	
}

function checkLetterForm(form){
	if(!checkEmpty(form.body)){
		alert("빈칸을 채워주세요.");
		return ;
	}	
	$(form).parent().children().hide();
	$(".letter").find(".loading").show();
	$.post("/admin/sendLetter",
		{
			toId : clickedMemberId,
			body : form.body.value
		},
		function(data){
			alert(data.msg);
			if(data.success){
				form.body.value = "";				
				close($(".letter").find(".close"));
				showContextMenu();
			}else{				
				$(form).parent().children().show();
			}
			
			$(".letter").find(".loading").hide();
		},
		"json"
	);
}

function letter__deleteLetter(btn){
	
	if(!confirm("삭제 하시겠습니까?")){
		return ;
	}
	$(btn).attr("disabled", true);
	$.get("/admin/deleteLetter",
		{
			id : $(btn).attr("data-id")		
		},
		function(data){
			alert(data.msg);
			if(data.success){
				$(btn).parent().remove();
			}else{
				$(btn).attr("disabled", false);
			}
		}
	)
}
function initGetReply(){
	if($(".replyList").length){
		articleDetail__getAllReplies();
		articleDetail__getLikes($(".article"), "article");
	}	
		
}
function initGetMembers(){
	adminPage__getAllMembers();
}
function initContextMenu(){
	$(".close").click(function(){
		close(this);
		$(".overlay").hide();
	});
	
	$(".clickable-contextMenu").click(function(e){		
		
		if($(this).attr("data-id")){		
			clickedMemberId = $(this).attr("data-id");		
			clickedMemberLoginId = $(this).attr("data-to");
			showContextMenu(e.pageX, e.pageY);			
		}
		else{			
			showContextMenu();
		}
	});
	
	$(".overlay").click(function(){
		hideOverlay();
		$(".letter-content").hide();
	});	
	
	
	$(".clickable-letterContent").click(function(){
		$(".overlay").show();
		$(".letter-content").show();
		$(".content").html("<pre>" + $(this).html() + "</pre>");
	});
}
$(function(){	
	initGetReply();
	initContextMenu();
	initGetMembers();
	$("input").attr("maxlength", "50");
})