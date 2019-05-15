package com.baidu.rasp;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description: okhttp3测试case
 * @author: anyang
 * @create: 2019/02/25 15:09
 */
public class OkHttp3 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String urlString = req.getParameter("url");
            if (urlString != null) {
                OkHttpClient client = new OkHttpClient();
                Request request = new Request.Builder().url(urlString).build();
                Response response = client.newCall(request).execute();
                String result = response.body().string();
                resp.getWriter().println(result);
            }
        } catch (IOException e) {
            resp.getWriter().println(e);
        }
    }
}
