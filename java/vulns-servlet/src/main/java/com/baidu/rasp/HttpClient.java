package com.baidu.rasp;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * @description: ssrf
 * @author: anyang
 * @create: 2019/02/25 14:27
 */
public class HttpClient extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String urlString = req.getParameter("url");
            if (urlString != null) {
                StringBuffer resultBuffer = null;
                org.apache.http.client.HttpClient client = HttpClients.createDefault();
                BufferedReader br = null;
                HttpGet httpGet = new HttpGet(urlString);
                HttpResponse res = client.execute(httpGet);
                // 读取服务器响应数据
                br = new BufferedReader(new InputStreamReader(res.getEntity().getContent()));
                String temp;
                resultBuffer = new StringBuffer();
                while ((temp = br.readLine()) != null) {
                    resultBuffer.append(temp);
                }
                resp.getWriter().println(resultBuffer);
            }
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }
}
