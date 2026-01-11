<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="com.library.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Books</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>
body {
    background-color: #f4f6f9;
}
</style>
</head>

<body>

<%@ include file="adminNavbar.jsp" %>

<div class="container mt-4">

    <h3 class="text-center mb-4 fw-bold">📚 All Books</h3>

    <!-- SUCCESS / ERROR MESSAGE -->
    <%
        String msg = request.getParameter("msg");
        if ("deleted".equals(msg)) {
    %>
        <div class="alert alert-success text-center">
            Book deleted successfully
        </div>
    <%
        } else if ("error".equals(msg)) {
    %>
        <div class="alert alert-danger text-center">
            Something went wrong
        </div>
    <%
        }
    %>

    <table class="table table-bordered table-hover shadow">
        <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Quantity</th>
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
                        "SELECT book_id, title, author, quantity " +
                        "FROM book WHERE status='active'");
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr class="text-center align-middle">
                <td><%= rs.getInt("book_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author") %></td>
                <td>
                    <span class="badge bg-success fs-6">
                        <%= rs.getInt("quantity") %>
                    </span>
                </td>

                <td>
                    <!-- DELETE (SOFT DELETE) -->
                    <form action="<%= request.getContextPath() %>/deleteBookServlet"
                          method="post"
                          style="display:inline;"
                          onsubmit="return confirm('Are you sure you want to delete this book?');">

                        <input type="hidden" name="id"
                               value="<%= rs.getInt("book_id") %>">

                        <button type="submit"
                                class="btn btn-sm btn-danger">
                            Delete
                        </button>
                    </form>

                    <!-- EDIT -->
                    <a href="editBook.jsp?id=<%= rs.getInt("book_id") %>"
                       class="btn btn-sm btn-success ms-1">
                        Edit
                    </a>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <tr>
                <td colspan="5" class="text-center text-danger">
                    Error loading books
                </td>
            </tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (ps != null) ps.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
        %>
        </tbody>
    </table>

</div>

</body>
</html>
