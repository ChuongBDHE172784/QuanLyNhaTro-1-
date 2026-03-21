package nhatro.web.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.RoomRequestDAO;
import nhatro.model.RoomRequest;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminRequestsServlet extends HttpServlet {

    private final RoomRequestDAO roomRequestDAO = new RoomRequestDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<RoomRequest> requests = roomRequestDAO.listForAdmin(getServletContext());
            req.setAttribute("requests", requests);
            req.getRequestDispatcher("/webapp/views/admin/request-approval.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load pending requests", e);
        }
    }
}

