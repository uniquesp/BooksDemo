<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
</head>
<body>
    <%
    String fname = request.getParameter("name");
    String mail = request.getParameter("email");
    String phone = request.getParameter("mobile");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String add = request.getParameter("add");
    String intrest = request.getParameter("intrest");
    String pass = request.getParameter("pass");
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());



    if (fname != null && mail != null && phone != null && dob != null && gender != null && intrest != null && pass != null) {
        if (!fname.equals("") && !mail.equals("") && !phone.equals("") && !dob.equals("") && !gender.equals("") && !intrest.equals("") && !pass.equals("")) {

            Connection conn = null; // Declare Connection outside the try block

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
                Statement stmt=conn.createStatement();

                ResultSet rs=stmt.executeQuery("SELECT count(id) FROM tblusers;");
                int c = 0,cnt=0;
                while(rs.next())  {
                cnt = Integer.parseInt(rs.getString(1));      
                }            
                c = cnt+1;
                
                String sql = "INSERT INTO tblusers(id,FullName, EmailId, PasswordHash, ContactNo, dob, gender, Address, Intrest, RegDate) VALUES(?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst = conn.prepareStatement(sql);

            	pst.setString(1, Integer.toString(c));
                pst.setString(2, fname);
                pst.setString(3, mail);
                pst.setString(4, pass);
                pst.setString(5, phone);
                pst.setString(6, dob);
                pst.setString(7, gender);
                pst.setString(8, add);
                pst.setString(9, intrest);
                pst.setString(10, timestamp.toString());

                pst.executeUpdate();
                %>               
                
 <% 
      		} catch (Exception e) {
                out.print(e);
                e.printStackTrace();
            } finally {
                try {
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

 <script>alert("Registration Successful !!")
 	 window.location.href = "Login.html";
 
 </script>
</body>
</html>
