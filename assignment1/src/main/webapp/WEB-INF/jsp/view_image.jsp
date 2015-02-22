<%
	// If not logged in, redirect to login
	if (session.getAttribute("username") == null){
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<title>My Images</title>
		<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE" />
		<meta charset="utf-8">
		<script>
		</script>
	</head>

	<jsp:include page="includes/header.jsp" />
	
	<body>

    <div>
      <h1>Image ASDF</h1>
    </div> 

	<div style="width:500px;padding:0px;">
		<table>
			<tr>
				<th>Original:</th>
			</tr>
			<tr>
				<td><img style="max-width:200px;max-height:150px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></td>
			</tr>
			<tr>
				<th>Transform 1:</th>
			</tr>
			<tr>
				<td><img style="max-width:200px;max-height:150px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></td>
			</tr>
			<tr>
				<th>Transform 2:</th>
			</tr>
			<tr>
				<td><img style="max-width:200px;max-height:150px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></td>
			</tr>
			<tr>
				<th>Transform 3:</th>
			</tr>
			<tr>
				<td><img style="max-width:200px;max-height:150px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></td>
			</tr>
		</table>
		
	</div>
	
	</body>

</html>
