package com.example.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = "/file2/upload")
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 1,
  maxFileSize       = 1024 * 1024 * 1,
  maxRequestSize    = 1024 * 1024 * 2
)
public class FileUploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        Part filePart = req.getPart("file");
        if (filePart == null) {
            resp.getWriter().println("no file provided");
            return;
        }

        String fileName = filePart.getSubmittedFileName();
        resp.getWriter().println("saved " + fileName + " to /tmp");

        // 也可以用getInputStream()
        filePart.write("/tmp/" + fileName);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        resp.getWriter().println("GET not supported");
    }
}