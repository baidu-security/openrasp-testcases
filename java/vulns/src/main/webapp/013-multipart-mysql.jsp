<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.http.HttpUtils.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%! String runQuery(String id) throws SQLException {
     Connection conn = null; 
     Statement stmt = null; 
     ResultSet rset = null; 
     try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "test", "test");  
        stmt = conn.createStatement();
        rset = stmt.executeQuery ("SELECT * FROM vuln WHERE id = " + id);
       return (formatResult(rset));
     } catch (Exception e) { 
       return ("<P> Error: <PRE> " + e + " </PRE> </P>\n");
     } finally {
         if (rset!= null) rset.close(); 
         if (stmt!= null) stmt.close();
         if (conn!= null) conn.close();
     }
  }
  String formatResult(ResultSet rset) throws SQLException {
    StringBuffer sb = new StringBuffer();
    if (!rset.next()) {
        sb.append("<P> No matching rows.<P>\n");
    } else {  
        do {  
            sb.append(rset.getString(2) + "\n");
        } while (rset.next());
    }
    return sb.toString();
  }
%>

<%
    String id = null;

    if (request.getMethod().equals("POST")) {
        try {
            if (ServletFileUpload.isMultipartContent(request)) 
            {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload    = new ServletFileUpload(factory);
                List<FileItem> items        = upload.parseRequest(request);
                for (FileItem item : items) 
                {
                    if (item.isFormField() && item.getFieldName().equals("id")) 
                    {
                        id = item.getString();
                        break;
                    }
                }
            }
        } catch (Exception e) {
            out.print(e);
        }
    }

    if (id == null) 
    {
        id = "1";
    }
%>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>013 - SQL 注入测试 - JDBC multipart 请求方式</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
  <div class="container-fluid" style="margin-top: 50px;">
    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <h4>SQL注入 - JDBC + multipart 请求格式</h4>
        <p>第一步: 请以mysql root账号执行下面的语句创建表</p>
        <pre>DROP DATABASE IF EXISTS test;
CREATE DATABASE test;         
grant all privileges on test.* to 'test'@'%' identified by 'test';
grant all privileges on test.* to 'test'@'localhost' identified by 'test';
CREATE TABLE test.vuln (id INT, name text);
INSERT INTO test.vuln values (0, "openrasp");
INSERT INTO test.vuln values (1, "rocks");
</pre>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <p>第二步: 尝试发起SQL注入攻击</p>
        <form action="<%= javax.servlet.http.HttpUtils.getRequestURL(request) %>" method="post" enctype="multipart/form-data">
          <div class="form-group">
             <label>查询条件</label>
             <input class="form-control" name="id" value="<%= id %> " autofocus>
          </div>

          <button type="submit" class="btn btn-primary">提交查询</button> 
        </form>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <p>第三步: 检查注入结果</p>
        <%= runQuery(id) %>
        <table class="table">
          <tbody>
            
          </tbody>
        </table>
      </div>
    </div>
  </div>


</body>
