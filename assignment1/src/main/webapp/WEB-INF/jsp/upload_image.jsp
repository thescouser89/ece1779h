<%@ page import="ca.utoronto.ece1779.database.User" %>
<%@ page import="ca.utoronto.ece1779.images.ImageHelper" %>
<%@ page import="ca.utoronto.ece1779.database.Image" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.*" %>

<%
	// If not logged in, redirect to login
	if (session.getAttribute("username") == null){
		response.sendRedirect("login.jsp");
	}
	
	// get root directory of web application, random file name
	String patha = this.getServletContext().getRealPath("/");        
	String key11 = "MyObjectKey_" + UUID.randomUUID();
	String name11 = patha+key11;
	out.println(name11);
	
	// If post request to upload
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		try {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			// Parse the request
			List /* FileItem */ items = upload.parseRequest(request);
			
			FileItem theFile = null;
			
			// Parse the request
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                    theFile = item;
					break;
                }
            }
			
			// get root directory of web application, random file name
			String path = this.getServletContext().getRealPath("/");        
			String key1 = "/temp_images/MyObjectKey_" + UUID.randomUUID();
			String filepath = path+key1;
			
			out.println(filepath);
			
			// store file in server
			File file1 = new File(filepath); 
			theFile.write(file1);
			
			String username = (String) session.getAttribute("username");
			ImageHelper ih = new ImageHelper(User.findUser(username).getId(),filepath); 
			Image im = ih.uploadImagesToS3AndSaveToDatabase();
			
		} catch (Exception ex) {
			out.println("something went wrong");
			throw new ServletException (ex);
		} finally {
		}
	}

%>

<!DOCTYPE html>
<html>
	<head>
		<title>Upload Image</title>
		<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE" />
		<meta charset="utf-8">
		<script>
		</script>
	</head>

	<jsp:include page="includes/header.jsp" />
	
	<body>
    <h1>Upload Image</h1>
    <form action="/ece1779/jsp/upload_image.jsp"  enctype="multipart/form-data" method="post">
		User ID <input type="text" name="userID" value="${username}"><br />
		What is the image files to upload? <input type="file" name="theFile"><br />
		<input type="submit" value="Send">
		<input type="reset">
    </form>

  </body>

</html>
