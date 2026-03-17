package com.nhatro.web.admin;

import com.nhatro.dao.RoomDAO;
import com.nhatro.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminRoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); // null or /edit
        if (pathInfo == null || "/".equals(pathInfo)) {
            handleList(req, resp);
            return;
        }

        if (pathInfo.startsWith("/edit")) {
            handleEditForm(req, resp);
            return;
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); // /create, /update, /delete
        if (pathInfo == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            switch (pathInfo) {
                case "/create" -> handleCreate(req, resp);
                case "/update" -> handleUpdate(req, resp);
                case "/delete" -> handleDelete(req, resp);
                default -> resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        try {
            List<Room> rooms = roomDAO.list(getServletContext(), q);
            req.setAttribute("rooms", rooms);
            req.setAttribute("q", q);
            req.getRequestDispatcher("/webapp/views/admin/room-management.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }
    }

    private void handleEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/admin/rooms");
            return;
        }
        try {
            Room room = roomDAO.findById(getServletContext(), Integer.parseInt(idStr));
            if (room == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/rooms");
                return;
            }
            req.setAttribute("room", room);
            req.setAttribute("rooms", roomDAO.list(getServletContext(), req.getParameter("q")));
            req.getRequestDispatcher("/webapp/views/admin/room-management.jsp").forward(req, resp);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Cannot load room", e);
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        Room r = readRoomFromRequest(req, 0);
        roomDAO.create(getServletContext(), r);
        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Room r = readRoomFromRequest(req, id);
        roomDAO.update(getServletContext(), r);
        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        roomDAO.delete(getServletContext(), id);
        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }

    private Room readRoomFromRequest(HttpServletRequest req, int id) {
        String code = req.getParameter("code");
        String area = req.getParameter("area");
        String priceStr = req.getParameter("priceMonth");
        String status = req.getParameter("status");
        String description = req.getParameter("description");

        Room r = new Room();
        r.setId(id);
        r.setCode(code == null ? "" : code.trim());
        r.setArea(area == null ? "" : area.trim());
        r.setPriceMonth(priceStr == null || priceStr.isBlank() ? 0 : Integer.parseInt(priceStr));
        r.setStatus(status == null || status.isBlank() ? "AVAILABLE" : status);
        r.setDescription(description == null ? null : description.trim());
        return r;
    }
}

