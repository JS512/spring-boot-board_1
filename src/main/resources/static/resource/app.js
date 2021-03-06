var lastLetterId = 0;
var	moveScroll = false;
var clickedMemberId;
var clickedMemberLoginId;
var lastSendLetterId = 0;
var getLetter;
var hide;

function checkLoginId(text){
	var unAvaliablePattern = /[`~!@\#$%^&*\()\-=+'"\\|;:<>.,?/{}[\]]/;
	return !unAvaliablePattern.test(text);
}
function checkLoginPw(text){
	var unAvaliablePattern = /[`()=+'"\\|;:<>.,?/{}[\]]/;
	return !unAvaliablePattern.test(text);
}
function checkName(text){
	var unAvaliablePattern = /[`~!@\#$%^&*\()\-_=+'"\\|;:<>.,?/{}[\]]/;
	return !unAvaliablePattern.test(text);
}
function checkEmail(text){
	var unAvaliablePattern = /[`~!\#$%^&*\()\=+'"\\|;:<>,?/{}[\]]/;
	return !unAvaliablePattern.test(text);
}
function replaceAll(str, searchStr, replaceStr) {
  return str.split(searchStr).join(replaceStr);
}
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
	$(form).find("input[type='button']").attr("disabled", true);
	$("input[type='file']").each(function(index, item){
		if($(item).val() == ''){
			$(item).parent().remove();
		}
	});		
	
	if(form.boardId == 1){
		$(form).attr("action","/admin/doAddArticle");
	}	
	
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
	location.href="/article/deleteOneArticle?id="+id+"&boardId="+boardId;
}

function articleDetail__modifyArticleCheck(id, boardId){
	if(!confirm("현재 게시물을 수정하시겠습니까?")){
		return ;
	}
	location.href="/article/modifyArticle?id="+id+"&boardId="+boardId;
}

function articleDetail__checkAddReplyForm(form){
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
	var html;
	
	if(data.blindStatus){
		html = `<div id="reply${data.id}">관리자에 의해 블라인드 처리된 댓글 입니다.<hr></div>`;		
	}else if(data.delStatus){
		html = `<div id="reply${data.id}">작성자에 의해 삭제된 댓글입니다.<hr></div>`;
	}else{
		html = `
			<div class="reply">	
			<table id="reply${data.id}">
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
					<td colspan='2' class="replyBody">${data.body}</td>				
				</tr>			
			</table>
			`;
			if( $("#memberId").length){
				if( $("#memberId").val() == data.memberId){
					html += `<button type="button" onclick="articleDetail__deleteReply(this);">삭제</button>
					<button type="button" onclick="articleDetail__showReplyModifyForm(this);">수정</button>`;
				}
				
				html += `<a data-type="reply" data-id="${data.id }" href="javascript:void(0);" onclick="showReportForm(this);">신고하기</a>`;
			}
			html += `	
			<hr>
		</div>`;
	}
	
	
	$.parseHTML(html);
	$(".replyList").prepend(html);	
	
}

function articleDetail__getAllReplies(){	
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
					articleDetail__drawReply(data.replies[i]);
					
				}
				$(".replyList").find("table").each(function(index, item){
					articleDetail__getLikes($(this), "reply");					
				});
				initContextMenu();				
				moveToIdInHTML();
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
		$.get("/article/deleteOneArticleOneReply",
			{
				articleId : articleId,
				boardId : boardId,
				id : id
			},
			function(data){
				
				if(data.success){
					$(btn).parent().html("<div>작성자에 의해 삭제되었습니다.<hr></div>");
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
				articleDetail__hideReplyModifyForm();
			}
		},
		"json"
	);
}


function articleDetail__showReplyModifyForm(btn){
	
	if(hide != null)
		hide.show();
	
	hide = $(btn).parent();
	hide.hide();
	
	$("#replyModifyForm").show();
	$("#replyAddForm").hide();
	
	$("#replyModifyForm").find("input[name='id']").val(hide.find(".replyId").attr("data-id"));
	$("#replyModifyForm").find("textarea[name='body']").html(replaceAll(hide.find(".replyBody").html(), "<br>", "\n"));
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
			articleDetail__drawArticleLike(table, data);
		},
		"json"
	);
}

function articleDetail__updateLike(btn, val){
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

var idCheck = false;
var emailCheck = false;
function memberJoin__checkForm(form){	
	
	if(!checkEmpty(form.loginId) || !checkEmpty(form.temp_loginPw)
			|| !checkEmpty(form.name) || !checkEmpty(form.email))
	{
		alert("빈칸없이 채워주세요");
		return ;
	}
	
	if(!checkLoginId(form.loginId.value)){		
		alert("아이디에 사용할수 없는 문자가 들어있습니다.\n(특수문자 '_'만 사용가능)");
		return ;
	}
	
	if(!checkLoginPw(form.temp_loginPw.value)){
		alert("비밀번호에 사용할 수 없는 특수문자가 들어있습니다.\n" +
				"(특수문자 !, @, #, $, %, ^, &, * 만 사용가능)");
		return ;
	}
	
	if(!checkName(form.name.value)){
		alert("이름에 특수문자가 들어있습니다.");
		return ;
	}
	
	if(!checkEmail(form.email.value)){
		alert("이메일에 사용할 수 없는 특수문자가 들어있습니다.\n" +
		"(특수문자 -, _ 만 사용가능)");
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

function memberJoin__loginIdDoubleCheck(btn){
	$(btn).prev().find("input").val($(btn).prev().find("input").val().trim());
	var loginId = $(btn).prev().find("input").val();
	if(loginId.length == 0){
		alert("빈칸없이 채워주세요");
		return ;
	}
	
	if(!checkLoginId(loginId)){		
		alert("아이디에 사용할수 없는 문자가 들어있습니다.\n(특수문자 '_'만 사용가능)");
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

function memberJoin__emailDoubleCheck(btn){
	$(btn).prev().find("input").val($(btn).prev().find("input").val().trim());
	var email = $(btn).prev().find("input").val();
	var pattern = /\w+@\w+\.\w+\.?\w*/;
	
	if(!pattern.test(email)){
		alert("이메일 형식에 맞지 않습니다.");
		return ;
	}
	
	if(!checkEmail(email)){
		alert("이메일에 사용할 수 없는 특수문자가 들어있습니다.\n" +
		"(특수문자 -, _ 만 사용가능)");
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

function memberJoin__resetEmail(){	
	emailCheck = false;
}

function memberJoin__resetLoginId(){	
	idCheck = false;
}

function memberLogin__checkForm(form){
	
	if(!checkEmpty(form.loginId) || !checkEmpty(form.temp_loginPw))
	{
		alert("빈칸없이 채워주세요");
		return ;
	}
	
	if(!checkLoginId(form.loginId.value)){		
		alert("아이디에 사용할수 없는 문자가 들어있습니다.\n(특수문자 '_'만 사용가능)");
		return ;
	}
	
	if(!checkLoginPw(form.temp_loginPw.value)){
		alert("비밀번호에 사용할 수 없는 특수문자가 들어있습니다.\n" +
				"(특수문자 !, @, #, $, %, ^, &, * 만 사용가능)");
		return ;
	}
	
	form.loginPw.value = encodeSHA1(form.temp_loginPw);	
	
	form.submit();
}

function memberMyPage__withdrawal(){
	if(confirm("정말 탈퇴 하시겠습니까?")){
		location.href = "/member/withdrawal";
	}
}

function memberMyPage__toggleProfileImg(checkbox){
	if(checkbox.checked){
		$(checkbox).parent().siblings("label").find("input[type='checkbox']").attr("disabled", true);
		if($(checkbox).attr("name") == 'modifyProfileImg'){
			$(checkbox).siblings("input[type='file']").show();
		}		
	}else{
		$(checkbox).parent().siblings("label").find("input[type='checkbox']").attr("disabled", false);
		if($(checkbox).attr("name") == 'modifyProfileImg'){
			$(checkbox).siblings("input[type='file']").val("");
			$(checkbox).siblings("input[type='file']").hide();
		}
	}
}

function memberMyPage__modifyMemberProfileImg(form){
	var select;	
	var msg = "한 개이상 선택해 주세요";
	$(form).find("input[type='checkbox']").each(function(index, item){
		if($(item).is(":checked")){
			if($(item).attr("name") == "modifyProfileImg"){
				if(!form.profileImg.value.length){
					msg = "파일을 선택해 주세요";					
				}else{
					select = true;
				}
			}else{
				select = true;
			}
		}
	});
	if(!select){
		alert(msg);
		return ;
	}
	$(form).find("button").attr("disabled", true);
	
	var formData = new FormData(form);
	
	$.ajax({
		type:"POST",
		enctype:"multipart/form-data",
		url:'/member/modifyMemberProfileImg',
		data:formData,
		processData: false, //prevent jQuery from automatically transforming the data into a query string
        contentType: false,
        cache:false,
        success:function(data){ 
        	alert(data.msg);
        	if(data.success){
        		location.reload();
        	}
        },
        complete:function(data){
        	$(form).find("input[type='checkbox']:checked").trigger('click');     	
        	$(form).find("button").attr("disabled", false);
        }
	});	
}

function memberFindLoginId__checkForm(form){
	if(!checkEmpty(form.name) || !checkEmpty(form.email)){
		alert("빈칸을 채워주세요");
		return ;
	}
	$(form).find("button").attr("disabled", true);
	$(".findLoginId").html("<h1>찾는중..</h1>");
	$.get("/member/doFindLoginId",
		{
			name : form.name.value.trim(),
			email : form.email.value.trim()
		},
		function(data){
			if(data.success){
				$(".findLoginId").html("<h2>아이디</h2>" + data.msg);
			}else{
				$(".findLoginId").html("");
				alert(data.msg);
			}
			
			$(form).find("button").attr("disabled", false);
		}
	)
}

function memberFindLoginPw__checkForm(form){
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

function memberChangeLoginPw__checkForm(form){
	if(!checkEmpty(form.temp_origin_loginPw) || !checkEmpty(form.temp_loginPw)){
		alert("빈칸을 채워주세요");
		return ;
	}
	
	if(!checkLoginPw(form.temp_loginPw.value)){
		alert("비밀번호에 사용할 수 없는 특수문자가 들어있습니다.\n" +
				"(특수문자 !, @, #, $, %, ^, &, * 만 사용가능)");
		return ;
	}
	
	form.origin_loginPw.value = encodeSHA1(form.temp_origin_loginPw);
	form.loginPw.value = encodeSHA1(form.temp_loginPw);
	
	form.submit();
}


function showContextMenu(x, y){
	
	if($("#memberId").val() == clickedMemberId){
		$(".contextMenu").find("a:nth-child(2)").hide();
	}else{
		$(".contextMenu").find("a:nth-child(2)").show();
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
	$.post("/member/getMemberProfile",
		{
			id : clickedMemberId
		},
		function(data){
			if(data.success){				
				var member = data.member;
				var html = `<img class="profile-img" src="/member/showProfileImg?memberId=${clickedMemberId}">
							<div>
							이름 : ${member.name}<br>
							이메일 : ${member.email}
							</div>`;
				
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
	$(".letter").children().show();
	$('.overlay').show();
	$(".contextMenu").hide();
	$(".loading").hide();
	$(".letter").show();
	$(".letter").find(".to").html("<h3>To : " + clickedMemberLoginId + "</h3>");
}

var clickedId;
var clickedType;
function showReportForm(obj){
	$(".report").children().show();
	$('.overlay').show();	
	$(".loading").hide();	
	$(".report").show();	
	clickedId = $(obj).attr("data-id");
	clickedType = $(obj).attr("data-type");
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
	$.post("/member/sendLetter",
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

function checkReportForm(form){
	if(!checkEmpty(form.body)){
		alert("빈칸을 채워주세요.");
		return ;
	}
	if(!confirm("해당 내용으로 신고를 하시겠습니까?")){
		return ;
	}
	$(form).parent().children().hide();
	$(".report").find(".loading").show();
	$.post("/member/sendReport",
		{
			relId : clickedId,
			relType: clickedType,
			body : form.body.value
		},
		function(data){
			alert(data.msg);
			if(data.success){
				form.body.value = "";				
				close($(".report").find(".close"));
				hideOverlay();
			}else{				
				$(form).parent().children().show();
			}
			
			$(".report").find(".loading").hide();
		},
		"json"
	);
}

function letter__getMemberLetterList(id, memberId){	
	$.post("/member/getMemberLetterList",
		{			
			memberId : memberId
		},
		function(data){						
			if(data.success){				
				
				for(var i=0 ;i < data.letters.length ;i++){
					letter__drawLetterList(data.letters[i], memberId);					
				}				
				
				$(".letter-content").children().show();
				moveToIdInContainer("#letter" + id);
				
				
				getLetter = setTimeout(function() {
					letter__getNewLetters(memberId);
				}, 1000);
			}else{
				alert(data.msg);
				$(".letter-content").find(".close").trigger();
			}
			$(".letter-content").find(".loading").hide();
		},
		"json"
	);
}

function letter__getNewLetters(memberId){
	$.post("/member/getMemberLetterList",
			{
				lastSendLetterId : lastSendLetterId,
				lastLetterId : lastLetterId,
				memberId : memberId
			},
			function(data){						
				if(data.success){
					
					for(var i=0 ;i < data.letters.length ;i++){
						letter__drawLetterList(data.letters[i], memberId);
						if(data.letters[i].id == lastSendLetterId && data.letters[i].viewStatus){
							letter_updateViewStatus();
						}
					}		
					
										
					if(!moveScroll){			
						if(data.letters.length > 1){							
							moveToIdInContainer("#letter" + data.letters[data.letters.length - 1].id);
							moveScroll = true;
						}
					}
					
					getLetter = setTimeout(function() {
						letter__getNewLetters(memberId);
					}, 1000);
				}else{
					alert(data.msg);					
				}				
			},
			"json"
		);
}

function letter__drawLetterList(letter, memberId){
	
	if(lastSendLetterId != letter.id){		
		var filtered = replaceAll(letter.body, "\n", "<br>");
		var html;
		if(letter.fromMemberId != memberId){
			html = `<div class="position-right width-half">`;
		}else{
			html = `<div class="position-left width-half">`;
		}
		html +=`			
				<div id="letter${letter.id}" class="padding-normal border-normal">${filtered}</div>
				<small> ${letter.regDate}</small>`;
		if(letter.fromMemberId != memberId){
			lastSendLetterId = letter.id;
			if(!letter.viewStatus){
				html +=  `<small class="letter-viewStatus">[읽지 않음]</small> <button class="letter-deleteBtn"  type="button" onclick="letter__deleteLetter(this);" data-id="${letter.id }">삭제</button>`;			
			}else{
				html +=  `<small>[읽음]</small>`;
			}
		}	
		html +=`
			</div>		
		`;
		$(".letter-content").find(".content").append(html);
		lastLetterId = letter.id;
	}
	
}

function letter_updateViewStatus(){
	$(".letter-viewStatus").removeClass("letter-viewStatus").html("[읽음]");
	$(".letter-deleteBtn").remove();
}


function letter__deleteLetter(btn){
	
	if(!confirm("삭제 하시겠습니까?")){
		return ;
	}
	$(btn).attr("disabled", true);
	$.get("/member/deleteLetter",
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


function letter__sendReply(form){
	if(!checkEmpty(form.body)){
		alert("빈칸을 채워주세요.");
		return ;
	}	
	$(form).find("button").attr("disabled", true);
	
	$.post("/member/sendLetter",
		{
			toId : clickedMemberId,
			body : form.body.value
		},
		function(data){
				
			if(data.success){
				form.body.value = "";
				moveScroll = false;
			}else{
				alert(data.msg);
			}
			
			$(form).find("button").attr("disabled", false);
		},
		"json"
	);
}

function articleList__checkView(id, boardId){	
	var read;
	var key;
	
	key = "read-" + ip() + "-"+ id+"-"+boardId;	
	
	read = localStorage.getItem(key);
	
	if(read == null){
		$.get("/article/addViewCnt",
				{
					boardId: boardId,
					id: id
				},
				function(data){
					if(data.success){
						localStorage.setItem(key, "1");
					}
				},
				"json"
		);
	}
}

function initGetReply(){
	if($(".replyList").length){
		articleDetail__getAllReplies();
		articleDetail__getLikes($(".article"), "article");
	}	
		
}

function initContextMenu(){
	$(".close").click(function(){
		close(this);
		$(".overlay").hide();
		lastLetterId = 0;
		moveScroll = false;		
		if(getLetter != null){
			clearTimeout(getLetter);
		}
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
		lastLetterId = 0;
		moveScroll = false;		
		if(getLetter != null){
			clearTimeout(getLetter);
		}
	});	
	
	
	$(".clickable-letterContent").click(function(){
		$(".overlay").show();
		$(".letter-content").children().hide();
		$(".letter-content").find(".loading").show();
		$(".letter-content").find(".content").html("");
		$(".letter-content").find(".targetMember").html("<strong>"+$(this).prev().attr("data-to")+"</strong> 와 대화중...");
		$(".letter-content").show();		
		clickedMemberId = $(this).attr("data-memberId");
		
		letter__getMemberLetterList($(this).attr("data-id"), $(this).attr("data-memberId"));				
	});
}

function moveToIdInHTML(){
	var id ;
	
	id = location.hash;
	
	if(id.length){
		var offset;		
		offset = $(id).offset();		
		$('html').animate({scrollTop : offset.top}, 400,function(){
			for(var i=0 ;i<2 ;i++){
				$(id).animate({	opacity: "0.20"	}, 500).animate({opacity:"1.0"}, 500);
			}
		});
		
	}
}
function moveToIdInContainer(toId){	
	var id = toId;
	
	if(id.length){	
		
		$(".content").scrollTop(0);
		var top = $(id).offset().top - $(".content").offset().top - ($(".content").height() - $(id).parent().height());
		
		$(".content").stop().scrollTop(top);
	}
}
$(function(){	
	initGetReply();
	initContextMenu();	
	if($(".checkFileType").length){
		$(".checkFileType").change(function(){
			checkFileTypeImg(this);
		});
	}
	$("input").attr("maxlength", "50");	
})

