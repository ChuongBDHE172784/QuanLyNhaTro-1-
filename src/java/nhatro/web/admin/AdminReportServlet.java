package nhatro.web.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.ReportDAO;
import nhatro.model.Report;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminReportServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Report> reports = reportDAO.listAll(getServletContext());
            req.setAttribute("reports", reports);
            req.getRequestDispatcher("/webapp/views/admin/reports.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load reports", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String reportIdStr = req.getParameter("reportId");
        String status = req.getParameter("status");
        if (reportIdStr == null || status == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/reports");
            return;
        }
        status = status.trim().toUpperCase();
        if (!("OPEN".equals(status) || "IN_PROGRESS".equals(status) || "RESOLVED".equals(status))) {
            resp.sendRedirect(req.getContextPath() + "/admin/reports");
            return;
        }
        try {
            int reportId = Integer.parseInt(reportIdStr);
            if (reportId > 0) {
                reportDAO.updateStatus(getServletContext(), reportId, status);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/reports");
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Cannot update report", e);
        }
    }
}
