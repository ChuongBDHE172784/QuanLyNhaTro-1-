package nhatro.util;

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
      
        String sep = url.endsWith(";") ? "" : ";";
        return DriverManager.getConnection(
                url + sep + "loginTimeout=5;connectTimeout=5",
                user,
                pass
        );
    }

    
   
}

