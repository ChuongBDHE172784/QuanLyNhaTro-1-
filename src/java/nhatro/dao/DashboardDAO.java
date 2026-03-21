package nhatro.dao;

import jakarta.servlet.ServletContext;
import nhatro.model.RoomRequest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static nhatro.util.DBContext.getConnection;

public class DashboardDAO {

    public int countRooms(ServletContext ctx) throws SQLException {
        return countBySql(ctx, "SELECT COUNT(*) FROM dbo.Room");
    }

    public int countRentedRooms(ServletContext ctx) throws SQLException {
        return countBySql(ctx, "SELECT COUNT(*) FROM dbo.Room WHERE status = 'RENTED'");
    }

    public int countPendingRequests(ServletContext ctx) throws SQLException {
        return countBySql(ctx, "SELECT COUNT(*) FROM dbo.RoomRequests WHERE status = 'PENDING'");
    }

    public int countUnresolvedReports(ServletContext ctx) throws SQLException {
        return countBySql(ctx, "SELECT COUNT(*) FROM dbo.Reports WHERE status IN ('OPEN','IN_PROGRESS')");
    }

    public int countStudentUnresolvedReports(ServletContext ctx, int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM dbo.Reports WHERE user_id = ? AND status IN ('OPEN','IN_PROGRESS')";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public Map<String, Object> findActiveContractForStudent(ServletContext ctx, int userId) throws SQLException {
        String sql = """
                SELECT TOP 1 c.id AS contract_id, c.start_date, c.end_date, c.status AS contract_status,
                             r.code AS room_code, r.area, r.price_month
                FROM dbo.Contracts c
                INNER JOIN dbo.Room r ON r.id = c.room_id
                WHERE c.user_id = ? AND c.status = 'ACTIVE'
                ORDER BY c.created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                Map<String, Object> row = new HashMap<>();
                row.put("contractId", rs.getInt("contract_id"));
                row.put("startDate", rs.getDate("start_date"));
                row.put("endDate", rs.getDate("end_date"));
                row.put("contractStatus", rs.getString("contract_status"));
                row.put("roomCode", rs.getString("room_code"));
                row.put("area", rs.getString("area"));
                row.put("priceMonth", rs.getInt("price_month"));
                return row;
            }
        }
    }

    public List<Map<String, Object>> listContractsForStudent(ServletContext ctx, int userId) throws SQLException {
        String sql = """
                SELECT c.id AS contract_id, c.start_date, c.end_date, c.status AS contract_status,
                       r.code AS room_code, r.price_month
                FROM dbo.Contracts c
                INNER JOIN dbo.Room r ON r.id = c.room_id
                WHERE c.user_id = ?
                ORDER BY c.created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Map<String, Object>> out = new ArrayList<>();
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("contractId", rs.getInt("contract_id"));
                    row.put("startDate", rs.getDate("start_date"));
                    row.put("endDate", rs.getDate("end_date"));
                    row.put("status", rs.getString("contract_status"));
                    row.put("roomCode", rs.getString("room_code"));
                    row.put("priceMonth", rs.getInt("price_month"));
                    out.add(row);
                }
                return out;
            }
        }
    }

    public List<Map<String, Object>> listTenants(ServletContext ctx) throws SQLException {
        String sql = """
                SELECT c.id AS contract_id, c.start_date, c.end_date, c.status AS contract_status,
                       u.full_name, u.email, u.phone, r.code AS room_code
                FROM dbo.Contracts c
                INNER JOIN dbo.[User] u ON u.id = c.user_id
                INNER JOIN dbo.Room r ON r.id = c.room_id
                WHERE u.role = 'STUDENT'
                ORDER BY c.created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                List<Map<String, Object>> out = new ArrayList<>();
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("contractId", rs.getInt("contract_id"));
                    row.put("startDate", rs.getDate("start_date"));
                    row.put("endDate", rs.getDate("end_date"));
                    row.put("status", rs.getString("contract_status"));
                    row.put("fullName", rs.getString("full_name"));
                    row.put("email", rs.getString("email"));
                    row.put("phone", rs.getString("phone"));
                    row.put("roomCode", rs.getString("room_code"));
                    out.add(row);
                }
                return out;
            }
        }
    }

    public List<Map<String, Object>> listBillingRows(ServletContext ctx) throws SQLException {
        String sql = """
                SELECT c.id AS contract_id, c.status AS contract_status,
                       u.full_name, r.code AS room_code, r.price_month
                FROM dbo.Contracts c
                INNER JOIN dbo.[User] u ON u.id = c.user_id
                INNER JOIN dbo.Room r ON r.id = c.room_id
                ORDER BY c.created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                List<Map<String, Object>> out = new ArrayList<>();
                while (rs.next()) {
                    int rent = rs.getInt("price_month");
                    int utility = 0;
                    Map<String, Object> row = new HashMap<>();
                    row.put("contractId", rs.getInt("contract_id"));
                    row.put("roomCode", rs.getString("room_code"));
                    row.put("studentName", rs.getString("full_name"));
                    row.put("roomRent", rent);
                    row.put("utilityAmount", utility);
                    row.put("totalAmount", rent + utility);
                    row.put("status", "ACTIVE".equalsIgnoreCase(rs.getString("contract_status")) ? "UNPAID" : "PAID");
                    out.add(row);
                }
                return out;
            }
        }
    }

    public List<RoomRequest> listRecentRequests(ServletContext ctx, int limit) throws SQLException {
        String sql = """
                SELECT TOP (?) rr.id, rr.room_id, r.code AS room_code, rr.user_id, u.full_name AS student_name,
                       rr.move_in_date, rr.duration_months, rr.people_count, rr.note, rr.status
                FROM dbo.RoomRequests rr
                INNER JOIN dbo.Room r ON r.id = rr.room_id
                INNER JOIN dbo.[User] u ON u.id = rr.user_id
                ORDER BY rr.created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                List<RoomRequest> out = new ArrayList<>();
                while (rs.next()) {
                    RoomRequest rr = new RoomRequest();
                    rr.setId(rs.getInt("id"));
                    rr.setRoomId(rs.getInt("room_id"));
                    rr.setRoomCode(rs.getString("room_code"));
                    rr.setUserId(rs.getInt("user_id"));
                    rr.setStudentName(rs.getString("student_name"));
                    Date d = rs.getDate("move_in_date");
                    rr.setMoveInDate(d == null ? null : d.toLocalDate());
                    rr.setDurationMonths(rs.getInt("duration_months"));
                    rr.setPeopleCount(rs.getInt("people_count"));
                    rr.setNote(rs.getString("note"));
                    rr.setStatus(rs.getString("status"));
                    out.add(rr);
                }
                return out;
            }
        }
    }

    private int countBySql(ServletContext ctx, String sql) throws SQLException {
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }
}

