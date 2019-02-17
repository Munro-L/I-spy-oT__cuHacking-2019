<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eye Spy</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<%
		if (userID == null){
	%>
	<script>
	location.href="login.jsp"
	</script>
	<%
		}else{
	%>
	<script>
	location.href="bbs.jsp"
	</script>
	<%
		}
	%>
</body>
</html>