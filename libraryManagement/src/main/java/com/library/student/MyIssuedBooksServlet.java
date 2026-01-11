package com.library.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/myIssuedBooksServlet")
public class MyIssuedBooksServlet extends HttpServlet 
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String studentId = (String)session.getAttribute("studentId");

		if (studentId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		try {
			Connection con = DbConnection.getConnection();

			String sql = "SELECT b.title, i.issue_date, i.return_date, i.status "
					+ "FROM issue i JOIN book b ON i.book_id=b.book_id " + "WHERE i.student_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, studentId);

			ResultSet rs = ps.executeQuery();
			request.setAttribute("rs", rs);
			request.getRequestDispatcher("/student/myIssuedBooks.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
