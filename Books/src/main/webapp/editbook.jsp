<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>

<%
    String uid=(String)session.getAttribute("userId");
    if (uid == null || uid.isEmpty()) {
        out.print("<center><h2>Please Login!!</h2><a href='Login.html'>Goto Login Page</a></center>");
    } else {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EditBookDetails</title>
<link rel="stylesheet" href="CSS/Form.css">
<style>
body{
background-image: url('images/Bgimg.jpg') !important; /* Replace 'your-background-image.jpg' with the actual image file path */
background-size: cover;
background-position: center;
}
</style>
</head>
<body>
<!-- Your existing body content here -->
    <div class="container">
        <h1>Edit Book Information</h1>
        <form action="updatebook.jsp" method="post">
           

<%
   
    String clickedBookId = request.getParameter("bookId");
    String bid = (String) session.getAttribute("editBookId_" + clickedBookId);
    session.setAttribute("editFinalBid",bid);

    if (bid == null || bid.isEmpty()) {
        out.print("<center><h2>Please Login!!</h2><a href='Login.html'>Goto Login Page</a></center>");
    } else {
        try {
       
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
            Statement statement = conn.createStatement();
           
            String query = "SELECT * FROM tblbooks WHERE id = "+bid;
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            //preparedStatement.setString(1, bid);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                //String title = resultSet.getString("title");
                //out.println(title);
                //String author = resultSet.getString("author");
                //String publicationYear = resultSet.getString("publicationYear");
                String category = resultSet.getString("category");
                String price = resultSet.getString("price");
                String publisher = resultSet.getString("publisher");
                String description = resultSet.getString("description");
                String status = resultSet.getString("status");
                String language = resultSet.getString("language");
                //out.println("Your Dtaa is : "+title+author+publicationYear+category+price+publisher+description+status+language);

%>

    
          <div class="form-group">
                <label for="title">Book Title:</label>
                <input type="text" id="title" name="title" required value="<% out.print(resultSet.getString("title")); %>">
          </div>
            
         <div class="form-group">
		    <label for="author">Author:</label>
		    <input type="text" id="author" name="author" required value="<% out.print(resultSet.getString("author")); %>">
		</div>

		<div class="form-row">
          <div class="form-group">
	        <label for="publication_year">Publication Year:</label>
	        <input type="number" id="publication_year" name="publication_year" required value="<% out.print(resultSet.getString("publication_year")); %>">
    	 </div>

		<div class="form-group">
		    <label for="category">Category:</label>
		    <select id="category" name="category" required>
		        <option value="fiction" <%= category.equals("fiction") ? "selected" : "" %>>Fiction</option>
		        <option value="non-fiction" <%= category.equals("non-fiction") ? "selected" : "" %>>Non-Fiction</option>
		        <option value="mystery" <%= category.equals("mystery") ? "selected" : "" %>>Mystery</option>
		        <option value="romace" <%= category.equals("romace") ? "selected" : "" %>>Romace</option>
		        <option value="selfdevp" <%= category.equals("selfdevp") ? "selected" : "" %>>SelfDevelopment</option>
		        <option value="academics" <%= category.equals("academics") ? "selected" : "" %>>Academics</option>   
		    </select>
	 	</div>
	 	</div>

	 <div class="form-row">
		<div class="form-group">
		    <label for="price">Price:</label>
		    <input type="number" id="price" name="price" required value="<%= price %>">
		</div>

		<div class="form-group">
		    <label for="publisher">Publisher:</label>
		    <input type="text" id="publisher" name="publisher" required value="<%= publisher %>">
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
		    <label for="description">Description:</label><br>
		    <textarea id="description" name="description" rows="4" cols="50"><%= description %></textarea>
		</div>
	</div>

   <div class="form-row">
		<div class="form-group">
		    <label for="status">Status:</label><br>
		    <input type="radio" id="active" name="status" value="1" <%= status.equals("1") ? "checked" : "" %>> Active
		    <input type="radio" id="inactive" name="status" value="0" <%= status.equals("0") ? "checked" : "" %>> Inactive
		</div>

		<div class="form-group">
		    <label for="language">Language:</label><br>
		    <input type="checkbox" id="marathi" name="language" value="marathi" <%= language.contains("marathi") ? "checked" : "" %>> Marathi
		    <input type="checkbox" id="hindi" name="language" value="hindi" <%= language.contains("hindi") ? "checked" : "" %>> Hindi
		    <input type="checkbox" id="english" name="language" value="english" <%= language.contains("english") ? "checked" : "" %>> English
		    <input type="checkbox" id="other" name="language" value="other" <%= language.contains("other") ? "checked" : "" %>> Other
		</div>
	</div> 

            <div class="form-group">
                <input type="submit" value="Update">
            </div>
        </form>
    </div>
</body>
</html>

<%
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<center><h2>Error updating book details. Please try again.</h2><center>");
        }
    }
%>
<% } %>
