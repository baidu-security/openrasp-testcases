//package com.baidu.rasp;
//
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.SQLException;
//import java.sql.Statement;
//
//public class DBSqliteDataMaker extends HttpServlet implements SQLInterface {
//
//    private String driver = "org.sqlite.JDBC";
//    private String dbUrl = "jdbc:sqlite:../test.db";
//    private String user = "";
//    private String password = "";
//
//    public Connection getSQLConnection(String dbUrl, String user, String password) throws SQLException {
//        return DriverManager.getConnection(dbUrl);
//    }
//
//
//    public void doGet(HttpServletRequest request,
//                      HttpServletResponse response)
//            throws ServletException, IOException {
//        Connection c = null;
//        Statement stmt = null;
//        PrintWriter out = response.getWriter();
//        try {
//            Class.forName(driver);
//            c = getSQLConnection(dbUrl, user, password);
//            stmt = c.createStatement();
//            String sql = "CREATE TABLE PERSON(ID INT PRIMARY KEY NOT NULL, "
//                    + "FIRST VARCHAR(20) NOT NULL, LAST VARCHAR(30) NOT NULL);";
//            stmt.executeUpdate(sql);
//            String sql1 = "INSERT INTO PERSON(ID,FIRST,LAST) VALUES (1,'John','Peter');";
//            stmt.executeUpdate(sql1);
//            stmt.close();
//            c.close();
//        } catch (Exception e) {
//            System.out.println(e.getClass().getName() + ": " + e.getMessage());
//        } finally {
//            try {
//                if (stmt != null) {
//                    stmt.close();
//                }
//                if (c != null) {
//                    c.close();
//                }
//                System.out.println("数据库连接已关闭！");
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//        out.println("ok");
//    }
//}
