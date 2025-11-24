package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Centralized DB connection helper.
 * By default, uses jdbc:mysql://127.0.0.1:3306/qlktx with user root and empty password
 * Call DBConnection.configure(url,user,pass) from application init if you need different settings.
 */
public class DBConnection {
    private static String URL = "jdbc:mysql://127.0.0.1:3306/QLKTX";
    private static String USER = "root";
    private static String PASS = "12341234";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // Driver not found - print stack for visibility
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public static void configure(String url, String user, String pass) {
        if (url != null && !url.isEmpty()) URL = url;
        if (user != null) USER = user;
        if (pass != null) PASS = pass;
    }
}
