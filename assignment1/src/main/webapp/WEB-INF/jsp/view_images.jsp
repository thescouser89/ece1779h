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
      <h1>My Images</h1>
    </div> 

	<div style="width:500px;padding:0px;">
		<!--%
			for (int i=0; i < imageArray.length; i++)
			{
		%-->
		
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
			<a href="/ece1779/jsp/view_image.jsp?imageid=ASDF"><img style="max-width:100px;max-height:75px;float:left;" src="http://i.imgur.com/nfUv5nx.jpg" /></a>
		<!--%
			}
		%-->
	</div>
	
	</body>

</html>
