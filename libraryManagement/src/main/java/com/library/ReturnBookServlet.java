package com.library;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/returnBookServlet")
public class ReturnBookServlet extends HttpServlet 
{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{

		int issueId = Integer.parseInt(request.getParameter("issueId"));
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		String role = request.getParameter("role"); // student or admin

		try 
		{
			 Connection con = DbConnection.getConnection();

			// 1️⃣ Update issue status
			String updateIssue = "UPDATE issue SET status='RETURNED' WHERE issue_id=?";
			PreparedStatement ps1 = con.prepareStatement(updateIssue);
			ps1.setInt(1, issueId);
			ps1.executeUpdate();

			// 2️⃣ Increase book quantity
			String updateBook = "UPDATE book SET quantity = quantity + 1 WHERE book_id=?";
			PreparedStatement ps2 = con.prepareStatement(updateBook);
			ps2.setInt(1, bookId);
			ps2.executeUpdate();

			if ("admin".equals(role))
				response.sendRedirect("/libraryManagement/librarian/returnBook.jsp?msg=returned");
			else
				response.sendRedirect("/libraryManagement/student/returnBook.jsp?msg=returned");

		} catch (Exception e) {
			e.printStackTrace();
			if ("admin".equals(role))
				response.sendRedirect("/libraryManagement/librarian/returnBook.jsp?msg=error");
			else
				response.sendRedirect("/libraryManagement/student/returnBook.jsp?msg=error");
		}
	}
}
