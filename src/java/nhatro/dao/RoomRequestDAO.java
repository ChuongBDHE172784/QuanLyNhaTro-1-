package nhatro.dao;

import jakarta.servlet.ServletContext;
import nhatro.model.RoomRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import static nhatro.util.DBContext.getConnection;

public class RoomRequestDAO {

    public List<RoomRequest> listForAdmin(ServletContext ctx) throws SQLException {
        String sql = """
                SELECT rr.id,
                       rr.room_id,
                       rm.code AS room_code,
                       rr.user_id,
                       u.full_name AS student_name,
                       rr.move_in_date,
                       rr.duration_months,
                       rr.people_count,
                       rr.note,
                       rr.status
                FROM dbo.RoomRequests rr
                INNER JOIN dbo.Room rm ON rm.id = rr.room_id
                INNER JOIN dbo.[User] u ON u.id = rr.user_id
                ORDER BY rr.created_at DESC
                """;

        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                List<RoomRequest> list = new ArrayList<>();
                while (rs.next()) {
                    RoomRequest r = new RoomRequest();
                    r.setId(rs.getInt("id"));
                    r.setRoomId(rs.getInt("room_id"));
                    r.setRoomCode(rs.getString("room_code"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setStudentName(rs.getString("student_name"));

                    java.sql.Date start = rs.getDate("move_in_date");
                    r.setMoveInDate(start == null ? null : start.toLocalDate());
                    r.setStartDate(r.getMoveInDate());

                    r.setDurationMonths(rs.getInt("duration_months"));
                    r.setPeopleCount(rs.getInt("people_count"));
                    r.setNote(rs.getString("note"));
                    r.setStatus(rs.getString("status"));
                    list.add(r);
                }
                return list;
            }
        }
    }

    public void create(ServletContext ctx, int userId, int roomId, LocalDate moveInDate, int durationMonths, int peopleCount, String note) throws SQLException {
        if (userId <= 0 || roomId <= 0) {
            throw new IllegalArgumentException("Invalid userId/roomId");
        }
        if (moveInDate == null) {
            throw new IllegalArgumentException("Missing moveInDate");
        }
        if (moveInDate.isBefore(LocalDate.now())) {
            throw new IllegalArgumentException("moveInDate must be today or later");
        }
        if (durationMonths <= 0) {
            throw new IllegalArgumentException("Invalid durationMonths");
        }
        if (peopleCount <= 0 || peopleCount > 20) {
            throw new IllegalArgumentException("Invalid peopleCount");
        }

        // Kiểm tra phòng còn trống để request không bị "treo" vô lý.
        String roomCheckSql = "SELECT status FROM dbo.Room WHERE id = ?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(roomCheckSql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    throw new SQLException("Room not found");
                }
                String status = rs.getString("status");
                if (!"AVAILABLE".equalsIgnoreCase(status)) {
                    throw new SQLException("Room is not available");
                }
            }
        }

        String noteValue = note;
        if (noteValue != null) {
            noteValue = noteValue.trim();
            if (noteValue.isEmpty()) noteValue = null;
        }
        if (noteValue != null && noteValue.length() > 1000) {
            throw new IllegalArgumentException("Note too long");
        }

        String sql = """
                INSERT INTO dbo.RoomRequests(user_id, room_id, move_in_date, duration_months, people_count, note)
                VALUES (?,?,?,?,?,?)
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, roomId);
            ps.setDate(3, java.sql.Date.valueOf(moveInDate));
            ps.setInt(4, durationMonths);
            ps.setInt(5, peopleCount);
            ps.setString(6, note);
            ps.executeUpdate();
        }
    }

    public void approveAndCreateContract(ServletContext ctx, int requestId) throws SQLException {
        if (requestId <= 0) {
            throw new IllegalArgumentException("Invalid requestId");
        }

        String fetchSql = """
                SELECT user_id, room_id, move_in_date, duration_months
                FROM dbo.RoomRequests
                WHERE id = ? AND status = 'PENDING'
                """;

        String updateRoomSql = "UPDATE dbo.Room SET status = 'RENTED' WHERE id = ? AND status = 'AVAILABLE'";
        String insertContractSql = """
                INSERT INTO dbo.Contracts(user_id, room_id, start_date, end_date, status)
                VALUES (?,?,?, ?, 'ACTIVE')
                """;
        String approveRequestSql = "UPDATE dbo.RoomRequests SET status = 'APPROVED' WHERE id = ? AND status = 'PENDING'";

        try (Connection con = getConnection(ctx)) {
            con.setAutoCommit(false);
            try {
                int userId;
                int roomId;
                LocalDate startDate;
                int durationMonths;

                try (PreparedStatement ps = con.prepareStatement(fetchSql)) {
                    ps.setInt(1, requestId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            con.rollback();
                            return;
                        }
                        userId = rs.getInt("user_id");
                        roomId = rs.getInt("room_id");
                        java.sql.Date start = rs.getDate("move_in_date");
                        startDate = start == null ? LocalDate.now() : start.toLocalDate();
                        durationMonths = rs.getInt("duration_months");
                    }
                }

                // 1) Chuyển phòng từ Trống -> Đã thuê
                int updatedRooms;
                try (PreparedStatement ps = con.prepareStatement(updateRoomSql)) {
                    ps.setInt(1, roomId);
                    updatedRooms = ps.executeUpdate();
                }
                if (updatedRooms == 0) {
                    con.rollback();
                    throw new SQLException("Room is not available for approval.");
                }

                // 2) Lưu hợp đồng vào Contracts
                LocalDate endDate = startDate.plusMonths(durationMonths);
                try (PreparedStatement ps = con.prepareStatement(insertContractSql)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, roomId);
                    ps.setDate(3, java.sql.Date.valueOf(startDate));
                    ps.setDate(4, java.sql.Date.valueOf(endDate));
                    ps.executeUpdate();
                }

                // 3) Cập nhật request trạng thái
                try (PreparedStatement ps = con.prepareStatement(approveRequestSql)) {
                    ps.setInt(1, requestId);
                    ps.executeUpdate();
                }

                con.commit();
            } catch (SQLException e) {
                try {
                    con.rollback();
                } catch (SQLException ignored) {
                }
                throw e;
            } finally {
                try {
                    con.setAutoCommit(true);
                } catch (SQLException ignored) {
                }
            }
        }
    }

    public void reject(ServletContext ctx, int requestId) throws SQLException {
        if (requestId <= 0) {
            throw new IllegalArgumentException("Invalid requestId");
        }
        String sql = "UPDATE dbo.RoomRequests SET status = 'REJECTED' WHERE id = ? AND status = 'PENDING'";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ps.executeUpdate();
        }
    }

    public void markCheckedIn(ServletContext ctx, int requestId) throws SQLException {
        if (requestId <= 0) {
            throw new IllegalArgumentException("Invalid requestId");
        }
        String sql = "UPDATE dbo.RoomRequests SET status = 'CHECKED_IN' WHERE id = ? AND status = 'APPROVED'";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ps.executeUpdate();
        }
    }
}

