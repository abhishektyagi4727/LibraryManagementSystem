package com.library.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/studentProfile")
public class StudentProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = session.getAttribute("studentId").toString();

        try (Connection con = DbConnection.getConnection()) {

            String sql = "SELECT student_id, username, name ,email,phone,course,semester,password FROM student WHERE student_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, studentId);
           
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("studentId", rs.getInt("student_id"));
                request.setAttribute("username", rs.getString("username"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phone", rs.getString("phone"));
                request.setAttribute("course", rs.getString("course"));
                request.setAttribute("semester", rs.getInt("semester"));
                request.setAttribute("password", rs.getString("password"));
                
            }

            request.getRequestDispatcher("/student/studentProfile.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("student/dashboard.jsp");
        }
    }
}
