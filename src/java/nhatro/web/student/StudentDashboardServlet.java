package nhatro.web.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import nhatro.dao.DashboardDAO;
import nhatro.model.RoomRequest;
import nhatro.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class StudentDashboardServlet extends HttpServlet {
    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        try {
            Map<String, Object> activeContract = dashboardDAO.findActiveContractForStudent(getServletContext(), user.getId());
            int openSupportCount = dashboardDAO.countStudentUnresolvedReports(getServletContext(), user.getId());
            List<Map<String, Object>> contracts = dashboardDAO.listContractsForStudent(getServletContext(), user.getId());

            req.setAttribute("activeContract", activeContract);
            req.setAttribute("openSupportCount", openSupportCount);
            req.setAttribute("contracts", contracts);
            req.getRequestDispatcher("/webapp/views/student/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load student dashboard", e);
        }
    }
}

