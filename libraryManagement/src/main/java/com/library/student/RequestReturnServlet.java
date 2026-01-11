package com.library.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.library.DbConnection;

@WebServlet("/requestReturnServlet")
public class RequestReturnServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int issueId = Integer.parseInt(request.getParameter("issueId"));

        try (Connection con = DbConnection.getConnection()) {
            String sql = "UPDATE issue SET status='RETURN_REQUESTED' WHERE issue_id=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, issueId);
                ps.executeUpdate();
            }
            response.sendRedirect(request.getContextPath() + "/student/returnBook.jsp?msg=requested");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/student/returnBook.jsp?msg=error");
        }
    }
}
