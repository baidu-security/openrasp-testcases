package com.baidu.rasp;

/**
 * Created by tyy on 18-5-7.
 */
public class DB2Servlet extends BaseSqlServlet {
    public void loadProperties() {
        this.driver = "com.ibm.db2.jcc.DB2Driver";
        this.dbUrl = (this.properties.getProperty("db2url") + "/" + this.properties.getProperty("db2db"));
        this.user = this.properties.getProperty("db2user");
        this.password = this.properties.getProperty("db2password");
        this.table = this.properties.getProperty("db2table");
        this.checkField = this.properties.getProperty("db2checkfield");
        this.stringResult = this.properties.getProperty("db2stringresult");
        this.intResult = this.properties.getProperty("db2intresult");
    }
}
