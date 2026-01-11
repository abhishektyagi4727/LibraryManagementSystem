package com.library;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String role = req.getParameter("role");

        try {
            
            Connection con = DbConnection.getConnection();

            String query = null;

            if ("admin".equals(role)) {
                query = "SELECT * FROM admin WHERE username=? AND password=?";
            } else if ("student".equals(role)) {
                query = "SELECT * FROM student WHERE username=? AND password=?";
            } else {
                res.sendRedirect("login.jsp?msg=error");
                return;
            }

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rst = ps.executeQuery();

            if (rst.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", role);

                if ("admin".equals(role)) {
                    session.setAttribute("adminName", rst.getString("name"));
                    res.sendRedirect("librarian/adminDashboard.jsp");
                } else {
                    session.setAttribute("studentId", rst.getString("student_id"));
                    session.setAttribute("studentName", rst.getString("name"));
                    res.sendRedirect("student/studentDashboard.jsp");
                }
            } else {
                res.sendRedirect("login.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

