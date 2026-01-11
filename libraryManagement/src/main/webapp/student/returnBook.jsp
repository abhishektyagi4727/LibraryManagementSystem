<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" pageEncoding="UTF-8"%>
<%@ include file="studentNavbar.jsp"%>
<%@ page import="com.library.db.DbConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Return Book</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>
	<div class="container mt-4">
		<h3 class="text-center">📕 Return Book</h3>

		<%
		String msg = request.getParameter("msg");
		if ("returned".equals(msg)) {
		%>
		<div class="alert alert-success">Book returned successfully</div>
		<%
		} else if ("error".equals(msg)) {
		%>
		<div class="alert alert-danger">Error while returning book</div>
		<%
		}
		%>

		<table class="table table-bordered text-center">
			<tr class="table-dark">
				<th>Book</th>
				<th>Issue Date</th>
				<th>Return</th>
			</tr>

			<%
			 Connection con = DbConnection.getConnection();

			String sql = "SELECT i.issue_id, b.book_id, b.title, i.issue_date " + "FROM issue i JOIN book b ON i.book_id=b.book_id "
					+ "WHERE i.student_id=? AND i.status='ISSUED'";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, (String) session.getAttribute("studentId"));
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString("title")%></td>
				<td><%=rs.getDate("issue_date")%></td>
				<td>
					<form action="/libraryManagement/returnBookServlet" method="post">
						<input type="hidden" name="issueId"
							value="<%=rs.getInt("issue_id")%>"> <input type="hidden"
							name="bookId" value="<%=rs.getInt("book_id")%>"> <input
							type="hidden" name="role" value="student">
						<button class="btn btn-warning btn-sm">Return</button>
					</form>
				</td>
			</tr>
			<%
			}
			%>

		</table>
	</div>
</body>
</html>
