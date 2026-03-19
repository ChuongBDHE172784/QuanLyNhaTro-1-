package nhatro.web.auth;

import nhatro.dao.UserDAO;
import nhatro.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("pageTitle", "Đăng nhập");
        req.getRequestDispatcher("/webapp/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        email = trimToNull(email);
        password = trimToNull(password);

        if (email == null || password == null) {
            req.setAttribute("error", "Vui lòng nhập email và mật khẩu.");
            doGet(req, resp);
            return;
        }

        if (email.length() > 255) {
            req.setAttribute("error", "Email không hợp lệ.");
            doGet(req, resp);
            return;
        }
        if (!email.contains("@")) {
            req.setAttribute("error", "Email không hợp lệ.");
            doGet(req, resp);
            return;
        }
        if (password.length() < 3) {
            req.setAttribute("error", "Mật khẩu không hợp lệ.");
            doGet(req, resp);
            return;
        }

        try {
            User u = userDAO.findByEmailAndPassword(getServletContext(), email.trim(), password);
            if (u == null) {
                req.setAttribute("error", "Sai email hoặc mật khẩu.");
                doGet(req, resp);
                return;
            }
            HttpSession session = req.getSession(true);
            session.setAttribute("user", u);

            // Redirect by role (demo)
            if ("ADMIN".equalsIgnoreCase(u.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/webapp/views/admin/dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/webapp/views/student/dashboard.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("DB error during login", e);
        }
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
}

