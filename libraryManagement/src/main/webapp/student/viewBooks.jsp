<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="com.library.DbConnection" %>

<%
/* Student session check */
if (session.getAttribute("studentId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>View Books</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>

<body>

<%@ include file="studentNavbar.jsp" %>

<div class="container mt-4">

    <h3 class="text-center mb-4">📚 Available Books</h3>

    <%
        Connection con = DbConnection.getConnection();

        String sql =
            "SELECT book_id, title, author, quantity " +
            "FROM book " +
            "WHERE status='active'";

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        boolean hasBook = false;

        if (rs.next()) {
            hasBook = true;
    %>

    <!-- BOOK TABLE -->
    <table class="table table-bordered table-hover text-center">
        <tr class="table-dark">
            <th>Book ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Available</th>
        </tr>

        <%
            do {
        %>
        <tr>
            <td><%= rs.getInt("book_id") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("author") %></td>
            <td>
                <span class="badge bg-success">
                    <%= rs.getInt("quantity") %>
                </span>
            </td>
        </tr>
        <%
            } while (rs.next());
        %>
    </table>

    <%
        } else {
    %>

    <!-- NO BOOK MESSAGE -->
    <div class="alert alert-info text-center">
        📭 No books available
    </div>

    <%
        }
        rs.close();
        ps.close();
        con.close();
    %>

</div>

</body>
</html>
