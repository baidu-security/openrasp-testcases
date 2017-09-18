package com.baidu.rasp;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqliteServlet extends BaseSqlServlet {

    @Override
    public Connection getSQLConnection(String dbUrl, String user, String password) throws SQLException {
        return DriverManager.getConnection(dbUrl);
    }

    @Override
    public void loadProperties() {
        driver = "org.sqlite.JDBC";
        dbUrl = properties.getProperty("sqliteurl");
        user = properties.getProperty("sqliteuser");
        password = properties.getProperty("sqlitepassword");
        table = properties.getProperty("sqlitetable");
        checkField = properties.getProperty("sqlitecheckfield");
        stringResult = properties.getProperty("sqlitestringresult");
        intResult = properties.getProperty("sqliteintresult");
    }
}
