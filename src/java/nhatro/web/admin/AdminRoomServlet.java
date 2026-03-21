package nhatro.web.admin;

import nhatro.dao.RoomDAO;
import nhatro.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminRoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();
    private static final String[] VALID_STATUSES = {"AVAILABLE", "RENTED", "MAINTENANCE"};

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
        } catch (SQLException | IllegalArgumentException e) {
            // Tránh 500 khi user nhập sai dữ liệu; quay lại list để demo mượt.
            resp.sendRedirect(req.getContextPath() + "/admin/rooms?status=error");
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
        resp.sendRedirect(req.getContextPath() + "/admin/rooms?status=created");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int id = parsePositiveInt(req.getParameter("id"), "id");
        Room r = readRoomFromRequest(req, id);
        roomDAO.update(getServletContext(), r);
        resp.sendRedirect(req.getContextPath() + "/admin/rooms?status=updated");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int id = parsePositiveInt(req.getParameter("id"), "id");
        roomDAO.delete(getServletContext(), id);
        resp.sendRedirect(req.getContextPath() + "/admin/rooms?status=deleted");
    }

    private Room readRoomFromRequest(HttpServletRequest req, int id) {
        String code = trimToNull(req.getParameter("code"));
        String area = trimToNull(req.getParameter("area"));
        String priceStr = trimToNull(req.getParameter("priceMonth"));
        String status = trimToNull(req.getParameter("status"));
        String description = trimToNull(req.getParameter("description"));

        if (code == null || code.length() > 50) {
            throw new IllegalArgumentException("Invalid code");
        }
        if (!code.matches("[A-Za-z0-9_-]{2,50}")) {
            throw new IllegalArgumentException("Invalid code format");
        }
        if (area == null) {
            throw new IllegalArgumentException("Invalid area");
        }
        if (area.length() > 255) {
            throw new IllegalArgumentException("Area too long");
        }
        int priceMonth = parseNonNegativeInt(priceStr, "priceMonth");
        if (status == null || !isValidStatus(status)) {
            throw new IllegalArgumentException("Invalid status");
        }
        if (description != null && description.length() > 1000) {
            throw new IllegalArgumentException("Description too long");
        }

        Room r = new Room();
        r.setId(id);
        r.setCode(code);
        r.setArea(area);
        r.setPriceMonth(priceMonth);
        r.setStatus(status);
        r.setDescription(description);
        return r;
    }

    private static boolean isValidStatus(String status) {
        for (String s : VALID_STATUSES) {
            if (s.equals(status)) return true;
        }
        return false;
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private static int parsePositiveInt(String s, String fieldName) {
        int v = parseInt(s, fieldName);
        if (v <= 0) throw new IllegalArgumentException("Invalid " + fieldName);
        return v;
    }

    private static int parseNonNegativeInt(String s, String fieldName) {
        int v = parseInt(s, fieldName);
        if (v < 0) throw new IllegalArgumentException("Invalid " + fieldName);
        return v;
    }

    private static int parseInt(String s, String fieldName) {
        if (s == null) throw new IllegalArgumentException("Missing " + fieldName);
        return Integer.parseInt(s);
    }
}

