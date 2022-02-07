package com.baidu.rasp;


import com.baidu.rasp.task.DNSTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class DNS extends HttpServlet {

    public ExecutorService executor = Executors.newFixedThreadPool(5);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setHeader("Content-type", "text/html;charset=UTF-8");//告知浏览器编码方式;
        resp.setCharacterEncoding("UTF-8");
        String option = req.getParameter("option");
        if ("DNS".equals(option)){
            String result = DNSTask.getHostNames("8.8.8.8");
            resp.getWriter().println(result);
        }else if ("DNSBad".equals(option)){
            String result = DNSTask.getHostNames("www.dnslog.cn");
            resp.getWriter().println(result);
        }else if ("asyncDNS".equals(option)){
            Future<String> f = executor.submit(new DNSTask("8.8.8.8"));
            try {
                String result =  f.get();
                resp.getWriter().println(result);
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().println(e.getMessage());
            }
        }else if ("asyncDNSBad".equals(option)){
            Future<String> f = executor.submit(new DNSTask("www.dnslog.cn"));
            try {
                String result =  f.get();
                resp.getWriter().println(result);
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().println(e.getMessage());
            }
        }
    }
}