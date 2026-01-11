<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>

<%@ page import="com.library.db.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Students</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #f4f6f9;
    }
    .card {
        margin-top: 50px;
    }
</style>
</head>

<body>
<%@ include file="adminNavbar.jsp"%>
<div class="container">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Student List</h4>
        </div>

        <div class="card-body">
            <table class="table table-bordered table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Student ID</th>
                        <th>Username</th>
                        <th>Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DbConnection.getConnection();
                        ps = con.prepareStatement(
                            "SELECT student_id, username, name FROM student"
                        );
                        rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("student_id") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td>
                            <a href="/libraryManagement/librarian/viewStudent.jsp?id=<%= rs.getInt("student_id") %>"
                               class="btn btn-sm btn-info">
                               View
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4' class='text-danger'>Error: "
                                + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>

                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
