package nhatro.dao;

import nhatro.model.User;
import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static nhatro.util.DBContext.getConnection;

public class UserDAO {

    public User findByEmailAndPassword(ServletContext ctx, String email, String password) throws SQLException {
        String sql = "SELECT id, email, full_name, role FROM dbo.[User] WHERE email = ? AND password = ?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("full_name"),
                            rs.getString("role")
                    );
                }
                return null;
            }
        }
    }

    public User findById(ServletContext ctx, int id) throws SQLException {
        String sql = "SELECT id, email, full_name, role, phone, cccd, avatar_url FROM dbo.[User] WHERE id = ?";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                User u = new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("full_name"),
                        rs.getString("role")
                );
                u.setPhone(rs.getString("phone"));
                u.setCccd(rs.getString("cccd"));
                u.setAvatarUrl(rs.getString("avatar_url"));
                return u;
            }
        }
    }

    public void updateStudentProfile(ServletContext ctx, int userId, String phone, String cccd, String avatarUrl) throws SQLException {
        String sql = "UPDATE dbo.[User] SET phone = ?, cccd = ?, avatar_url = ? WHERE id = ? AND role = 'STUDENT'";
        try (Connection con = getConnection(ctx); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, cccd);
            ps.setString(3, avatarUrl);
            ps.setInt(4, userId);
            ps.executeUpdate();
        }
    }
}

