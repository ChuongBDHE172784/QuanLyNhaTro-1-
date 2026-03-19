package nhatro.web.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.RoomRequestDAO;

import java.io.IOException;
import java.sql.SQLException;

public class RejectRoomRequestServlet extends HttpServlet {

    private final RoomRequestDAO roomRequestDAO = new RoomRequestDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestIdStr = req.getParameter("requestId");
        if (requestIdStr == null || requestIdStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/requests");
            return;
        }

        try {
            int requestId = parsePositiveInt(requestIdStr, "requestId");
            roomRequestDAO.reject(getServletContext(), requestId);
        } catch (SQLException | IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/requests");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/admin/requests");
    }

    private static int parsePositiveInt(String s, String fieldName) {
        int v = Integer.parseInt(s);
        if (v <= 0) throw new IllegalArgumentException("Invalid " + fieldName);
        return v;
    }
}

