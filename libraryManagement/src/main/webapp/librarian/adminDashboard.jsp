<%@ include file="adminNavbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>
body{
    background:#f4f6f9;
}
.card-hover:hover{
    transform: scale(1.05);
    transition: 0.3s;
}
</style>
</head>

<body>
<div class="container mt-4">

  <h3 class="text-center mb-4 animate__animated animate__fadeIn">
    Welcome, Admin 👋
  </h3>

  <div class="row g-4">

    <!-- Add Book -->
    <div class="col-md-4">
      <div class="card text-bg-primary shadow card-hover
      animate__animated animate__zoomIn">
        <div class="card-body text-center">
          <h5>Add Book</h5>
          <p>Insert new books</p>
          <a href="/libraryManagement/librarian/addBook.jsp" class="btn btn-light">Go</a>
        </div>
      </div>
    </div>

    <!-- View Books -->
    <div class="col-md-4">
      <div class="card text-bg-success shadow card-hover
      animate__animated animate__zoomIn animate__delay-1s">
        <div class="card-body text-center">
          <h5>View Books</h5>
          <p>List all books</p>
          <a href="/libraryManagement/librarian/viewBooks.jsp" class="btn btn-light">Go</a>
        </div>
      </div>
    </div>

    <!-- Issue Book -->
    <div class="col-md-4">
      <div class="card text-bg-warning shadow card-hover
      animate__animated animate__zoomIn animate__delay-2s">
        <div class="card-body text-center">
          <h5>Issue Book</h5>
          <p>Issue book to student</p>
          <a href="/libraryManagement/librarian/issueBook.jsp" class="btn btn-dark">Go</a>
        </div>
      </div>
    </div>

    <!-- Return Book -->
    <div class="col-md-4">
      <div class="card text-bg-info shadow card-hover
      animate__animated animate__zoomIn">
        <div class="card-body text-center">
          <h5>Return Book</h5>
          <p>Accept returned books</p>
          <a href="/libraryManagement/librarian/returnBook.jsp" class="btn btn-dark">Go</a>
        </div>
      </div>
    </div>

    <!-- Students -->
    <div class="col-md-4">
      <div class="card text-bg-secondary shadow card-hover
      animate__animated animate__zoomIn animate__delay-1s">
        <div class="card-body text-center">
          <h5>Students</h5>
          <p>View students list</p>
          <a href="viewStudentsServlet" class="btn btn-light">Go</a>
        </div>
      </div>
    </div>

    <!-- Logout -->
    <div class="col-md-4">
      <div class="card text-bg-danger shadow card-hover
      animate__animated animate__zoomIn animate__delay-2s">
        <div class="card-body text-center">
          <h5>Logout</h5>
          <p>End session</p>
          <a href="/libraryManagement/logout.jsp" class="btn btn-light">Logout</a>
        </div>
      </div>
    </div>

  </div>
</div>

</body>
</html>
