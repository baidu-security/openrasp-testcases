<%@page import="java.io.*" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.util.stream.Stream" %>
<%@ page import="java.util.function.Consumer" %>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>021 NIO 文件操作</title>
</head>
<body>
<%
    String read_normal_querystring = "?file=example.pdf&&mode=read";
    String read_linux_querystring = "?file=../../../../../../../../../../../../../../../etc/passwd&mode=read";
    String read_windows_querystring = "?file=../../../conf/tomcat-users.xml&mode=read";

    String normal_querystring = "?filename=123.txt&amp;filedata=some-report-data&mode=write";
    String linux_querystring = "?filename=reports/../123.jsp&amp;filedata=some-webshell-data&mode=write";

    String normal_delete_querystring = "?filename=testfile.txt&mode=delete";
    String linux_delete_querystring = "?filename=reports/../testfile.txt&mode=delete";

    String normal_link_querystring = "?filename=testfile.txt&dst=testfile.log&mode=link";
    String linux_link_querystring = "?filename=reports/../testfile.txt&dst=reports/../testfile.jsp&mode=link";

    String normal_list_querystring = "?dirname=reports&mode=list";
    String linux_list_querystring = "?dirname=../../../../../../../../../../../../../../../var/log/&mode=list";
    String windows_list_querystring = "?dirname=../../../&mode=list";

    String normal_rename_querystring = "?filename=rename.txt&dst=rename.log&mode=rename";
    String linux_rename_querystring = "?filename=reports/../rename.txt&dst=reports/../rename.jsp&mode=rename";

    String bytes = request.getParameter("filedata");
    String fname = request.getParameter("filename");
    String mode = request.getParameter("mode");
%>
<p>注意 JDK6 以下版本 JDK 不支持以下 NIO case</p>
<p>正常写入文件调用</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>"
            target="_blank"><%=request.getRequestURL() + normal_querystring%>
</a>'</p>
<p>不正常写入文件调用</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_querystring%>
</a>'</p>
<p>正常读取调用</p>
<p>curl '<a href="<%=request.getRequestURL()+read_normal_querystring%>"
            target="_blank"><%=request.getRequestURL() + read_normal_querystring%>
</a>'</p>

<p>不正常读取调用 - Linux</p>
<p>curl '<a href="<%=request.getRequestURL()+read_linux_querystring%>"
            target="_blank"><%=request.getRequestURL() + read_linux_querystring%>
</a>'</p>

<p>不正常读取调用 - Windows</p>
<p>curl '<a href="<%=request.getRequestURL()+read_windows_querystring%>"
            target="_blank"><%=request.getRequestURL() + read_windows_querystring%>
</a>'</p>

<p>正常删除文件</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_delete_querystring%>"
            target="_blank"><%=request.getRequestURL() + normal_delete_querystring%>
</a>'</p>
<p>不正常删除文件</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_delete_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_delete_querystring%>
</a>'</p>

<p>正常文件硬链接</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_link_querystring%>"
            target="_blank"><%=request.getRequestURL() + normal_link_querystring%>
</a>'</p>

<p>不正常文件硬链接</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_link_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_link_querystring%>
</a>'</p>

<p>正常目录遍历</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_list_querystring%>"
            target="_blank"><%=request.getRequestURL() + normal_list_querystring%>
</a>'</p>

<p>不正常目录遍历 - Linux</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_list_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_list_querystring%>
</a>'</p>

<p>不正常目录遍历 - Windows</p>
<p>curl '<a href="<%=request.getRequestURL()+windows_list_querystring%>"
            target="_blank"><%=request.getRequestURL() + windows_list_querystring%>
</a>'</p>

<p>正常文件重命名</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_rename_querystring%>"
            target="_blank"><%=request.getRequestURL() + normal_rename_querystring%>
</a>'</p>

<p>不正常文件重命名</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_rename_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_rename_querystring%>
</a>'</p>

<%
    if ("delete".equals(mode)) {
        if (fname != null) {
            String path;
            String serverInfo = application.getServerInfo();
            if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                path = application.getResource("/").getPath() + "/" + fname;
            } else {
                path = application.getRealPath("/") + "/" + fname;
            }

            try {
                FileOutputStream os = new FileOutputStream("openrasp.test");
                PrintWriter writer = new PrintWriter(os);
                writer.close();
                File f = new File("openrasp.test");
                f.renameTo(new File(path));
                out.println("文件已创建:" + path + "\n<br/>");
            } catch (Exception e) {
                out.print(e);
            }

            try {
                File file = new File(path);
                Path patha = Paths.get(file.getAbsolutePath());
                try {
                    Files.delete(patha);
                    out.println("文件 " + file.getName() + " 删除成功！" + "\n<br/>");
                } catch (Exception e) {
                    out.println("文件删除失败！" + e.getMessage());
                }
            } catch (Exception e) {
                out.print(e);
            }
        }
    } else if ("link".equals(mode)) {
        if (fname != null) {
            String dstName = request.getParameter("dst");
            String path;
            String dst;
            String serverInfo = application.getServerInfo();
            if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                path = application.getResource("/").getPath() + "/" + fname;
                dst = application.getResource("/").getPath() + "/" + dstName;
            } else {
                path = application.getRealPath("/") + "/" + fname;
                dst = application.getRealPath("/") + "/" + dstName;
            }

            try {
                FileOutputStream os = new FileOutputStream("openrasp.test");
                PrintWriter writer = new PrintWriter(os);
                writer.close();
                File f = new File("openrasp.test");
                f.renameTo(new File(path));
                out.println("文件已创建:" + path + "\n<br/>");
            } catch (Exception e) {
                out.print(e);
            }

            try {
                File file = new File(path);
                File dstFile = new File(dst);
                if (dstFile.exists()) {
                    dstFile.delete();
                }
                Path patha = Paths.get(file.getAbsolutePath());
                Path dsta = Paths.get(dstFile.getAbsolutePath());
                try {
                    Files.createLink(dsta, patha);
                    out.println("文件 " + dstFile.getName() + " 硬链接到 "+file.getName() + "\n<br/>");
                } catch (Exception e) {
                    out.println("文件硬链接创建失败！" + e.getMessage());
                }
            } catch (Exception e) {
                out.print(e);
            }

        }
    } else if ("write".equals(mode)) {
        try {
            String path;
            String serverInfo = application.getServerInfo();
            if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                path = application.getResource("/").getPath() + "/" + fname;
            } else {
                path = application.getRealPath("/") + "/" + fname;
            }

            Path patha = Paths.get(path);
            Files.write(patha, bytes.getBytes());
            out.println("==>" + path);
            out.flush();
        } catch (Exception e) {
            out.print(e);
        }
    } else if ("read".equals(mode)) {
        String reportName = request.getParameter("file");
        if (reportName != null) {
            try {
                String fileName;
                String serverInfo = application.getServerInfo();
                if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                    fileName = application.getResource("/").getPath() + "/reports/" + reportName;
                } else {
                    fileName = application.getRealPath("/") + "/reports/" + reportName;
                }

                Path patha = Paths.get(fileName);
                byte[] outputByte = Files.readAllBytes(patha);
                String outputStr = new String(outputByte, "UTF-8");
                out.print(outputStr);
                out.flush();
            } catch (Exception e) {
                out.print(e);
            }
        }
    } else if ("list".equals(mode)) {
        String dirname = request.getParameter("dirname");
        if (dirname != null) {
            try {
                File folder;
                String serverInfo = application.getServerInfo();
                if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                    folder = new File(application.getResource("/").getPath() + "/" + dirname);
                } else {
                    folder = new File(application.getRealPath("/") + "/" + dirname);
                }
                Path patha = Paths.get(folder.getAbsolutePath());
                Stream<Path> dir = Files.walk(patha, 1);
                final JspWriter writer = out;
                dir.forEach(new Consumer<Path>() {
                    @Override
                    public void accept(Path path) {
                        try {
                            writer.println(path.getFileName());
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                });
            } catch (Exception e) {
                out.print(e);
            }
        }
    } else if ("rename".equals(mode)) {
        if (fname != null) {
            String dstName = request.getParameter("dst");
            String path;
            String dst;
            String serverInfo = application.getServerInfo();
            if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
                path = application.getResource("/").getPath() + "/" + fname;
                dst = application.getResource("/").getPath() + "/" + dstName;
            } else {
                path = application.getRealPath("/") + "/" + fname;
                dst = application.getRealPath("/") + "/" + dstName;
            }

            try {
                FileOutputStream os = new FileOutputStream("openrasp.test");
                PrintWriter writer = new PrintWriter(os);
                writer.close();
                File f = new File("openrasp.test");
                f.renameTo(new File(path));
                out.println("文件已创建:" + path + "\n<br/>");
            } catch (Exception e) {
                out.print(e);
            }

            try {
                File file = new File(path);
                File dstFile = new File(dst);
                if (dstFile.exists()) {
                    dstFile.delete();
                }
                Path patha = Paths.get(file.getAbsolutePath());
                Path dsta = Paths.get(dstFile.getAbsolutePath());
                try {
                    Files.move(patha, dsta);
                    out.println("文件 " + file.getName() + " 重命名为 " + dstFile.getName() + "\n<br/>");
                } catch (Exception e) {
                    out.println("文件重命名失败！" + e.getMessage());
                }
            } catch (Exception e) {
                out.print(e);
            }

        }
    }
%>

</body>
</html>
