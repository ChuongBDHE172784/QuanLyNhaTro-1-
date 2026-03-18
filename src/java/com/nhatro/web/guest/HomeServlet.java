package com.nhatro.web.guest;

import com.nhatro.dao.RoomDAO;
import com.nhatro.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class HomeServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Room> rooms = roomDAO.list(getServletContext(), null);

            int availableCount = 0;
            Integer minPrice = null;
            Set<String> areas = new HashSet<>();
            for (Room r : rooms) {
                if (r.getArea() != null && !r.getArea().isBlank()) {
                    areas.add(r.getArea().trim());
                }
                if ("AVAILABLE".equalsIgnoreCase(r.getStatus())) {
                    availableCount++;
                    if (minPrice == null || r.getPriceMonth() < minPrice) {
                        minPrice = r.getPriceMonth();
                    }
                }
            }

            List<Room> featured = rooms.size() <= 3 ? rooms : rooms.subList(0, 3);
            req.setAttribute("featuredRooms", featured);
            req.setAttribute("availableCount", availableCount);
            req.setAttribute("minPrice", minPrice);
            req.setAttribute("areaCount", areas.size());

            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }
    }
}

