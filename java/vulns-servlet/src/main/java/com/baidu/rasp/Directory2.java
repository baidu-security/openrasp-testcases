package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/**
 * @description: 目录遍历2
 * @author: anyang
 * @create: 2019/06/17 13:52
 */
public class Directory2 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String dirname = req.getParameter("dirname");
            if (dirname != null) {
                File folder = new File(dirname);
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
