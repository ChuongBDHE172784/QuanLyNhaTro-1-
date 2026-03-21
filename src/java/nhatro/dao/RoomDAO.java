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
        return listFiltered(ctx, q, null, null, null, null);
    }

    public List<Room> listFiltered(ServletContext ctx, String q, Integer minPrice, Integer maxPrice, String roomType, String utilityKeyword) throws SQLException {
        StringBuilder sql = new StringBuilder("""
                SELECT r.id, r.code, r.area, r.price_month, r.status, r.description, r.room_type,
                       STRING_AGG(u.name, ', ') AS utilities_summary
                FROM dbo.Room r
                LEFT JOIN dbo.RoomUtilities ru ON ru.room_id = r.id
                LEFT JOIN dbo.Utilities u ON u.id = ru.utility_id
                WHERE 1=1
                """);

        List<Object> params = new ArrayList<>();
        if (q != null && !q.trim().isEmpty()) {
            sql.append(" AND (r.code LIKE ? OR r.area LIKE ?)");
            String like = "%" + q.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (minPrice != null) {
            sql.append(" AND r.price_month >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND r.price_month <= ?");
            params.add(maxPrice);
        }
        if (roomType != null && !roomType.isBlank()) {
            sql.append(" AND r.room_type = ?");
            params.add(roomType.trim().toUpperCase());
        }
        if (utilityKeyword != null && !utilityKeyword.isBlank()) {
            sql.append(" AND EXISTS (SELECT 1 FROM dbo.RoomUtilities ru2 INNER JOIN dbo.Utilities u2 ON u2.id = ru2.utility_id WHERE ru2.room_id = r.id AND u2.name LIKE ?)");
            params.add("%" + utilityKeyword.trim() + "%");
        }

        sql.append(" GROUP BY r.id, r.code, r.area, r.price_month, r.status, r.description, r.room_type ORDER BY r.id DESC");
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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
                            rs.getString("description"),
                            rs.getString("room_type"),
                            rs.getString("utilities_summary")
                    ));
                }
                return rooms;
            }
        }
    }

    public Room findById(ServletContext ctx, int id) throws SQLException {
        String sql = """
                SELECT r.id, r.code, r.area, r.price_month, r.status, r.description, r.room_type,
                       STRING_AGG(u.name, ', ') AS utilities_summary
                FROM dbo.Room r
                LEFT JOIN dbo.RoomUtilities ru ON ru.room_id = r.id
                LEFT JOIN dbo.Utilities u ON u.id = ru.utility_id
                WHERE r.id = ?
                GROUP BY r.id, r.code, r.area, r.price_month, r.status, r.description, r.room_type
                """;
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
                        rs.getString("description"),
                        rs.getString("room_type"),
                        rs.getString("utilities_summary")
                );
            }
        }
    }

    public void create(ServletContext ctx, Room r) throws SQLException {
        String sql = "INSERT INTO dbo.Room(code, area, price_month, status, description, room_type) VALUES (?,?,?,?,?,?)";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCode());
            ps.setString(2, r.getArea());
            ps.setInt(3, r.getPriceMonth());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getDescription());
            ps.setString(6, r.getRoomType() == null ? "SINGLE" : r.getRoomType());
            ps.executeUpdate();
        }
    }

    public void update(ServletContext ctx, Room r) throws SQLException {
        String sql = "UPDATE dbo.Room SET code=?, area=?, price_month=?, status=?, description=?, room_type=? WHERE id=?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCode());
            ps.setString(2, r.getArea());
            ps.setInt(3, r.getPriceMonth());
            ps.setString(4, r.getStatus());
            ps.setString(5, r.getDescription());
            ps.setString(6, r.getRoomType() == null ? "SINGLE" : r.getRoomType());
            ps.setInt(7, r.getId());
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

