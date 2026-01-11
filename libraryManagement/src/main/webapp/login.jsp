<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library Login</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animate.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<script>
 function enableButton(){
	 var selectedValue=document.getElementById("role").value
	 if(selectedValue!=-1)
		 document.getElementById("login").disabled=false //Enabling button
     else
    	 document.getElementById("login").disabled=true
 }
</script> 
<style>
body{
    background: linear-gradient(to right, #4facfe, #00f2fe);
}
.login-card{
    max-width: 400px;
    margin: 100px auto;
}
</style>
</head>

<body>

<div class="container">
  <div class="card login-card shadow-lg
  animate__animated animate__fadeInDown">

    <div class="card-header bg-dark text-white text-center">
      <h4>📚 Library Login</h4>
    </div>
	
    <div class="card-body">
    
    <!-- Display error message if exists -->
        <% String msg = request.getParameter("msg");
         if(msg != null) 
         {
            if(msg.equals("error")) 
            { %>
               <div class="alert alert-danger animate__animated animate__shakeX">
                   Invalid username or password!
               </div>
      	    <%} 
            else if(msg.equals("registered")) 
            { %>
               <div class="alert alert-success animate__animated animate__fadeIn">
                   Registration successful! Please login.
               </div>
             <%}
             else if(msg.equals("logout"))
             {
        	 %>
        	   <div class="alert alert-info animate__animated animate__fadeIn">
        	      You have been logged out successfully.
        	   </div>
        	 <%
        	 }
         }
      %>
    
      <form action="loginServlet" method="post">

        <div class="mb-3">
          <label class="form-label fw-bold">Username</label>
          <input type="text" name="username"
          class="form-control" placeholder="Enter username" required>
        </div>

        <div class="mb-3">
          <label class="form-label fw-bold">Password</label>
          <input type="password" name="password"
          class="form-control" placeholder="Enter password" required>
        </div>

        <div class="mb-3">
          <label class="form-label fw-bold">Login As</label>
          <select name="role" id="role" class="form-select" onchange="enableButton()">
            <option value="-1">Select role</option>
            <option value="admin">Admin</option>
            <option value="student">Student</option>
          </select>
        </div>

        <button class="btn btn-success w-100 mb-2" id="login" disabled="disabled">Login</button>

      </form>

      <!-- Student Register Link -->
      <div class="text-center mt-3">
        <span class="text-dark">New Student?</span>
        <a href="/libraryManagement/student/studentRegister.jsp"
           class="fw-bold text-decoration-none">
           Register here
        </a>
      </div>

    </div>

    <div class="card-footer text-center">
      <small class="text-muted">
        Student Library Management System
      </small>
    </div>

  </div>
</div>

</body>
</html>
