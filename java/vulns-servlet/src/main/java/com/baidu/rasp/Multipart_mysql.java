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
 * @description: multipart
 * @author: anyang
 * @create: 2019/05/15 15:16
 */
public class Multipart_mysql extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id = null;
            if (req.getMethod().equals("POST")) {
                if (ServletFileUpload.isMultipartContent(req)) {
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    List<FileItem> items = upload.parseRequest(req);
                    for (FileItem item : items) {
                        if (item.isFormField() && item.getFieldName().equals("id")) {
                            id = item.getString();
                            break;
                        }
                    }
                }
            }
            if (id == null) {
                id = "1";
            }
            String result = Mysql.runQuery(id);
            resp.getWriter().println(result);
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }
}
