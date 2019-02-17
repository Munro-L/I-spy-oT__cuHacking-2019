<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Eye Spy</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">Eye Spy</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="main.jsp">Main Page<span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="bbs.jsp">Dashboard</a>
	      </li>
	      </ul>
	      <%
	      	if(userID==null){
	      %>
		<script>
			location.href="index.jsp"
		</script>
		<%
	      	}else{
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">access<span class="caret"></span></a>
			
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">Logout</a></li>
				</ul>
			</li>	
		</ul>
		<%
	      	}
		%>
	  </div>
	</nav>
	
	<div class="container">
		<p>Main menus? should be here</p>
	</div>
	<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</html>