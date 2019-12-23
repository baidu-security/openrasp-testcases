package com.baidu.rasp;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description: log4j打印敏感日志信息文件
 * @author: anyang
 * @create: 2019/05/15 14:39
 */
public class Log extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Logger log = Logger.getLogger("com.mobilefish.demo.test");
            if (log != null) {
                log.info("身份证 620503198801272195\n");
                log.warn("IdCard=42050319820815801X DepositCard=6225750103374126 Transaction=1999.22\n");
            }
        } catch (Exception e) {
            resp.getWriter().print(e);
        }
    }
}
