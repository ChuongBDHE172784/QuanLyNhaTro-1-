package nhatro.web.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhatro.dao.UserDAO;

import java.io.IOException;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("pageTitle", "Đăng ký");
        req.getRequestDispatcher("/webapp/views/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = trimToNull(req.getParameter("fullName"));
        String phone = trimToNull(req.getParameter("phone"));
        String email = trimToNull(req.getParameter("email"));
        String password = trimToNull(req.getParameter("password"));
        String confirm = trimToNull(req.getParameter("confirm"));

        req.setAttribute("fullName", fullName);
        req.setAttribute("phone", phone);
        req.setAttribute("email", email);

        if (fullName == null || email == null || password == null || confirm == null || phone == null) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            doGet(req, resp);
            return;
        }
        if (fullName.length() > 255) {
            req.setAttribute("error", "Họ tên quá dài.");
            doGet(req, resp);
            return;
        }
        if (!phone.matches("\\d{9,11}")) {
            req.setAttribute("error", "Số điện thoại không hợp lệ.");
            doGet(req, resp);
            return;
        }
        if (!email.contains("@") || email.length() > 255) {
            req.setAttribute("error", "Email không hợp lệ.");
            doGet(req, resp);
            return;
        }
        if (password.length() < 6 || password.length() > 255) {
            req.setAttribute("error", "Mật khẩu phải từ 6-255 ký tự.");
            doGet(req, resp);
            return;
        }
        if (!password.equals(confirm)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp.");
            doGet(req, resp);
            return;
        }

        try {
            boolean emailExists = userDAO.existsByEmail(getServletContext(), email);
            boolean phoneExists = userDAO.existsByPhone(getServletContext(), phone);

            if (emailExists && phoneExists) {
                req.setAttribute("error", "Email và số điện thoại này đã tồn tại trong hệ thống.");
                doGet(req, resp);
                return;
            }
            if (emailExists) {
                req.setAttribute("error", "Email này đã tồn tại trong hệ thống.");
                doGet(req, resp);
                return;
            }
            if (phoneExists) {
                req.setAttribute("error", "Số điện thoại này đã tồn tại trong hệ thống.");
                doGet(req, resp);
                return;
            }
            userDAO.createStudent(getServletContext(), email, password, fullName, phone);
            resp.sendRedirect(req.getContextPath() + "/auth/login?registered=1");
        } catch (SQLException e) {
            throw new ServletException("Cannot register account", e);
        }
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
}

