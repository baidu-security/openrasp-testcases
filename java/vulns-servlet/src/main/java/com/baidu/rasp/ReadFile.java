package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * @description: 读文件测试case
 * @author: anyang
 * @create: 2019/02/25 14:57
 */
public class ReadFile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String file = req.getParameter("file");
            if (file != null) {
                FileInputStream fileIn = new FileInputStream(file);
                OutputStream outStream = resp.getOutputStream();
                byte[] outputByte = new byte[4096];
                while (fileIn.read(outputByte, 0, 4096) != -1) {
                    outStream.write(outputByte, 0, 4096);
                }
                fileIn.close();
            }
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }
}
