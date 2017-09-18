package com.baidu.rasp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MssqlServlet extends BaseSqlServlet {

    @Override
    public Connection getSQLConnection(String dbUrl, String user, String password) throws SQLException {
        return DriverManager.getConnection(dbUrl);
    }

    @Override
    public void loadProperties() {
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        dbUrl = properties.getProperty("mssqlurl") + ";user=" + properties.getProperty("mssqluser")
                + ";password=" + properties.getProperty("mssqlpassword") + ";databaseName="
                + properties.getProperty("mssqldb");
        table = properties.getProperty("mssqltable");
        checkField = properties.getProperty("mssqlcheckfield");
        stringResult = properties.getProperty("mssqlstringresult");
        intResult = properties.getProperty("mssqlintresult");
    }
}
