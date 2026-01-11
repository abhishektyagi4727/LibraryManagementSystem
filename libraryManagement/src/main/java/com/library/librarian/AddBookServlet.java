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

@WebServlet("/addBookServlet")
public class AddBookServlet extends HttpServlet 
{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		String title = request.getParameter("title");
		String author = request.getParameter("author");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		Connection conn = null;
		PreparedStatement ps = null;

		try 
		{
			
			  conn = DbConnection.getConnection();
			String sql = "INSERT INTO book (title, author, quantity) VALUES (?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, author);
			ps.setInt(3, quantity);

			int i = ps.executeUpdate();

			if (i > 0) {
				response.sendRedirect("/libraryManagement/librarian/addBook.jsp?msg=success");
			} else {
				response.sendRedirect("/libraryManagement/librarian/addBook.jsp?msg=error");
			}

		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			response.sendRedirect("/libraryManagement/librarian/addBook.jsp?msg=error");
		} 
			}
}
