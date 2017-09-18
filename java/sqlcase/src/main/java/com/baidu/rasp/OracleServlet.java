package com.baidu.rasp;

public class OracleServlet extends BaseSqlServlet {

    @Override
    public void loadProperties() {
        driver = "oracle.jdbc.driver.OracleDriver";
        dbUrl = properties.getProperty("oracleurl") + ":" + properties.getProperty("oracledb");
        user = properties.getProperty("oracleuser");
        password = properties.getProperty("oraclepassword");
        table = properties.getProperty("oracletable");
        checkField = properties.getProperty("oraclecheckfield");
        stringResult = properties.getProperty("oraclestringresult");
        intResult = properties.getProperty("oracleintresult");
    }
}
