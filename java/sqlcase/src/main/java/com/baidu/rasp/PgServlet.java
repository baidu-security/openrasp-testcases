package com.baidu.rasp;

public class PgServlet extends BaseSqlServlet {

    @Override
    public void loadProperties() {
        driver = "org.postgresql.Driver";
        dbUrl = properties.getProperty("pgurl") + fileSeparator + properties.getProperty("pgdb");
        user = properties.getProperty("pguser");
        password = properties.getProperty("pgpassword");
        table = properties.getProperty("pgtable");
        checkField = properties.getProperty("pgcheckfield");
        stringResult = properties.getProperty("pgstringresult");
        intResult = properties.getProperty("pgintresult");
    }
}
