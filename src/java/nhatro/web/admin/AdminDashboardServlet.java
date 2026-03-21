package nhatro.web.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.DashboardDAO;
import nhatro.model.RoomRequest;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setAttribute("roomCount", dashboardDAO.countRooms(getServletContext()));
            req.setAttribute("rentedCount", dashboardDAO.countRentedRooms(getServletContext()));
            req.setAttribute("pendingRequestCount", dashboardDAO.countPendingRequests(getServletContext()));
            req.setAttribute("unresolvedReportCount", dashboardDAO.countUnresolvedReports(getServletContext()));
            List<RoomRequest> recentRequests = dashboardDAO.listRecentRequests(getServletContext(), 5);
            req.setAttribute("recentRequests", recentRequests);
            req.getRequestDispatcher("/webapp/views/admin/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load admin dashboard", e);
        }
    }
}

