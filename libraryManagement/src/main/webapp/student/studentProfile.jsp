<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="studentNavbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #e3f2fd, #f8f9fa);
        }
        .profile-card {
            max-width: 550px;
            margin: 60px auto;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .profile-header {
            background: #0d6efd;
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
            text-align: center;
        }
        .table th {
            width: 35%;
            background: #f1f1f1;
        }
    </style>
</head>

<body>
<%
Integer id=(Integer)request.getAttribute("studentId");
String userName=(String)request.getAttribute("username");
String name=(String)request.getAttribute("name");
%>
<div class="container">
    <div class="card profile-card">
        <div class="profile-header">
            <h4>👤 Student Profile</h4>
            <small>Library Management System</small>
        </div>

        <div class="card-body p-4">
            <table class="table table-bordered table-hover mb-0">
                <tr>
                    <th>Student ID</th>
                    <td><%=id %></td>
                </tr>
                <tr>
                    <th>Username</th>
                    <td><%=userName %></td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><%=name %></td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
