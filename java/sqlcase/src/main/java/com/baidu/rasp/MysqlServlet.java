package com.baidu.rasp;


public class MysqlServlet extends BaseSqlServlet {

    @Override
    public void loadProperties() {
        driver = "com.mysql.jdbc.Driver";
        dbUrl = properties.getProperty("mysqlurl") + fileSeparator + properties.getProperty("mysqldb");
        user = properties.getProperty("mysqluser");
        password = properties.getProperty("mysqlpassword");
        table = properties.getProperty("mysqltable");
        checkField = properties.getProperty("mysqlcheckfield");
        stringResult = properties.getProperty("mysqlstringresult");
        intResult = properties.getProperty("mysqlintresult");
    }
}
