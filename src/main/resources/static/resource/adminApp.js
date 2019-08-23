function adminPage__getAllMembers(){
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
	$("table").find("tbody").html("");
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
	  		<td>${member.loginId}</td>
	  		<td>${member.name}</td>
	  		<td>${member.email}</td>
	  		<td>${auth}</td>
	  		<td><button data-id="${member.id}" onclick="adminPage__deleteMember(this);">회원 삭제</button></td>
  		</tr>`;
	}
	$("table").find("tbody").append(html);
}

$(function(){
	adminPage__getAllMembers();
})