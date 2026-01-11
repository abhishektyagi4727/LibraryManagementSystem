package com.library.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/studentRegisterServlet")
public class StudentRegisterServlet extends HttpServlet 
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        String fullName = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String course = request.getParameter("course");
        String semester = request.getParameter("semester");

        

        Connection conn = null;
        PreparedStatement ps = null;

        try 
        {
        	 conn = DbConnection.getConnection();

            String sql = "INSERT INTO student (name, username, password,email,phone,course,semester) VALUES (?, ?, ?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, course);
            ps.setString(7, semester);


            ps.executeUpdate();

            // ✅ Success
            response.sendRedirect("login.jsp?msg=registered");

        } 
        catch (SQLIntegrityConstraintViolationException e) 
        {
            // ✅ Duplicate username
            response.sendRedirect("/libraryManagement/student/studentRegister.jsp?msg=duplicate");
        }
        catch (Exception e) 
        {
            e.printStackTrace();
            response.sendRedirect("/libraryManagement/student/studentRegister.jsp?msg=error");
        } 
        finally 
        {
            try { if(ps != null) ps.close(); } catch (Exception e) {}
            try { if(conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
