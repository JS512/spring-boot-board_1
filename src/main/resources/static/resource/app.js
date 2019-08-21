function ArticleAdd__checkForm(form){
	form.title.value = form.title.value.trim();
	form.body.value = form.body.value.trim();
	var title = form.title.value;
	var body = form.body.value;
	
	if(title.length == 0 || body.length == 0){
		alert("빈칸 없이 채워주세요.");
		return false;
	}
	
	form.submit();
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