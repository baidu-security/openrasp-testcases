package com.example.servlet;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(urlPatterns = "/file3/upload")
public class CommonsFileUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setRepository(new File("/tmp"));

            ServletFileUpload fileUpload = new ServletFileUpload(factory);
            for (FileItem fileItem : fileUpload.parseRequest(req)) {
                if (fileItem.isFormField()) {
                    continue;
                }

                fileItem.write(new File("/tmp/" + fileItem.getName()));
                resp.getWriter().println("saved " + fileItem.getName() + " to /tmp");
            }
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().println("GET not supported");
    }
}