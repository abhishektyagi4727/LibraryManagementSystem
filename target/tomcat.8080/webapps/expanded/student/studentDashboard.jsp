<%@ include file="studentNavbar.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Dashboard</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animate.css -->
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
body{
    background:#eef2f7;
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
    Welcome, Student 👋
  </h3>

  <div class="row g-4">

    <!-- View Books -->
    <div class="col-md-4">
      <div class="card text-bg-primary shadow card-hover
      animate__animated animate__zoomIn">
        <div class="card-body text-center">
          <h5>View Books</h5>
          <p>Browse available books</p>
          <a href="/libraryManagement/student/viewBooks.jsp" class="btn btn-light">View</a>
        </div>
      </div>
    </div>

    <!-- Issue Book -->
    <div class="col-md-4">
      <div class="card text-bg-success shadow card-hover
      animate__animated animate__zoomIn animate__delay-1s">
        <div class="card-body text-center">
          <h5>Issue Book</h5>
          <p>Request book issue</p>
          <a href="/libraryManagement/student/requestBook.jsp" class="btn btn-light">Issue</a>
        </div>
      </div>
    </div>
	<!-- Request Status -->
	<div class="col-md-4">
  	  <div class="card text-bg-dark shadow card-hover
      animate__animated animate__zoomIn animate__delay-1s">
        <div class="card-body text-center">
          <h5>Request Status</h5>
          <p>Track book request</p>
          <a href="/libraryManagement/student/requestStatus.jsp" class="btn btn-light">Check</a>
        </div>
      </div>
    </div>
    <!-- Return Book -->
    <div class="col-md-4">
      <div class="card text-bg-warning shadow card-hover
      animate__animated animate__zoomIn animate__delay-2s">
        <div class="card-body text-center">
          <h5>Return Book</h5>
          <p>Return issued book</p>
          <a href="/libraryManagement/student/returnBook.jsp" class="btn btn-dark">Return</a>
        </div>
      </div>
    </div>

    <!-- My Issued Books -->
    <div class="col-md-4">
      <div class="card text-bg-info shadow card-hover
      animate__animated animate__zoomIn">
        <div class="card-body text-center">
          <h5>My Issued Books</h5>
          <p>View issue history</p>
          <a href="/libraryManagement/myIssuedBooksServlet" class="btn btn-dark">View</a>
        </div>
      </div>
    </div>

    <!-- Profile -->
    <div class="col-md-4">
      <div class="card text-bg-secondary shadow card-hover
      animate__animated animate__zoomIn animate__delay-1s">
        <div class="card-body text-center">
          <h5>My Profile</h5>
          <p>View student details</p>
          <a href="/libraryManagement/studentProfile" class="btn btn-light">Profile</a>
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
