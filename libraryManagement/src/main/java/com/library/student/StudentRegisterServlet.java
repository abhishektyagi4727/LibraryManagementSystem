package com.library.student;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.DbConnection;

@WebServlet("/studentRegisterServlet")
public class StudentRegisterServlet extends HttpServlet 
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        String fullName = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;

        try 
        {
        	  conn = DbConnection.getConnection();

            String sql = "INSERT INTO student (name, username, password) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, username);
            ps.setString(3, password);

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
           
        }
    }
}
