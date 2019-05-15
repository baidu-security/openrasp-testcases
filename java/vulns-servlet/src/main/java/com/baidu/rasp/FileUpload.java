package com.baidu.rasp;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @description: 文件上传测试case
 * @author: anyang
 * @create: 2019/02/25 14:18
 */
public class FileUpload extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String method = req.getMethod();
            if ("POST".equals(method)){
                boolean isMultipart = ServletFileUpload.isMultipartContent(req);
                if (isMultipart) {
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    List<FileItem> items = upload.parseRequest(req);
                    for (FileItem item : items) {
                        String content = new String(item.get());
                        resp.getWriter().println(content);
                    }
                }
            }
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }
}
