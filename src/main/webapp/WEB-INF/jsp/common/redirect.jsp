<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
	var msg = "${msg}";
	var historyBack = "${historyBack}";
	var redirectUrl = "${redirectUrl}";

	if(msg.trim().length != 0){
		alert(msg);
	}
	if(historyBack == "true"){
		history.back();
	}
	if(redirectUrl.length){
		location.replace(redirectUrl);
	}
</script>