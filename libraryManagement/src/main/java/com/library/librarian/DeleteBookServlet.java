package com.library.librarian;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.DbConnection;

@WebServlet("/deleteBookServlet")
public class DeleteBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("id"));

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps =
                 con.prepareStatement(
                     "UPDATE book SET status='inactive' WHERE book_id=?")) {

            ps.setInt(1, bookId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect(
                        request.getContextPath() +
                        "/librarian/viewBooks.jsp?msg=deleted");
            } else {
                response.sendRedirect(
                        request.getContextPath() +
                        "/librarian/viewBooks.jsp?msg=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath() +
                    "/librarian/viewBooks.jsp?msg=error");
        }
    }
}
