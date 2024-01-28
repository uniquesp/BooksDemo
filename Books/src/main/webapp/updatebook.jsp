<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
    
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
<title>Update Book</title>
</head>
<body>


<%
    String bookId = (String) session.getAttribute("editFinalBid");
    String myDemoBookID = (String)session.getAttribute("myDemoBookID");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String publicationYear = request.getParameter("publication_year");
    String category = request.getParameter("category");
    String price = request.getParameter("price");
    String publisher = request.getParameter("publisher");
    String description = request.getParameter("description");
    String status = request.getParameter("status");
    String[] languages = request.getParameterValues("language");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
        
        String updateQuery = "UPDATE tblbooks SET title=?, author=?, publication_year=?, category=?, price=?, publisher=?, description=?, status=?, language=? WHERE id=?";
        PreparedStatement updateStatement = conn.prepareStatement(updateQuery);

        updateStatement.setString(1, title);
        updateStatement.setString(2, author);
        updateStatement.setString(3, publicationYear);
        updateStatement.setString(4, category);
        updateStatement.setString(5, price);
        updateStatement.setString(6, publisher);
        updateStatement.setString(7, description);
        updateStatement.setString(8, status);
        updateStatement.setString(9, String.join(", ", languages));
        updateStatement.setString(10, bookId);

        int rowsAffected = updateStatement.executeUpdate();

        conn.close();

        if (rowsAffected > 0) {
            out.println("<h2>Book details updated successfully!</h2>");
        } else {
            out.println("<h2>Failed to update book details. Please try again.</h2>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error updating book details. Please try again.</h2>");
    }
%>

<% } %>
</body>
</html>