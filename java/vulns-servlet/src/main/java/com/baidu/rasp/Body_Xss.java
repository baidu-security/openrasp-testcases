package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @description: xss
 * @author: anyang
 * @create: 2019/02/25 18:25
 */
public class Body_Xss extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String param = req.getParameter("input");
        PrintWriter out = resp.getWriter();
        if (param != null) {
            out.println(param);
        } else {
            out.println("<p>获取input失败</p>");
        }
    }
}
