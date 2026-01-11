package com.library;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet 
{
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException 
	{
		String user = req.getParameter("username");
		String pass = req.getParameter("password");
		String role = req.getParameter("role");
		try 
		{
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from " + role + " where username=? and password=?");

			ps.setString(1, user);
			ps.setString(2, pass);
			ResultSet rst = ps.executeQuery();

			if (rst.next()) 
			{
				HttpSession session = req.getSession();
				session.setAttribute("user", user);
				session.setAttribute("role", role);

				if (role.equals("admin"))
				{
					//session.setMaxInactiveInterval(10);
					session.setAttribute("adminName", rst.getString("name"));
					res.sendRedirect("librarian/adminDashboard.jsp");
				}
				else
				{
					session.setAttribute("studentId", rst.getString("student_id"));
					session.setAttribute("studentName", rst.getString("name"));
					res.sendRedirect("student/studentDashboard.jsp");
				}
			} 
			else 
			{
				res.sendRedirect("login.jsp?msg=error");
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
}
