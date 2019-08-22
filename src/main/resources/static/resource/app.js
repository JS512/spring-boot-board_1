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