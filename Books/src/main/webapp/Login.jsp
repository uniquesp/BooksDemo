<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
    <%
        String email = request.getParameter("email");
        String password = request.getParameter("pass");

        String jdbcURL = "jdbc:mysql://localhost:3306/books";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String sql = "SELECT * FROM tblusers WHERE EmailId=? AND PasswordHash=?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()) {
            	String userId = Integer.toString(rs.getInt("id"));
                HttpSession ses = request.getSession();
                ses.setAttribute("userId", userId);
                response.sendRedirect("books.jsp");
            } else {
    
                out.println("<font color='red' size='18'>Invalid Credentials !!!</font>");
                out.println("<a href='Login.html' size='10'>Try Again</a>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
