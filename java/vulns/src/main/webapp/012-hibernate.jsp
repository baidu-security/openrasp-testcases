<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>

<%-- Declare and define the runQuery() method. --%>
<%!
    String runQuery(String configPath, String id, String rootDir) throws Exception {
        String result = "";
        try {
            Configuration configuration = new Configuration().configure(new File(configPath));
            //获得会话工厂，创建会话
            SessionFactory buildSessionFactory = configuration.buildSessionFactory();
            //获得session
            Session session = buildSessionFactory.openSession();

            //开启事务
            Transaction tx = session.beginTransaction();

            Query query = session.createSQLQuery("select * from vuln where id = " + id);
            Object[] uniqueResult = (Object[]) query.uniqueResult();
            if (uniqueResult != null) {
                for (Object object : uniqueResult) {
                    result = result + object + " ";
                }
            }
            //关闭资源
            session.close();
            buildSessionFactory.close();
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
        return result;
    }

    String formatResult(List<HashMap> rset) throws SQLException {
        StringBuffer sb = new StringBuffer();
        if (rset == null || rset.isEmpty()) {
            sb.append("<P> No matching rows.<P>\n");
        } else {
            for (HashMap item : rset) {
                sb.append(item.toString() + "\n");
            }
        }
        return sb.toString();
    }
%>

<%
    String rootDir;
    String serverInfo = application.getServerInfo();
    if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
        rootDir = application.getResource("/").getPath();
    } else {
        rootDir = application.getRealPath("/");
    }
    String id = null;
    String content_type = request.getContentType();
    if (content_type != null && content_type.indexOf("application/json") != -1) {
        int size = request.getContentLength();
        String postdata = null;
        if (size > 0) {
            byte[] buf = new byte[size];
            try {
                request.getInputStream().read(buf);
                postdata = new String(buf);
                if (postdata != null) {
                    net.sf.json.JSONObject json = net.sf.json.JSONObject.fromObject(postdata);
                    if (json != null) {
                        id = json.getString("id");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    } else {
        id = request.getParameter("id");
    }
    if (id == null) {
        id = "1";
    }
    String escid = id.replaceAll("'", "&#39;");
%>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>012 - SQL 注入测试 - JDBC executeQuery() 方式</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<script>
    function GetUrlRelativePath() {
        var url = document.location.toString();
        var arrUrl = url.split("//");
        var start = arrUrl[1].indexOf("/");
        var relUrl = arrUrl[1].substring(start);
        if (relUrl.indexOf("?") != -1) {
            relUrl = relUrl.split("?")[0];
        }
        return relUrl;
    }

    function getXMLHttpRequest() {
        var xmlhttp;
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        return xmlhttp;
    }

    function send_json() {
        var data = document.getElementById("jsoninput").value;
        var xmlhttp = getXMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.body.innerHTML = "";
                document.write(xmlhttp.responseText);
            }
        }
        url = GetUrlRelativePath()
        xmlhttp.open("POST", url, true);
        xmlhttp.setRequestHeader("Content-type", "application/json;charset=UTF-8");
        xmlhttp.send(data);
    }
</script>
<div class="container-fluid" style="margin-top: 50px;">
    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <h4>SQL注入 - JDBC executeQuery() 方式</h4>
            <p>mybatis 相关配置在该 jsp 所在目录下的 mybatis_conf 目录下面</p>
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
            <p>第二步: 尝试发起SQL注入攻击 - 为了保证性能，默认只会检测长度超过15的语句</p>
            <form action="<%=javax.servlet.http.HttpUtils.getRequestURL(request)%>" method="get">
                <div class="form-group">
                    <label>查询条件</label>
                    <input class="form-control" name="id" value="<%=id%>" autofocus>
                </div>

                <button type="submit" class="btn btn-primary">提交查询</button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <form onsubmit="send_json()">
                <div class="form-group">
                    <label>json查询条件</label>
                    <input id="jsoninput" class="form-control" name="id" value='{"id":"<%=escid%>"}'>
                </div>
                <button type="submit" class="btn btn-primary">JSON 方式提交查询</button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <p>第三步: 检查注入结果</p>
            <%= runQuery(rootDir + "/hibernate_conf/hibernate.cfg.xml", id, rootDir) %>
            <table class="table">
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>


</body>

