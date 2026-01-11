package com.library;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.library.db.DbConnection;

@WebServlet("/returnBookServlet")
public class ReturnBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int issueId = Integer.parseInt(request.getParameter("issueId"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String role = request.getParameter("role");

        try (Connection con = DbConnection.getConnection()) {

            if ("student".equals(role)) {

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE issue SET status='RETURN_REQUESTED' WHERE issue_id=?"
                );
                ps.setInt(1, issueId);
                ps.executeUpdate();

                response.sendRedirect("student/returnBook.jsp?msg=returned");

            } else if ("admin".equals(role)) {

                PreparedStatement ps1 = con.prepareStatement(
                    "UPDATE issue SET status='RETURNED', return_date=CURDATE() WHERE issue_id=?"
                );
                ps1.setInt(1, issueId);
                ps1.executeUpdate();

                PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE book SET quantity = quantity + 1 WHERE book_id=?"
                );
                ps2.setInt(1, bookId);
                ps2.executeUpdate();

                response.sendRedirect("librarian/returnBook.jsp?msg=returned");
            }

        } catch (Exception e) {
            e.printStackTrace();
//            response.sendRedirect("error.jsp");
            
        }
    }
}
