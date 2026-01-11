package com.library.librarian;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.DbConnection;

@WebServlet
("/issueBookServlet")
public class IssueBookServlet extends HttpServlet 
{

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int requestId = Integer.parseInt(request.getParameter("requestId"));
		int studentId = Integer.parseInt(request.getParameter("studentId"));
		int bookId = Integer.parseInt(request.getParameter("bookId"));

		try {
			 Connection con = DbConnection.getConnection();
			// 1️⃣ Insert into issue table
			String issueSql = "INSERT INTO issue(student_id,book_id,issue_date,return_date,status) "
					+ "VALUES(?,?,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY),'ISSUED')";
			PreparedStatement ps1 = con.prepareStatement(issueSql);
			ps1.setInt(1, studentId);
			ps1.setInt(2, bookId);
			ps1.executeUpdate();

			// 2️⃣ Update book quantity
			String updateBook = "UPDATE book SET quantity=quantity-1 WHERE book_id=?";
			PreparedStatement ps2 = con.prepareStatement(updateBook);
			ps2.setInt(1, bookId);
			ps2.executeUpdate();

			// 3️⃣ Delete request
			String deleteReq = "DELETE FROM book_request WHERE request_id=?";
			PreparedStatement ps3 = con.prepareStatement(deleteReq);
			ps3.setInt(1, requestId);
			ps3.executeUpdate();

			response.sendRedirect("/libraryManagement/librarian/issueBook.jsp?msg=issued");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/libraryManagement/librarian/issueBook.jsp?msg=error");
		}
	}
}
