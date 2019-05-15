package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description: 命令执行测试case
 * @author: anyang
 * @create: 2019/02/25 12:16
 */
public class Command extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String cmd = req.getParameter("cmd");
            if (cmd != null) {
                Runtime.getRuntime().exec(cmd);
            }
        } catch (IOException e) {
            resp.getWriter().println(e);
        }
    }
}
