<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>

<%@ page import="com.library.db.DbConnection" %>
<%@ include file="adminNavbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: #f4f6f9;
    }
</style>
</head>

<body>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Student Details</h4>
        </div>

        <div class="card-body">

        <%
            int studentId = Integer.parseInt(request.getParameter("id"));

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DbConnection.getConnection();
                ps = con.prepareStatement(
                    "SELECT student_id, username, name, email, phone, course, semester " +
                    "FROM student WHERE student_id = ?"
                );
                ps.setInt(1, studentId);
                rs = ps.executeQuery();

                if (rs.next()) {
        %>

        <table class="table table-bordered">
            <tr>
                <th>Student ID</th>
                <td><%= rs.getInt("student_id") %></td>
            </tr>
            <tr>
                <th>Username</th>
                <td><%= rs.getString("username") %></td>
            </tr>
            <tr>
                <th>Name</th>
                <td><%= rs.getString("name") %></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><%= rs.getString("email") %></td>
            </tr>
            <tr>
                <th>Phone</th>
                <td><%= rs.getString("phone") %></td>
            </tr>
            <tr>
                <th>Course</th>
                <td><%= rs.getString("course") %></td>
            </tr>
            <tr>
                <th>Semester</th>
                <td><%= rs.getString("semester") %></td>
            </tr>
        </table>

        <%
                } else {
        %>
            <p class="text-danger">Student not found!</p>
        <%
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>

        <a href="viewStudents.jsp" class="btn btn-secondary mt-3">Back</a>

        </div>
    </div>
</div>

</body>
</html>
