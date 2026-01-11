<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.sql.*" pageEncoding="UTF-8"%>
<%@ include file="studentNavbar.jsp"%>
<%@ page import="com.library.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Return Book</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h3 class="text-center">📕 Return Book</h3>

    <%
    String msg = request.getParameter("msg");
    if ("requested".equals(msg)) { %>
        <div class="alert alert-success">Return requested successfully</div>
    <% } else if ("error".equals(msg)) { %>
        <div class="alert alert-danger">Error requesting return</div>
    <% } %>

    <table class="table table-bordered text-center">
        <tr class="table-dark">
            <th>Book</th>
            <th>Issue Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
        String studentId = (String) session.getAttribute("studentId");
        Connection con = DbConnection.getConnection();
        String sql = "SELECT i.issue_id, b.book_id, b.title, i.issue_date, i.status " +
                     "FROM issue i JOIN book b ON i.book_id=b.book_id " +
                     "WHERE i.student_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, studentId);
        ResultSet rs = ps.executeQuery();

        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getDate("issue_date") %></td>
            <td><%= rs.getString("status") %></td>
            <td>
                <%
                if ("ISSUED".equals(rs.getString("status"))) {
                %>
                <form action="<%= request.getContextPath() %>/requestReturnServlet" method="post">
                    <input type="hidden" name="issueId" value="<%= rs.getInt("issue_id") %>">
                    <button class="btn btn-warning btn-sm">Request Return</button>
                </form>
                <%
                } else {
                    out.print("-");
                }
                %>
            </td>
        </tr>
        <% } 
        if (!hasData) { %>
        <tr>
            <td colspan="4" class="text-muted">No issued books</td>
        </tr>
        <% } rs.close(); ps.close(); %>
    </table>
</div>
</body>
</html>
