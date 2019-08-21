function checkFileTypeImg(file){
	var type = ["image/jpeg", "image/gif", "image/png"];
	
	if(!type.includes(file.type)){		
		alert("이미지 파일이 아닙니다.");
		return false;
	}
	return true;
}

function ArticleAdd__checkForm(form){
	form.title.value = form.title.value.trim();
	form.body.value = form.body.value.trim();
	var title = form.title.value;
	var body = form.body.value;
	
	if(title.length == 0 || body.length == 0){
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
		if(checkFileTypeImg(this.files[0])){
			type2.setAttribute("value", this.files[0].type);
		}else{
			this.value = "";
		}
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
	
	container.append(file, button ,type, type2);
	
	$(".ArticleAdd__fileList").append(container);
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