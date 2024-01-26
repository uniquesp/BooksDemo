<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Books</title>
</head>
<body>

<%
    String bname = request.getParameter("title");
    String author = request.getParameter("author");
    String year = request.getParameter("publication_year");
    String category = request.getParameter("category");
    String price = request.getParameter("price");
    String language = request.getParameter("language");
    String publisher = request.getParameter("publisher");
    String description = request.getParameter("description");
    String status = request.getParameter("status");
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());

    InputStream inputStream = null;
    Part filePart = request.getPart("image");

    if (filePart != null) {
        inputStream = filePart.getInputStream();
    }

    int updateQuery = 0;

    if (bname != null && author != null && year != null && category != null && price != null && language != null && publisher != null  && description != null  && status != null) {
        if (!bname.equals("") && !author.equals("") && !year.equals("") && !category.equals("") && !price.equals("") && !language.equals("") && !publisher.equals("") && !description.equals("") && !status.equals("")) {

            Connection conn = null; 

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
                Statement stmt=conn.createStatement();

                ResultSet rs=stmt.executeQuery("SELECT count(id) FROM tblbooks;");
                int c = 0, cnt = 0;
                while(rs.next())  {
                    cnt = Integer.parseInt(rs.getString(1));      
                }            
                c = cnt+1;

                String sql = "INSERT INTO tblbooks(id,title,author,publication_year,category,price,language,publisher,description,image,status,RegDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pst = conn.prepareStatement(sql);

                pst.setString(1, Integer.toString(c));
                pst.setString(2, bname);
                pst.setString(3, author);
                pst.setString(4, year);
                pst.setString(5, category);
                pst.setString(6, price);
                pst.setString(7, language);
                pst.setString(8, publisher);
                pst.setString(9, description);
                pst.setBlob(10, inputStream);           
                pst.setString(11, status);
                pst.setString(12, timestamp.toString());

                pst.executeUpdate();
            %>               
            <script>alert("Image Added !!")</script>
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

<script>
	alert("Books Added !!!")
    window.location.href = "addbooks.html";
</script>

</body>
</html>
