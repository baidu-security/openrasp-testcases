package com.baidu.rasp;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description: ssrf
 * @author: anyang
 * @create: 2019/02/25 14:23
 */
public class HttpCommonClient extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String urlString = req.getParameter("url");
            if (urlString != null) {
                HttpClient httpClient = new HttpClient();
                GetMethod getMethod = new GetMethod(urlString);
                httpClient.executeMethod(getMethod);
                String charSet = getMethod.getResponseCharSet();
                byte[] responseBody = getMethod.getResponseBody();
                resp.getWriter().println("response:\r\n" + new String(responseBody, charSet));
            }
        } catch (IOException e) {
            resp.getWriter().println(e);
        }
    }
}
