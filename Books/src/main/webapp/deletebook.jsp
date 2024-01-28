<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DeleteBookDetails</title>
</head>
<body>

<%
    String bookId = (String)session.getAttribute("bookId");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
        
        String deleteQuery = "DELETE FROM tblbooks WHERE id=?";
        PreparedStatement deleteStatement = conn.prepareStatement(deleteQuery);

        deleteStatement.setString(1, bookId);

        int rowsAffected = deleteStatement.executeUpdate();

        conn.close();

        if (rowsAffected > 0) {
            out.println("<h2>Book deleted successfully!</h2>");
        } else {
            out.println("<h2>Failed to delete book. Please try again.</h2>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error deleting book. Please try again.</h2>");
    }
%>

</body>
</html>