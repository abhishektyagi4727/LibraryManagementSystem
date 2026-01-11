<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="studentNavbar.jsp"%>
<%@ page import="com.library.DbConnection"%>

<!DOCTYPE html>
<html>
<head>
<title>My Book Requests</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>
	<div class="container mt-4">
		<h3 class="text-center">📚 My Book Request Status</h3>

		<table class="table table-bordered text-center mt-3">
			<tr class="table-dark">
				<th>Book</th>
				<th>Request Date</th>
				<th>Status</th>
			</tr>

			<%
			Connection con = DbConnection.getConnection();

			String sql = "SELECT b.title, br.request_date, br.status " + "FROM book_request br "
					+ "JOIN book b ON br.book_id=b.book_id " + "WHERE br.student_id=?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setObject(1, session.getAttribute("studentId"));
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				
			%>
			<tr>
				<td><%=rs.getString("title")%></td>
				<td><%=rs.getDate("request_date")%></td>
				
					<%
					String status = rs.getString("status").trim().toUpperCase();
					%>
				
				<td>
					<%
					if ("PENDING".equals(status)) {
					%> <span class="badge bg-warning">Pending</span> <%
                    } else if ("APPROVED".equals(status)) {
                    %> <span class="badge bg-success">Approved</span> <%
                    } else {
                    %> <span class="badge bg-danger">Rejected</span> <%
                    }
                     %>
				</td>

			

			</tr>
			<%
			}
			%>

		</table>
	</div>
</body>
</html>
