<%@ include file="adminNavbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
      <h4>📚 Add New Book</h4>
    </div>

    <div class="card-body">

      <!-- Show success/error messages -->
      <%
         String msg = request.getParameter("msg");
         if(msg != null)
         {
             if(msg.equals("success"))
             {
      %>
                 <div class="alert alert-success animate__animated animate__fadeIn">
                     Book added successfully!
                 </div>
      <%     } 
             else if(msg.equals("error")) 
             { %>
                 <div class="alert alert-danger animate__animated animate__shakeX">
                     Error adding book. Try again.
                 </div>
      <%     }
         }
      %>

      <form action="/libraryManagement/addBookServlet" method="post">
        <div class="mb-3">
            <label class="form-label fw-bold">Book Title</label>
            <input type="text" name="title" class="form-control" placeholder="Enter book title" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">Author</label>
            <input type="text" name="author" class="form-control" placeholder="Enter author name" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold">Quantity</label>
            <input type="number" name="quantity" class="form-control" placeholder="Enter quantity" min="1" required>
        </div>

        <button class="btn btn-success w-100">Add Book</button>
      </form>
    </div>
  </div>
</div>

</body>
</html>
