<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.sql.*" pageEncoding="UTF-8"%>
<%@ include file="adminNavbar.jsp"%>
<%@ page import="com.library.db.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin Return Book</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="container mt-4">
    <h3 class="text-center">📕 Return Requests</h3>

    <%
    String msg = request.getParameter("msg");
    if ("returned".equals(msg)) {
    %>
        <div class="alert alert-success">Book returned successfully</div>
    <% } %>

    <table class="table table-bordered text-center">
        <tr class="table-dark">
            <th>Student</th>
            <th>Book</th>
            <th>Issue Date</th>
            <th>Action</th>
        </tr>

        <%
        Connection con = DbConnection.getConnection();

        String sql =
            "SELECT i.issue_id, b.book_id, s.name, b.title, i.issue_date " +
            "FROM issue i " +
            "JOIN student s ON i.student_id=s.student_id " +
            "JOIN book b ON i.book_id=b.book_id " +
            "WHERE i.status='RETURN_REQUESTED'";

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        boolean found = false;
        while (rs.next()) {
            found = true;
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getDate("issue_date") %></td>
            <td>
                <form action="/libraryManagement/returnBookServlet" method="post">
                    <input type="hidden" name="issueId" value="<%= rs.getInt("issue_id") %>">
                    <input type="hidden" name="bookId" value="<%= rs.getInt("book_id") %>">
                    <input type="hidden" name="role" value="admin">
                    <button class="btn btn-success btn-sm">Accept Return</button>
                </form>
            </td>
        </tr>
        <% }

        if(!found){
        %>
        <tr>
            <td colspan="4" class="text-danger fw-bold">No return requests</td>
        </tr>
        <% }

        con.close();
        %>
    </table>
</div>
</body>
</html>
