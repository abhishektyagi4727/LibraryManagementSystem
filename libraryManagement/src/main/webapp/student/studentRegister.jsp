<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Registration</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animate.css -->
<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
body{
    background: linear-gradient(to right, #43cea2, #185a9d);
}
.register-card{
    max-width: 450px;
    margin: 80px auto;
}
</style>
</head>

<body>

<div class="container">
  <div class="card register-card shadow-lg
  animate__animated animate__fadeInUp">

    <div class="card-header bg-dark text-white text-center">
      <h4>🎓 Student Registration</h4>
    </div>

    <div class="card-body">
    <%
	String msg = request.getParameter("msg");
	if (msg != null) 
	{
    	if (msg.equals("duplicate")) 
    	{
	    %>
           <div class="alert alert-warning animate__animated animate__shakeX">
            ⚠ Username already exists. Please choose another one.
           </div>
	    <%
        } 
    	else if (msg.equals("error")) 
    	{
	    %>
           <div class="alert alert-danger animate__animated animate__shakeX">
            ❌ Something went wrong. Please try again.
           </div>
        <%
        }
     }
    %>
    <form action="/libraryManagement/studentRegisterServlet" method="post">
        <div class="mb-3">
          <label class="form-label fw-bold">Full Name</label>
          <input type="text" name="name"
          class="form-control" placeholder="Enter full name" required>
        </div>

        <div class="mb-3">
          <label class="form-label fw-bold">Username</label>
          <input type="text" name="username"
          class="form-control" placeholder="Enter username" required>
        </div>        
                <div class="mb-3">
          <label class="form-label fw-bold">Email</label>
          <input type="email" name="email"
          class="form-control" placeholder="Enter Email" required>
        </div>
        
                <div class="mb-3">
          <label class="form-label fw-bold">Phone</label>
          <input type="tel" name="phone"
          class="form-control" placeholder="Enter Phone" required>
        </div>
        
          <div class="mb-3">
          <label class="form-label fw-bold">Course</label>
          <input type="text" name="course"
          class="form-control" placeholder="Enter Course" required>
        </div>
        
          <div class="mb-3">
          <label class="form-label fw-bold">Semester</label>
          <input type="number" name="semester"
          class="form-control" placeholder="Enter Semester" required>
        </div>
        

        <div class="mb-3">
          <label class="form-label fw-bold">Password</label>
          <input type="password" name="password"
          class="form-control" placeholder="Create password" required>
        </div>
        
        
        <div class="mb-3">
          <label class="form-label fw-bold">Confirm Password</label>
          <input type="password" name="confirmPassword"
          class="form-control" placeholder="Confirm password" required>
        </div>

        <button class="btn btn-success w-100">
          Register
        </button>

      </form>
    </div>

    <div class="card-footer text-center">
      <small class="text-muted">
        Already registered?
        <a href="login.jsp" class="fw-bold text-decoration-none">
          Login here
        </a>
      </small>
    </div>

  </div>
</div>

</body>
</html>
