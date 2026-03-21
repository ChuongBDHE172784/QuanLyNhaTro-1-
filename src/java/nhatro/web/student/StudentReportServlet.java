package nhatro.web.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import nhatro.dao.ReportDAO;
import nhatro.model.Report;
import nhatro.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class StudentReportServlet extends HttpServlet {

    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getSessionUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        try {
            List<Report> reports = reportDAO.listByUser(getServletContext(), user.getId());
            req.setAttribute("reports", reports);
            req.getRequestDispatcher("/webapp/views/student/support.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load reports", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = getSessionUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        String title = trimToNull(req.getParameter("title"));
        String desc = trimToNull(req.getParameter("desc"));
        String priority = trimToNull(req.getParameter("priority"));
        if (title == null || desc == null || priority == null) {
            resp.sendRedirect(req.getContextPath() + "/student/reports");
            return;
        }
        priority = priority.toUpperCase();
        if (!("LOW".equals(priority) || "MEDIUM".equals(priority) || "HIGH".equals(priority))) {
            priority = "MEDIUM";
        }
        try {
            reportDAO.create(getServletContext(), user.getId(), title, desc, priority);
            resp.sendRedirect(req.getContextPath() + "/student/reports?created=1");
        } catch (SQLException e) {
            throw new ServletException("Cannot create report", e);
        }
    }

    private User getSessionUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        Object u = session.getAttribute("user");
        return (u instanceof User) ? (User) u : null;
    }

    private String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
}
