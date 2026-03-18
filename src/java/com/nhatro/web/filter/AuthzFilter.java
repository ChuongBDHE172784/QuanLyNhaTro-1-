package com.nhatro.web.filter;

import com.nhatro.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthzFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());
        HttpSession session = req.getSession(false);
        User u = session == null ? null : (User) session.getAttribute("user");

        boolean isAdminPath = path.startsWith("/admin/");
        boolean isStudentPath = path.startsWith("/student/");

        if ((isAdminPath || isStudentPath) && u == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        if (isAdminPath && u != null && !"ADMIN".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        if (isStudentPath && u != null && !"STUDENT".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}

