package com.baidu.rasp;

import ognl.OgnlException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description: ognl测试
 * @author: anyang
 * @create: 2019/02/25 14:48
 */
public class Ognl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Object value = ognl.Ognl.parseExpression("@org.apache.commons.io.IOUtils@toString(@java.lang.Runtime@getRuntime().exec(\"whoami\").getInputStream())");
            resp.getWriter().println(value);
        } catch (OgnlException e) {
            e.printStackTrace();
        }
    }
}
