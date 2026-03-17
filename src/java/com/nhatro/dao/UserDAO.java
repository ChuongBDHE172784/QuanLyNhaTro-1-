package com.nhatro.dao;

import com.nhatro.model.User;
import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.nhatro.util.DBContext.getConnection;

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
}

