package nhatro.web.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.DashboardDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AdminBillingServlet extends HttpServlet {
    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Map<String, Object>> billingRows = dashboardDAO.listBillingRows(getServletContext());
            req.setAttribute("billingRows", billingRows);
            req.getRequestDispatcher("/webapp/views/admin/billing.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load billing", e);
        }
    }
}

