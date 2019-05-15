package com.baidu.rasp;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.StringReader;

/**
 * @description: jdom 解析 xxe
 * @author: anyang
 * @create: 2019/05/15 11:42
 */
public class Xxe_jdom extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String data = req.getParameter("data");
        String tmp = "";
        if (data != null) {
            try {
                SAXBuilder saxBuilder = new SAXBuilder();
                Document document = saxBuilder.build(new InputSource(new StringReader(data)));
                Element rootElement = document.getRootElement();
                tmp = rootElement.getChildText("foo");
                resp.getWriter().println(tmp);
            } catch (Exception e) {
                resp.getWriter().println(e);
            }
        }
    }
}
