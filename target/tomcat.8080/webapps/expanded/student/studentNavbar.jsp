<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animate.css -->
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow
animate__animated animate__fadeInDown">
  <div class="container-fluid">

    <a class="navbar-brand fw-bold" href="/libraryManagement/student/studentDashboard.jsp">
      🎓 Student Panel | <%=session.getAttribute("studentName") %> | <%=session.getAttribute("user") %>
    </a>

    <button class="navbar-toggler" type="button"
      data-bs-toggle="collapse" data-bs-target="#studentNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="studentNav">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

        <li class="nav-item">
          <a class="nav-link" href="/libraryManagement/student/studentDashboard.jsp">Dashboard</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="/libraryManagement/student/viewBooks.jsp">View Books</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="/libraryManagement/myIssuedBooksServlet">My Issued Books</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="/libraryManagement/student/requestBook.jsp" title="Request book issue">Issue Book</a>
        </li>
        <li class="nav-item">
    		<a class="nav-link" href="/libraryManagement/student/requestStatus.jsp"> Request Status</a>
		</li>
        <li class="nav-item">
          <a class="nav-link" href="/libraryManagement/student/returnBook.jsp" title="Return issued book">Return Book</a>
        </li>
         <li class="nav-item">
    		<a class="nav-link" href="/libraryManagement/studentProfile"> Profile</a>
		</li>

        <li class="nav-item">
          <a class="nav-link text-warning fw-semibold" href="/libraryManagement/logout.jsp">
            Logout
          </a>
        </li>

      </ul>
    </div>
  </div>
</nav>
