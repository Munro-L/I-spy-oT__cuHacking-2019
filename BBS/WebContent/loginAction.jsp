<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID!=null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Already Logged in.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result ==1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='bbs.jsp'"); // when it's logged in move on to the dashboard
			script.println("</script>");
		}
		else if (result==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Wrong Password.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID doesn't exist.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else if (result==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error.')");
			script.println("history.back()");
			script.println("</script>");
		}
		%>
</body>
</html>