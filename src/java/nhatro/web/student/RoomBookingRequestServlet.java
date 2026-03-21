package nhatro.web.student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import nhatro.dao.RoomRequestDAO;
import nhatro.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class RoomBookingRequestServlet extends HttpServlet {

    private final RoomRequestDAO roomRequestDAO = new RoomRequestDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        req.getRequestDispatcher("/webapp/views/student/room-booking.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }
        User u = (User) session.getAttribute("user");

        try {
            String roomIdStr = req.getParameter("roomId");
            String moveInDateStr = req.getParameter("moveInDate");
            String durationStr = req.getParameter("duration");
            String peopleCountStr = req.getParameter("peopleCount");
            String note = req.getParameter("note");

            if (roomIdStr == null || moveInDateStr == null || durationStr == null || peopleCountStr == null) {
                resp.sendRedirect(req.getContextPath() + "/rooms");
                return;
            }

            int roomId = parsePositiveInt(roomIdStr, "roomId");
            LocalDate moveInDate = parseDate(moveInDateStr);
            if (moveInDate.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException("moveInDate must be today or later");
            }
            int durationMonths = parsePositiveInt(durationStr, "duration");
            int peopleCount = parsePositiveInt(peopleCountStr, "peopleCount");
            if (durationMonths > 120) {
                throw new IllegalArgumentException("duration too large");
            }
            if (peopleCount > 20) {
                throw new IllegalArgumentException("peopleCount too large");
            }

            String noteValue = trimToNull(note);

            roomRequestDAO.create(
                    getServletContext(),
                    u.getId(),
                    roomId,
                    moveInDate,
                    durationMonths,
                    peopleCount,
                    noteValue
            );

            // Sau khi submit request, chuyển về trang tổng quan student.
            resp.sendRedirect(req.getContextPath() + "/student/dashboard");
        } catch (DateTimeParseException | SQLException | IllegalArgumentException e) {
            // Dữ liệu không hợp lệ => quay về trang phòng để demo mượt.
            resp.sendRedirect(req.getContextPath() + "/rooms");
        }
    }

    private static int parsePositiveInt(String s, String fieldName) {
        int v = Integer.parseInt(s);
        if (v <= 0) throw new IllegalArgumentException("Invalid " + fieldName);
        return v;
    }

    private static LocalDate parseDate(String s) {
        // input type="date" => format yyyy-MM-dd
        return LocalDate.parse(s);
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
}

