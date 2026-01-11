<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.sql.*" pageEncoding="UTF-8"%>
<%@ include file="studentNavbar.jsp"%>
<%@ page import="com.library.db.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Request Book</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3 class="text-center">📚 Request a Book</h3>

    <%
    String msg = request.getParameter("msg");
    if ("success".equals(msg)) { %>
    
        <div class="alert alert-success">Book requested successfully</div>
    <% } else if ("already".equals(msg)) { %>
        <div class="alert alert-warning">You have already requested this book</div>
    <% } else if ("error".equals(msg)) { %>
        <div class="alert alert-danger">Error requesting book</div>
    <% } %>

    <table class="table table-bordered text-center mt-3">
        <tr class="table-dark">
            <th>Book</th>
            <th>Author</th>
            <th>Available Quantity</th>
            <th>Action</th>
        </tr>

        <%
        String studentId = (String) session.getAttribute("studentId");
        Connection con = DbConnection.getConnection();

        // Only show books that are available and not already requested/issued by this student
        String sql = "SELECT * FROM book b " +
                     "WHERE b.quantity > 0 AND b.book_id NOT IN (" +
                     "SELECT book_id FROM issue WHERE student_id=? AND status='ISSUED' " +
                     "UNION " +
                     "SELECT book_id FROM book_request WHERE student_id=? AND status IN ('PENDING','APPROVED')" +
                     ")";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, studentId);
        ps.setString(2, studentId);
        ResultSet rs = ps.executeQuery();

        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("author") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td>
                <form action="<%= request.getContextPath() %>/requestBookServlet" method="post">
                    <input type="hidden" name="bookId" value="<%= rs.getInt("book_id") %>">
                    <button class="btn btn-primary btn-sm">Request</button>
                </form>
            </td>
        </tr>
        <% } 

        if (!hasData) { %>
        <tr>
            <td colspan="4" class="text-muted">No books available for request</td>
        </tr>
        <% } 
        rs.close(); ps.close(); %>
    </table>
</div>
</body>
</html>
