<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsData" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		  <meta http-equiv="refresh" content="1">
		<link rel="stylesheet" href="css/bootstrap.css">
		<title>Dashboard</title>
		<style type="text/css">
			a,a:hover{
				color: #000000;
				text-decoration:none;
			}
			#timeToRender {
				position:absolute; 
				bottom: 10px; 
				font-size: 20px; 
				font-weight: bold; 
				background-color: #d85757;
				padding: 0px 4px;
				color: #ffffff;}
			#logContainer {
				margin: 20px;
				height: 50px;
				  background: grey;
				  align-self: flex-end;
				  width: 100%;
				  height: 100px;
				  margin: 0;
				  justify-content: center;
				  align-items: center;
				  overflow:scroll;}
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
	 	if(userID==null){
	%>
		<script>
			location.href="index.jsp"
		</script>
	<%
	   	}else{
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">Eye Spy</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="bbs.jsp">Dashboard</a>
	      </li>
	      </ul>

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
			
	  </div>
	</nav>
	<div id="chartContainer" style="height: 370px; width: 100%;"></div>
	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
	<script type="text/javascript">
		window.onload = function() {  
		var dataPoints = [];
		var chart = new CanvasJS.Chart("chartContainer", {
			animationEnabled: true,
			theme: "light2",
		 	zoomEnabled: true,
			title: {
				text: "See what your Thermostat is sending ..."
			},
			axisY: {
				title: "Temperature",
				titleFontSize: 24,
				includeZero: false
			},
			data: [{
				type: "line",
				yValueFormatString: "#,##0.0## Trillion BTU",
				xValueType: "dateTime",
				dataPoints: dataPoints
			}]
		});
		 
		function addData(data) {
			for (var i = 0; i < data.length; i++) {
				dataPoints.push({
					x: data[i].timestamp,
					y: data[i].value
				});
			}
			chart.render();
		}
		 
		//change this to json
		$.getJSON("https://canvasjs.com/data/gallery/jsp/total-biomass-energy-consumption.json", addData);
		 
		}
	</script>
		<div id="chartContainer" style="height: 370px; width: 100%; padding-top: 20px margin-bottom: 10px;"></div>
		<span id="timeToRender"></span>
		<h4 class="display-4" style="text-align:center">Log History</h4>
		<% 
			//GET REQUEST
			PrintWriter script=response.getWriter();
	        URL url = new URL("http://34.73.52.137:8080/logTemps/getLast"); // /logTemps/getLast
			String inline = new String();
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(10000);
            conn.setRequestMethod("GET");
            conn.connect();
	        String time=new String(); int temp = -1000;
			String output = new String();
			String var = new String();
                if(conn != null){
                    //conn.setDoInput(true);
                    //conn.setDoOutput(true);

                    int resCode = conn.getResponseCode();
                    if(resCode != 200){ throw new RuntimeException("Failed GET request");}
                    else{
						Scanner sc = new Scanner(url.openStream());
						while(sc.hasNext())
						{
							inline=sc.nextLine(); //used to be +=
						}
						System.out.println("JSON data in string format");
						System.out.println(inline);
						sc.close(); 	
                    }
                    
                } 
                JSONParser parse = new JSONParser(); 
                JSONObject jobj = (JSONObject) parse.parse(inline);
                int dataNum = (int)(long) jobj.get("code");//jobj.get("code").asInt(); // check if this is okay
                String str = new String();
                if(dataNum ==0 ){
                		JSONObject o = (JSONObject) jobj.get("data"); 
		               	time = (String) o.get("timeStamp");
		               	temp = (int)(long)o.get("temp");
		                output = temp+" celsius @"+ time;%>
						<span style="font-family: 'Courier New'; color:black">The most recent data sent is [<%=output%>]</span>  					
<%
				}	
		%>
		<div id="logContainer" class="jumbotron" style="height: 400px; width: 100%; margin-bottom:20px; padding-top: 0px; padding-left:10px;">
		<% 
			//GET REQUEST
			script=response.getWriter();
	        url = new URL("http://34.73.52.137:8080/logTemps"); // /logTemps/getLast
			inline = new String();
	        conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(10000);
            conn.setRequestMethod("GET");
            conn.connect();
            time=new String(); temp = -1000;
            output = new String();
            var = new String();
                if(conn != null){
                    //conn.setDoInput(true);
                    //conn.setDoOutput(true);

                    int resCode = conn.getResponseCode();
                    if(resCode != 200){ throw new RuntimeException("Failed GET request");}
                    else{
						Scanner sc = new Scanner(url.openStream());
						while(sc.hasNext())
						{
							inline=sc.nextLine(); //used to be +=
						}
						System.out.println("JSON data in string format");
						System.out.println(inline);
						sc.close(); 	
                    }
                    
                } 
                parse = new JSONParser(); 
                jobj = (JSONObject) parse.parse(inline);
                dataNum = (int)(long) jobj.get("code");//jobj.get("code").asInt(); // check if this is okay
                str = new String();
                if(dataNum ==0 ){
                	JSONArray subObj = (JSONArray) jobj.get("data"); 
                	System.out.println(subObj.size());
	                for(int i=0; i<subObj.size();i++){
	                	JSONObject o= (JSONObject)subObj.get(i);
		               	time = (String) o.get("timeStamp");
		               	temp = (int)(long)o.get("temp");
		                output = temp+" celsius @"+ time;%>
						<span style="font-family: 'Courier New'; color:white"><%=output%><br></span>  					
		        <%        
		        		var+= output+'\n';
	                }              
                }
               	System.out.println(var);
			}	
		%>
		</div>  

	</body>
</html>
