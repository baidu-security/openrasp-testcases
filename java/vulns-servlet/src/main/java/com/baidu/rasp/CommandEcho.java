package com.baidu.rasp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * @description: 命令执行有回显
 * @author: anyang
 * @create: 2019/05/15 14:22
 */
public class CommandEcho extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String output = "";
        String cmd = req.getParameter("cmd");
        if (cmd != null) {
            try {
                ProcessBuilder builder;
                if (File.separator.startsWith("\\"))
                    builder = new ProcessBuilder("cmd", "/c", cmd);
                else
                    builder = new ProcessBuilder("sh", "-c", cmd);

                Process pro = builder.start();
                BufferedReader reader = new BufferedReader(new InputStreamReader(pro.getInputStream()));

                String s = reader.readLine();
                while (s != null) {
                    output = output + s + "\n";
                    s = reader.readLine();
                }
                reader.close();
                output = output.replace("<", "&lt;");
                output = output.replace(">", "&gt;");
                resp.getWriter().println(output);
            } catch (Exception e) {
                resp.getWriter().println(e);
            }
        } else {
            cmd = "whoami;ls;pwd";
        }
    }
}
