package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamReader;
import java.io.IOException;
import java.io.StringReader;

/**
 * @description: stax 解析 xxe
 * @author: anyang
 * @create: 2019/05/15 11:42
 */
public class Xxe_stax extends HttpServlet {
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
                XMLInputFactory factory = XMLInputFactory.newInstance();
                XMLStreamReader reader = factory.createXMLStreamReader(new StringReader(data));
                while (reader.hasNext()) {
                    int event = reader.next();
                    if (event == XMLStreamConstants.START_ELEMENT) {
                        if (reader.getName().toString().equals("foo")) {
                            tmp = reader.getElementText();
                            resp.getWriter().println(tmp);
                        }
                    }
                }
            } catch (Exception e) {
                resp.getWriter().println(e);
            }
        }
    }
}
