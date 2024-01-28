<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    String uid=(String)session.getAttribute("userId");
    if (uid == null || uid.isEmpty()) {
        out.print("<center><h2>Please Login!!</h2><a href='Login.html'>Goto Login Page</a></center>");
    } else {
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Books</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="CSS/Table.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
    
    <div class="wrapper" style="background-image: url('images/Bgimg.jpg');">
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-5">
                                <h2>Book <b>Management</b></h2>
                            </div>
                            <div class="col-sm-7">
                                <a href="addbooks.html" class="btn btn-secondary"><i class="material-icons">&#xE147;</i> <span>Add New Book</span></a>
                                <a href="Logout.jsp" class="btn btn-secondary"><i class="material-icons">logout</i> <span>Logout</span></a>                      
                            </div>
                        </div>
                    </div>
                    
                    <%@ page import="java.sql.*" %>
                    <%
                        Class.forName("com.mysql.jdbc.Driver");            
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
                        Statement statement = conn.createStatement() ;
                        ResultSet resultset = statement.executeQuery("select * from tblbooks") ;
                        String st="";
                        int count = 1;
                    %>

                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>                     
                                <th>Author</th>
                                <th>PublicationYear</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                while(resultset.next()) { 
                                    String bookId = resultset.getString(1);
                                    HttpSession sesid = request.getSession();
                                    sesid.setAttribute("bookId", bookId);
                            %>
                            <tr>
                                <td><%= count %></td>
                                <td><%= resultset.getString(2) %></td>
                                <td><%= resultset.getString(3) %></td>
                                <td><%= resultset.getString(4) %></td>
                                <td><%= resultset.getString(5) %></td>
                                <td><%= resultset.getString(6) %></td>
                                <% 
                                    String status = resultset.getString(10);
                                    st = (status.equals("1")) ? "Active" : "Inactive";
                                %>
                                <td><%= st %></td>
                                <td>
                                    <a href="editbook.jsp?bookId=<%= bookId %>" class="settings" title="Edit" data-toggle="tooltip"><i class="material-icons">edit</i></a>
                                    <a href="deletebook.jsp?bookId=<%= bookId %>" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">delete</i></a>
                                </td>
                            </tr>
                            <% 
                                count++;
                            } %>
                            
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </div>   
    </div>  
</body>
</html>
<% } %>
