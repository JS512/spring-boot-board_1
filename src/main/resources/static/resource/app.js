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