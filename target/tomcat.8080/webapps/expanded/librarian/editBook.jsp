<%@ include file="adminNavbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="com.library.db.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Book</title>
<style>
body {
    background: linear-gradient(to right, #00c6ff, #0072ff);
}
.addbook-card {
    max-width: 600px;
    margin: 50px auto;
}
</style>
</head>
<body>

<div class="container">
  <div class="card addbook-card shadow-lg animate__animated animate__fadeInDown">
    <div class="card-header bg-dark text-white text-center">
      <% String book_id=request.getParameter("id"); %>
      <h4>📚 Edit Current Book( ID: <%=book_id%>)</h4>
    </div>

    <div class="card-body">
	  <%
      try{
    	  Connection con = DbConnection.getConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT * FROM book where book_id=?");
			ps.setString(1, book_id);
			ResultSet rst = ps.executeQuery();
			if(rst.next())
			{%>
				<form action="/libraryManagement/updateBookServlet" method="post">
				  <input type="hidden" name="id" value="<%=book_id%>">
		          <div class="mb-3">
		            <label class="form-label fw-bold">Book Title</label>
		            <input type="text" name="title" class="form-control" value="<%=rst.getString("title")%>" required>
		        </div>

		        <div class="mb-3">
		            <label class="form-label fw-bold">Author</label>
		            <input type="text" name="author" class="form-control" value="<%=rst.getString("author")%>" required>
		        </div>

		        <div class="mb-3">
		            <label class="form-label fw-bold">Quantity</label>
		            <input type="number" name="quantity" class="form-control" value="<%=rst.getString("quantity")%>" min="1" required>
		        </div>

		        <button class="btn btn-success w-100">Update Book</button>
		      </form>	
			<%}
		}catch(Exception ex){}
	%>
    </div>
  </div>
</div>

</body>
</html>
