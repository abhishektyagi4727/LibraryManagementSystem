<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="com.library.DbConnection" %>

<%
if (session.getAttribute("adminName") == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Issue Book</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>
	<%@ include file="adminNavbar.jsp"%>
	<div class="container mt-4">
		<h3 class="text-center mb-4">📚 Book Issue Requests</h3>
		<%
		String msg = request.getParameter("msg");
		if (msg != null) {
			if (msg.equals("issued")) {
		%>
		<div class="alert alert-success text-center">✅ Book issued
			successfully</div>
		<%
		} else if (msg.equals("rejected")) {
		%>
		<div class="alert alert-warning text-center">❌ Book request
			rejected</div>
		<%
		} else if (msg.equals("error")) {
		%>
		<div class="alert alert-danger text-center">⚠️ Something went
			wrong</div>
		<%
		}
		}
		%>
		<%
		Connection con=DbConnection.getConnection();
		String sql = "SELECT br.request_id, s.student_id, s.name, b.book_id, b.title " + "FROM book_request br "
				+ "JOIN student s ON br.student_id=s.student_id " + "JOIN book b ON br.book_id=b.book_id "
				+ "WHERE br.status='PENDING'";

		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		boolean hasRecord = false;

		if (rs.next()) {
			hasRecord = true;
		%>

		<!-- TABLE WILL SHOW ONLY IF RECORD EXISTS -->
		<table class="table table-bordered table-striped text-center">
			<tr class="table-dark">
				<th>Request ID</th>
				<th>Student Name</th>
				<th>Book Title</th>
				<th>Action</th>
			</tr>

			<%
			do {
			%>
			<tr>
				<td><%=rs.getInt("request_id")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("title")%></td>
				<td>
					<form action="/libraryManagement/issueBookServlet" method="post"
						style="display: inline">
						<input type="hidden" name="requestId"
							value="<%=rs.getInt("request_id")%>"> <input
							type="hidden" name="studentId"
							value="<%=rs.getInt("student_id")%>"> <input
							type="hidden" name="bookId" value="<%=rs.getInt("book_id")%>">
						<button class="btn btn-success btn-sm">Approve</button>
					</form>

					<form action="rejectRequestServlet" method="post"
						style="display: inline">
						<input type="hidden" name="requestId"
							value="<%=rs.getInt("request_id")%>">
						<button class="btn btn-danger btn-sm">Reject</button>
					</form>
				</td>
			</tr>
			<%
			} while (rs.next());
			%>
		</table>

		<%
		} else {
		%>

		<!-- NO RECORD MESSAGE -->
		<div class="alert alert-info text-center">📭 No pending book
			issue requests</div>

		<%
		}
		%>

	</div>
</body>
</html>
