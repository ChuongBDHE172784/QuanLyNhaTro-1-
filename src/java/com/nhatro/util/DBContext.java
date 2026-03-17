package com.nhatro.util;

import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBContext {
    private DBContext() {
    }

    public static Connection getConnection(ServletContext ctx) throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ignored) {
            // Driver can be auto-loaded by JDBC; keep silent for NetBeans/Tomcat runtime.
        }
        String url = ctx.getInitParameter("DB_URL");
        String user = ctx.getInitParameter("DB_USER");
        String pass = ctx.getInitParameter("DB_PASS");
        return DriverManager.getConnection(url, user, pass);
    }

    // Hàm main dùng để test kết nối DB khi chạy độc lập (không qua Servlet/Tomcat).
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyNhaTro;encrypt=true;trustServerCertificate=true";
        String user = "sa";
        String pass = "12345";
        System.out.println("Đang thử kết nối tới SQL Server...");
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection con = DriverManager.getConnection(url, user, pass)) {
                System.out.println("Kết nối thành công! (auto-commit=" + con.getAutoCommit() + ")");
            }
        } catch (Exception e) {
            System.err.println("Kết nối thất bại:");
            e.printStackTrace();
        }
    }
}

