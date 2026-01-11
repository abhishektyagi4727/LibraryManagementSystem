package com.library.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.library.db.DbConnection;

@WebServlet("/requestBookServlet")
public class RequestBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String studentId = (String) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("bookId")); // only bookId is sent

        try (Connection con = DbConnection.getConnection()) {

            // 1️⃣ Check if student already requested or issued this book
            String checkSql = "SELECT * FROM book_request WHERE student_id=? AND book_id=? AND status IN ('PENDING','APPROVED')";
            try (PreparedStatement ps = con.prepareStatement(checkSql)) {
                ps.setString(1, studentId);
                ps.setInt(2, bookId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    response.sendRedirect(request.getContextPath() + "/student/requestBook.jsp?msg=already");
                    return;
                }
            }

            // 2️⃣ Insert new book request
            String sql = "INSERT INTO book_request(book_id, student_id, request_date, status) VALUES (?, ?, CURDATE(), 'PENDING')";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, bookId);
                ps.setString(2, studentId);
                ps.executeUpdate();
            }

            // 3️⃣ Redirect with success
            response.sendRedirect(request.getContextPath() + "/student/requestBook.jsp?msg=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/student/requestBook.jsp?msg=error");
        }
    }
}
