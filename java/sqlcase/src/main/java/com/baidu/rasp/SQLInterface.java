package com.baidu.rasp;

import java.sql.Connection;
import java.sql.SQLException;


/**
 * Created by lxk on 7/16/17.
 */

public interface SQLInterface {
    Connection getSQLConnection(String dbUrl, String user, String password) throws SQLException;

}

