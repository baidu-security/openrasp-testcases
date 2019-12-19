package com.dubbo.provider.serviceImpl;


import com.dubbo.demo_interface.api.IUserService;
import org.springframework.stereotype.Service;

import java.sql.*;

/**
 * Created by anyang on 2018/6/25.
 */
@Service
public class UserService implements IUserService {

    @Override
    public String select() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test", "root", "123456");
        Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM vuln");
        StringBuilder sb = new StringBuilder();
        if (!rset.next()) {
            sb.append("<P> No matching rows.<P>\n");
        } else {
            do {
                sb.append(rset.getInt(1) + "===");
                sb.append(rset.getString(2) + "\n");
            } while (rset.next());
        }
        return sb.toString();
    }

    @Override
    public String select(String id) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test", "root", "123456");
        Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM vuln where id=" + id);
        StringBuilder sb = new StringBuilder();
        if (!rset.next()) {
            sb.append("<P> No matching rows.<P>\n");
        } else {
            sb.append(rset.getInt(1) + "===");
            sb.append(rset.getString(2) + "\n");
        }
        return sb.toString();
    }

    @Override
    public String select(String[] ids) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test", "root", "123456");
        Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery("SELECT * FROM vuln where id=" + ids[0]);
        StringBuilder sb = new StringBuilder();
        if (!rset.next()) {
            sb.append("<P> No matching rows.<P>\n");
        } else {
            sb.append(rset.getInt(1) + "===");
            sb.append(rset.getString(2) + "\n");
        }
        return sb.toString();
    }
}
