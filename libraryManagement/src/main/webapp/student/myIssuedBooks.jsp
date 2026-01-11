<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>My Issued Books</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>

<body>
	<%@ include file="studentNavbar.jsp"%>
	<div class="container mt-4">

		<h3 class="text-center mb-4">📚 My Issued Books</h3>

		<table class="table table-bordered table-striped text-center">
			<tr class="table-dark">
				<th>Book Title</th>
				<th>Issue Date</th>
				<th>Return Date</th>
				<th>Status</th>
			</tr>

			<%
			ResultSet rst = (ResultSet) request.getAttribute("rs");
			boolean hasData = false;

			while (rst != null && rst.next())
			{
				hasData = true;
			%>
			<tr>
				<td><%=rst.getString("title")%></td>
				<td><%=rst.getDate("issue_date")%></td>
				<td><%=rst.getDate("return_date")%></td>
				<td><span class="badge <%="ISSUED".equals(rst.getString("status")) ? "bg-success" : "bg-secondary"%>">
						<%=rst.getString("status")%>
				</span></td>
			</tr>
			<%
			}
			%>

			<%
			if (!hasData) {
			%>
			<tr>
				<td colspan="4" class="text-muted">No books issued yet</td>
			</tr>
			<%
			}
			%>

		</table>

	</div>
</body>
</html>
