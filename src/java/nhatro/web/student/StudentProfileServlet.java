package nhatro.web.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import nhatro.dao.UserDAO;
import nhatro.model.User;

import java.io.IOException;
import java.sql.SQLException;

public class StudentProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getSessionUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        try {
            User profile = userDAO.findById(getServletContext(), user.getId());
            req.setAttribute("profile", profile);
            req.getRequestDispatcher("/webapp/views/student/profile.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Cannot load profile", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = getSessionUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        String phone = trimToNull(req.getParameter("phone"));
        String cccd = trimToNull(req.getParameter("cccd"));
        String avatarUrl = trimToNull(req.getParameter("avatarUrl"));
        if (phone != null && !phone.matches("\\d{9,11}")) {
            resp.sendRedirect(req.getContextPath() + "/student/profile?error=phone");
            return;
        }
        if (cccd != null && !cccd.matches("\\d{9,12}")) {
            resp.sendRedirect(req.getContextPath() + "/student/profile?error=cccd");
            return;
        }
        if (avatarUrl != null && avatarUrl.length() > 500) {
            resp.sendRedirect(req.getContextPath() + "/student/profile?error=avatar");
            return;
        }
        try {
            userDAO.updateStudentProfile(getServletContext(), user.getId(), phone, cccd, avatarUrl);
            resp.sendRedirect(req.getContextPath() + "/student/profile?updated=1");
        } catch (SQLException e) {
            throw new ServletException("Cannot update profile", e);
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
