<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>

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
    String[] languages = request.getParameterValues("language");
    String publisher = request.getParameter("publisher");
    String description = request.getParameter("description");
    String status = request.getParameter("status");
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
    
    String languageString = (languages != null) ? String.join(",", languages) : "";
	
    out.print("your Data is :"+bname+author+year+category+price+languages+publisher+description+status+timestamp);

   // if (bname != null && author != null && year != null && category != null && price != null && languageString != null && publisher != null  && description != null  && status != null) {
       /// if (!bname.equals("") && !author.equals("") && !year.equals("") && !category.equals("") && !price.equals("") && !languageString.equals("") && !publisher.equals("") && !description.equals("") && !status.equals("")) {
			
        	 Connection conn = null; // Declare Connection outside the try block
        	 
        try {
        	 Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
             Statement stmt=conn.createStatement();
             out.print("Conection Established !!");
             
             ResultSet rs=stmt.executeQuery("SELECT count(id) FROM tblbooks	;");
             int c = 0,cnt=0;
             while(rs.next())  {
             cnt = Integer.parseInt(rs.getString(1));      
             }            
             c = cnt+1;

		

            String sql = "INSERT INTO tblbooks(id,title,author,publication_year,category,price,language,publisher,description,status,RegDate) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);

            pst.setString(1, Integer.toString(c));
            pst.setString(2, bname);
            pst.setString(3, author);
            pst.setInt(4,Integer.parseInt(year));
            pst.setString(5, category);
            pst.setString(6, price);
            pst.setString(7, languageString);
            pst.setString(8, publisher);
            
            Clob clobDescription = conn.createClob();
            clobDescription.setString(1, description);
            pst.setClob(9, clobDescription);
            
            pst.setString(10, status);
            pst.setString(11, timestamp.toString());

            pst.executeUpdate();
            out.print("Added onto a db");
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
        //}
   // }
%>

 <script>
 	//alert("Books Added !!")
 	//window.location.href = "addbooks.html";
 
 </script>

</body>
</html>
