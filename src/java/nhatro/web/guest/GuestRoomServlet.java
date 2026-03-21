package nhatro.web.guest;

import nhatro.dao.RoomDAO;
import nhatro.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class GuestRoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); // null, /, /detail
        if (pathInfo == null || "/".equals(pathInfo)) {
            handleList(req, resp);
            return;
        }
        if (pathInfo.startsWith("/detail")) {
            handleDetail(req, resp);
            return;
        }
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        Integer minPrice = parseOptionalInt(req.getParameter("minPrice"));
        Integer maxPrice = parseOptionalInt(req.getParameter("maxPrice"));
        String roomTypeRaw = req.getParameter("roomType");
        String roomType = normalizeRoomType(roomTypeRaw);
        if (roomType == null && roomTypeRaw != null && !roomTypeRaw.trim().isEmpty()) {
            // Fallback: vẫn áp dụng filter cho mọi giá trị khác rỗng.
            roomType = roomTypeRaw.trim().toUpperCase();
        }
        String utility = req.getParameter("utility");
        try {
            List<Room> rooms = roomDAO.listFiltered(getServletContext(), q, minPrice, maxPrice, roomType, utility);
            req.setAttribute("rooms", rooms);
            req.setAttribute("q", q);
            req.setAttribute("minPrice", minPrice);
            req.setAttribute("maxPrice", maxPrice);
            req.setAttribute("roomType", roomType);
            req.setAttribute("utility", utility);
            req.getRequestDispatcher("/webapp/views/guest/rooms.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }
    }

    private void handleDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/rooms");
            return;
        }

        try {
            Room room = roomDAO.findById(getServletContext(), id);
            if (room == null) {
                resp.sendRedirect(req.getContextPath() + "/rooms");
                return;
            }
            req.setAttribute("room", room);
            req.getRequestDispatcher("/webapp/views/guest/room-details.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }
    }

    private Integer parseOptionalInt(String s) {
        if (s == null || s.isBlank()) {
            return null;
        }
        try {
            return Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private String normalizeRoomType(String raw) {
        if (raw == null) return null;
        String v = raw.trim();
        if (v.isEmpty()) return null;
        String upper = v.toUpperCase();
        if ("SINGLE".equals(upper) || "PHONG DON".equals(upper) || "PHÒNG ĐƠN".equals(upper)) {
            return "SINGLE";
        }
        if ("STUDIO".equals(upper) || "CHUNG CU MINI".equals(upper) || "CHUNG CƯ MINI".equals(upper)) {
            return "STUDIO";
        }
        return null;
    }
}

