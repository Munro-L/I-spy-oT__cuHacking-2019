<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width intial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Eye Spy</title>
<style type="text/css">
@media (min-width:900px){
	#loginBlock{
		width: 50%;
	}
}

body{
	height: 100%;
	overflow:hidden;
}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<%
		if (userID != null){ //when the user is logged in, cannot go to a join page
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Already Logged in.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
	%>

	<%
		}else{
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light"  style="margin-bottom: 30px">
	  <a class="navbar-brand" href="#">Eye Spy</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Link</a>
	      </li>
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          Dropdown
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	          <a class="dropdown-item" href="#">Action</a>
	          <a class="dropdown-item" href="#">Another action</a>
	          <div class="dropdown-divider"></div>
	          <a class="dropdown-item" href="#">Something else here</a>
	        </div>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link disabled" href="#">Disabled</a>
	      </li>
	    </ul>
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	  </div>
	</nav>
		
	<div class="container" id="loginBlock">
			<div class="jumbotron" style="padding-top: 30px;">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align:center;">Login Page</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="ID" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="PASSWORD" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="login">
				</form>			
				<a type="button" class="btn btn-secondary form-control" style="margin-top: 10px;" href="join.jsp">sign up</a>	
			</div>

	</div>
	
	<div class="container" style="text-align:center">
		<p>Let's spy on what data big companies are retrieving! </p>
	</div>
	<%
	}
	%>
	</body>
	<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</html>