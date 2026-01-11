<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" pageEncoding="UTF-8"%>
<%@ page import="com.library.db.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View All Books</title>
<style>
body {
	background: #f4f6f9;
}
.table-container {
	margin-top: 40px;
}
</style>
</head>

<body>

	<%@ include file="adminNavbar.jsp"%>

	<div class="container table-container animate__animated animate__fadeIn">

		<h3 class="text-center mb-4 fw-bold">📚 All Books (Admin View)</h3>
		<table class="table table-bordered table-hover shadow-sm">
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

				try 
				{
					 con = DbConnection.getConnection();

					ps = con.prepareStatement("SELECT * FROM book");
					rs = ps.executeQuery();

					while (rs.next()) 
					{
				%>
				<tr class="text-center">
					<td><%=rs.getInt("book_id")%></td>
					<td><%=rs.getString("title")%></td>
					<td><%=rs.getString("author")%></td>
					<td><span class="badge bg-success fs-6"> <%=rs.getInt("quantity")%>
					</span></td>
					<td><a href="/libraryManagement/deleteBookServlet?id=<%=rs.getInt("book_id")%>"
						class="btn btn-sm btn-danger"
						onclick="return confirm('Are you sure?')"> Delete</a>
						<a href="editBook.jsp?id=<%=rs.getInt("book_id")%>"
						class="btn btn-sm btn-success"> Edit </a>
					</td>
				</tr>
				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				%>
				<tr>
					<td colspan="5" class="text-center text-danger">Error loading
						books</td>
				</tr>
				<%
				} finally {
				try {
					if (rs != null)
						rs.close();
				} catch (Exception e) {
				}
				try {
					if (ps != null)
						ps.close();
				} catch (Exception e) {
				}
				try {
					if (con != null)
						con.close();
				} catch (Exception e) {
				}
				}
				%>
			</tbody>
		</table>

	</div>

</body>
</html>
