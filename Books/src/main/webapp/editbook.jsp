<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>

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
            <!-- Your existing form fields here -->

<%
    String bid = (String)session.getAttribute("bookId");
    if (bid == null || bid.isEmpty()) {
        out.print("<center><h2>Please Login!!</h2><a href='Login.html'>Goto Login Page</a></center>");
    } else {
        try {
        	out.println(bid);
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
            Statement statement = conn.createStatement();
            out.println("Connected to DB !!");
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
            <!-- Populate other fields similarly -->
            <div class="form-group">
    <label for="author">Author:</label>
    <input type="text" id="author" name="author" required value="<% out.print(resultSet.getString("author")); %>">
</div>

<div class="form-row">
    <div class="form-group">
        <label for="publication_year">Publication Year:</label>
        <input type="text" id="publication_year" name="publication_year" required value="<% out.print(resultSet.getString("publication_year")); %>">
    </div>

<div class="form-group">
    <label for="category">Category:</label>
    <select id="category" name="category" required>
        <option value="fiction" <%= category.equals("fiction") ? "selected" : "" %>>Fiction</option>
        <option value="non-fiction" <%= category.equals("non-fiction") ? "selected" : "" %>>Non-Fiction</option>
        <!-- Add more categories as needed -->
    </select>
</div>

<div class="form-group">
    <label for="price">Price:</label>
    <input type="text" id="price" name="price" required value="<%= price %>">
</div>

<div class="form-group">
    <label for="publisher">Publisher:</label>
    <input type="text" id="publisher" name="publisher" required value="<%= publisher %>">
</div>

<div class="form-group">
    <label for="description">Description:</label><br>
    <textarea id="description" name="description" rows="4" cols="50"><%= description %></textarea>
</div>

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
        }
    }
%>
