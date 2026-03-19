package nhatro.dao;

import nhatro.model.Room;
import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static nhatro.util.DBContext.getConnection;

public class RoomDAO {

    public List<Room> list(ServletContext ctx, String q) throws SQLException {
        boolean hasQ = q != null && !q.trim().isEmpty();
        String sql = """
                     SELECT id, code, area, price_month, status, description
                     FROM dbo.Room
                     %s
                     ORDER BY id DESC
                     """.formatted(hasQ ? "WHERE code LIKE ? OR area LIKE ?" : "");

        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasQ) {
                String like = "%" + q.trim() + "%";
                ps.setString(1, like);
                ps.setString(2, like);
            }
            try (ResultSet rs = ps.executeQuery()) {
                List<Room> rooms = new ArrayList<>();
                while (rs.next()) {
                    rooms.add(new Room(
                            rs.getInt("id"),
                            rs.getString("code"),
                            rs.getString("area"),
                            rs.getInt("price_month"),
                            rs.getString("status"),
                            rs.getString("description")
                    ));
                }
                return rooms;
            }
        }
    }

    public Room findById(ServletContext ctx, int id) throws SQLException {
        String sql = "SELECT id, code, area, price_month, status, description FROM dbo.Room WHERE id = ?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return new Room(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("area"),
                        rs.getInt("price_month"),
                        rs.getString("status"),
                        rs.getString("description")
                );
            }
        }
    }

    public void create(ServletContext ctx, Room r) throws SQLException {
        String sql = "INSERT INTO dbo.Room(code, area, price_month, status, description) VALUES (?,?,?,?,?)";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCode());
            ps.setString(2, r.getArea());
            ps.setInt(3, r.getPriceMonth());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getDescription());
            ps.executeUpdate();
        }
    }

    public void update(ServletContext ctx, Room r) throws SQLException {
        String sql = "UPDATE dbo.Room SET code=?, area=?, price_month=?, status=?, description=? WHERE id=?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCode());
            ps.setString(2, r.getArea());
            ps.setInt(3, r.getPriceMonth());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getDescription());
            ps.setInt(6, r.getId());
            ps.executeUpdate();
        }
    }

    public void delete(ServletContext ctx, int id) throws SQLException {
        String sql = "DELETE FROM dbo.Room WHERE id=?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}

