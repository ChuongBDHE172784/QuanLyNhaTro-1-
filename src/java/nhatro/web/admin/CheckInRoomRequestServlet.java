package nhatro.web.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.RoomRequestDAO;

import java.io.IOException;
import java.sql.SQLException;

public class CheckInRoomRequestServlet extends HttpServlet {

    private final RoomRequestDAO roomRequestDAO = new RoomRequestDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestIdStr = req.getParameter("requestId");
        if (requestIdStr == null || requestIdStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/requests");
            return;
        }
        try {
            int requestId = Integer.parseInt(requestIdStr);
            if (requestId > 0) {
                roomRequestDAO.markCheckedIn(getServletContext(), requestId);
            }
        } catch (NumberFormatException | SQLException ignored) {
        }
        resp.sendRedirect(req.getContextPath() + "/admin/requests");
    }
}
