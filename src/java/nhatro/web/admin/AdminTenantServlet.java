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

public class AdminTenantServlet extends HttpServlet {
    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Map<String, Object>> tenants = dashboardDAO.listTenants(getServletContext());
            req.setAttribute("tenants", tenants);
            req.getRequestDispatcher("/webapp/views/admin/tenant-management.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load tenant management", e);
        }
    }
}

