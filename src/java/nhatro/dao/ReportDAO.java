package nhatro.dao;

import jakarta.servlet.ServletContext;
import nhatro.model.Report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import static nhatro.util.DBContext.getConnection;

public class ReportDAO {

    public void create(ServletContext ctx, int userId, String title, String description, String priority) throws SQLException {
        String sql = "INSERT INTO dbo.Reports(user_id, title, description, priority) VALUES (?,?,?,?)";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setString(4, priority);
            ps.executeUpdate();
        }
    }

    public List<Report> listByUser(ServletContext ctx, int userId) throws SQLException {
        String sql = """
                SELECT id, user_id, title, description, priority, status, created_at
                FROM dbo.Reports
                WHERE user_id = ?
                ORDER BY created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Report> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(map(rs));
                }
                return list;
            }
        }
    }

    public List<Report> listAll(ServletContext ctx) throws SQLException {
        String sql = """
                SELECT r.id, r.user_id, u.full_name AS student_name, r.title, r.description, r.priority, r.status, r.created_at
                FROM dbo.Reports r
                INNER JOIN dbo.[User] u ON u.id = r.user_id
                ORDER BY r.created_at DESC
                """;
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                List<Report> list = new ArrayList<>();
                while (rs.next()) {
                    Report report = map(rs);
                    report.setStudentName(rs.getString("student_name"));
                    list.add(report);
                }
                return list;
            }
        }
    }

    public void updateStatus(ServletContext ctx, int reportId, String status) throws SQLException {
        String sql = "UPDATE dbo.Reports SET status = ? WHERE id = ?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, reportId);
            ps.executeUpdate();
        }
    }

    private Report map(ResultSet rs) throws SQLException {
        Report report = new Report();
        report.setId(rs.getInt("id"));
        report.setUserId(rs.getInt("user_id"));
        report.setTitle(rs.getString("title"));
        report.setDescription(rs.getString("description"));
        report.setPriority(rs.getString("priority"));
        report.setStatus(rs.getString("status"));
        Timestamp ts = rs.getTimestamp("created_at");
        report.setCreatedAt(ts == null ? null : ts.toLocalDateTime());
        return report;
    }
}
