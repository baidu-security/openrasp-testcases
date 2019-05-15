package com.baidu.rasp;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.IOException;
import java.io.StringReader;

/**
 * @description: xxe测试case
 * @author: anyang
 * @create: 2019/02/25 15:02
 */
public class Xxe_dom extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String data = req.getParameter("data");
        if (data != null) {
            try {
                DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
                Document doc = docBuilder.parse(new InputSource(new StringReader(data)));
                NodeList RegistrationNo = doc.getElementsByTagName("foo");
                String tmp = RegistrationNo.item(0).getFirstChild().getNodeValue();
                resp.getWriter().println(tmp);
            } catch (Exception e) {
                resp.getWriter().println(e);
            }
        }
    }
}
