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
<title>Delete Book Details</title>
</head>
<body>

<%
    //String bookId = (String)session.getAttribute("finalBid");

    String clickedBookId = request.getParameter("bookId");
    String bookId = (String) session.getAttribute("deleteBookId_" + clickedBookId);

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
            out.print("<center><a href='books.jsp'>Goto Books List</a></center>");
        } else {
            out.println("<center><font-color='red'><h2>Failed to delete book. Please try again.</h2></center>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<center><font-color='red'><h2>Error deleting book. Please try again.</h2></center>");
    }
%>

<% } %>

</body>
</html>