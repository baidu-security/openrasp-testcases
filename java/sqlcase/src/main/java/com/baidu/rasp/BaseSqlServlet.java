package com.baidu.rasp;

import com.mysql.jdbc.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;


public abstract class BaseSqlServlet extends HttpServlet implements SQLInterface {

    final String fileSeparator = System.getProperty("file.separator");
    Properties properties = null;
    public String driver = "";
    public String dbUrl = "";
    public String user = "";
    public String password = "";
    public String table = "";
    public String checkField = "";
    public String stringResult = "";
    public String intResult = "";
    public String isPrepared = "false";

    public BaseSqlServlet() {
        properties = new Properties();
    }

    public abstract void loadProperties();

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {
        String rootPath = request.getSession().getServletContext().getRealPath("");
        properties.load(new BufferedInputStream(new FileInputStream(rootPath + "/WEB-INF/sqlcase.properties")));
        loadProperties();

        String checkFieldString = request.getParameter(checkField);
        isPrepared = request.getParameter("prepared");
        // Set response content type
        PrintWriter out = response.getWriter();
        String title = "Database Result";
        String resultString = "";
        out.println(title + "\n");
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName(driver);
            conn = getSQLConnection(dbUrl, user, password);
            String sql;
            if (StringUtils.isNullOrEmpty(checkFieldString)) {
                sql = "SELECT * FROM " + table;
            } else {
                sql = "SELECT * FROM " + table + " WHERE " + checkField + "='" + checkFieldString + "'";
            }
            if ("true".equals(isPrepared)) {
                stmt = conn.prepareStatement(sql);
                rs = ((PreparedStatement) stmt).executeQuery();
            } else {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
            }
            String[] stringItem = null;
            String[] intItem = null;
            if (stringResult != null && !stringResult.equals("")) {
                stringItem = stringResult.split(",");
            }
            if (intResult != null && !intResult.equals("")) {
                intItem = intResult.split(",");
            }
            while (rs.next()) {
                if (stringItem != null) {
                    for (int i = 0; i < stringItem.length; ++i) {
                        resultString += stringItem[i] + ":" + rs.getString(stringItem[i]) + " ; ";
                    }
                }
                if (intItem != null) {
                    for (int i = 0; i < intItem.length; ++i) {
                        resultString += intItem[i] + ":" + rs.getInt(intItem[i]) + " ; ";
                    }
                }
                resultString += "\n";
            }
            out.println(resultString);
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
                System.out.println("数据库连接已关闭！");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public Connection getSQLConnection(String dbUrl, String user, String password) throws SQLException {
        return DriverManager.getConnection(dbUrl, user, password);
    }
}
