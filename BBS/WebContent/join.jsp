<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Eye Spy - Join us!</title>
<style type="text/css">
@media (min-width:700px){
	#joinBlock{
		width: 60%;
	}
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light" style="margin-bottom: 30px">
	  <a class="navbar-brand" href="#">Eye Spy</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">

	    </ul>
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	  </div>
	</nav>
		
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
			script.println("location.href='main.jsp'");
			script.println("</script>");
	%>

	<%
		}else{
	%>


	<div class="container" id="joinBlock">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align:center;">Sign-up Page</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="ID" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="PASSWORD" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="NAME" name="userName" maxlength="20">
					</div>
					<div class="form-group" style="text-align:center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="female" checked>Female
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="male" checked>Male
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="email" name="userEmail" maxlength="50">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="Sign-Up">
				</form>			
			</div>

	</div>
	
	<div class="container" style="text-align:center">
		<p>Sign-up to spy on Big Brothers!</p>
	</div>
		<%
		}
	%>
	<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</html>