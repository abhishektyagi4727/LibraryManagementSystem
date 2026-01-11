package com.library.librarian;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/deleteBookServlet")
public class DeleteBookServlet extends HttpServlet 
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		String bookId = request.getParameter("id");
		Connection conn = null;
		PreparedStatement ps = null;

		try 
		{
			 conn= DbConnection.getConnection();
			String sql = "DELETE FROM book WHERE book_id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, bookId);
			
			int rows = ps.executeUpdate();
			response.sendRedirect("/libraryManagement/librarian/viewBooks.jsp");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			response.sendRedirect("/libraryManagement/librarian/viewBooks.jsp?msg=error");
		} 
		finally 
		{
			try 
			{
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
