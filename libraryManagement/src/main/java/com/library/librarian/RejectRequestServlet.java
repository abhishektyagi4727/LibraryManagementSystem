package com.library.librarian;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/rejectRequestServlet")
public class RejectRequestServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int requestId = Integer.parseInt(request.getParameter("requestId"));

		try {
			Connection con = DbConnection.getConnection();

			String sql = "UPDATE book_request SET status='REJECTED' WHERE request_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, requestId);
			ps.executeUpdate();

			response.sendRedirect("/libraryManagement/librarian/issueBook.jsp?msg=rejected");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/libraryManagement/librarian/issueBook.jsp?msg=error");
		}
	}
}
