package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

/**
 * @description: mysql prepared 测试
 * @author: anyang
 * @create: 2019/02/25 14:43
 */
public class MysqlPrepared extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null) {
            id = "1";
        }
        try {
            runQuery(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String runQuery(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rset = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "test", "test");
            stmt = conn.prepareStatement("SELECT * FROM vuln WHERE id = " + id);
            rset = stmt.executeQuery();
            return (formatResult(rset));
        } catch (Exception e) {
            return ("<P> Error: <PRE> " + e + " </PRE> </P>\n");
        } finally {
            if (rset!= null) rset.close();
            if (stmt!= null) stmt.close();
            if (conn!= null) conn.close();
        }
    }
    private String formatResult(ResultSet rset) throws SQLException {
        StringBuilder sb = new StringBuilder();
        if (!rset.next()) {
            sb.append("<P> No matching rows.<P>\n");
        } else {
            do {
                sb.append(rset.getString(2) + "\n");
            } while (rset.next());
        }
        return sb.toString();
    }
}
