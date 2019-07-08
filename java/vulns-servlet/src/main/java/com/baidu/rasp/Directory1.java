package com.baidu.rasp;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/**
 * @author anyang
 * @Description: 目录遍历
 * @date 2018/6/27 22:00
 */
public class Directory1 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String dirname = req.getParameter("dirname");
            if (dirname != null) {
                File folder;
                ServletContext application = this.getServletContext();
                String serverInfo = application.getServerInfo();
                if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                    folder = new File(application.getResource("/").getPath() + "/" + dirname);
                } else {
                    folder = new File(application.getRealPath("/") + "/" + dirname);
                }
                if (folder.isDirectory()) {
                    File[] listOfFiles = folder.listFiles();
                    if (listOfFiles != null) {
                        for (File file : listOfFiles) {
                            if (file.isFile()) {
                                resp.getWriter().println(file.getName());
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }
}
