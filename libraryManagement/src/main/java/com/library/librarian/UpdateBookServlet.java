package com.library.librarian;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.DbConnection;

@WebServlet("/updateBookServlet")
public class UpdateBookServlet extends HttpServlet 
{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		String bookId = request.getParameter("id");
		Connection conn = null;
		PreparedStatement ps = null;

		try 
		{
		 conn = DbConnection.getConnection();			String sql = "UPDATE book SET title=?, author=?, quantity=? WHERE book_id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, request.getParameter("title"));
			ps.setString(2, request.getParameter("author"));
			ps.setString(3, request.getParameter("quantity"));
			ps.setString(4, bookId);
			
			ps.executeUpdate();
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
			
		}
	}
}
