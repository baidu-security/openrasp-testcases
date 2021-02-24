<%--
  Created by IntelliJ IDEA.
  User: litong14
  Date: 2021/1/5
  Time: 9:38 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.http.HttpUtils.*" %>

<%-- Declare and define the runQuery() method. --%>
<%! String runQuery(String id) throws SQLException {
    Connection conn = null;
    Statement stmt = null;
    ResultSet rset = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb?useSSL=false&serverTimezone=UTC", "testuser", "testpassword");
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
    String content_type = request.getContentType();
    if (content_type != null && content_type.indexOf("application/json") != -1){
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
    }
    else if (request.getHeader("X-Forwarded-For") != null) {
        id = request.getHeader("X-Forwarded-For");
    }
    else if (request.getParameter("id") != null) {
        id = request.getParameter("id");
    }
    else {
        id = "1";
    }
    String escid = id.replaceAll("'", "&#39;");
%>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>012 - SQL 注入测试 - JDBC executeQuery() 方式</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
<script>
    function GetUrlRelativePath(){
        var url = document.location.toString();
        var arrUrl = url.split("//");
        var start = arrUrl[1].indexOf("/");
        var relUrl = arrUrl[1].substring(start);
        if(relUrl.indexOf("?") != -1){
            relUrl = relUrl.split("?")[0];
        }
        return relUrl;
    }

    function getXMLHttpRequest(){
        var xmlhttp;
        if (window.XMLHttpRequest){
            xmlhttp=new XMLHttpRequest();
        }
        else{
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        return xmlhttp;
    }

    function send_json(){
        var data = document.getElementById("jsoninput").value;
        var xmlhttp=getXMLHttpRequest();
        xmlhttp.onreadystatechange=function(){
            if (xmlhttp.readyState==4 && xmlhttp.status==200){
                document.body.innerHTML = "";
                document.write(xmlhttp.responseText);
            }
        }
        url = GetUrlRelativePath()
        xmlhttp.open("POST", url, true);
        xmlhttp.setRequestHeader("Content-type","application/json;charset=UTF-8");
        xmlhttp.send(data);
    }

    function send_header(){
        var key = document.getElementById("header_key").value;
        var data = document.getElementById("header_input").value;
        var xmlhttp=getXMLHttpRequest();
        xmlhttp.onreadystatechange=function(){
            if (xmlhttp.readyState==4 && xmlhttp.status==200){
                document.body.innerHTML = ""
                document.write(xmlhttp.responseText);
            }
        }
        url = GetUrlRelativePath()
        xmlhttp.open("GET", url, true);
        xmlhttp.setRequestHeader(key, data);
        xmlhttp.send();
    }

</script>
<div class="container-fluid" style="margin-top: 50px;">
    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <h4>SQL注入 - JDBC executeQuery() 方式</h4>
            <p>第一步: 请以mysql root账号执行下面的语句创建表</p>
            <pre>DROP DATABASE IF EXISTS testdb;
CREATE DATABASE testdb;
CREATE user 'testuser'@'%' identified with mysql_native_password by 'testpassword';
grant all privileges on testdb.* to 'testuser'@'%' with grant option;
CREATE TABLE testdb.vuln (id INT, name text);
INSERT INTO testdb.vuln values (0, "openrasp");
INSERT INTO testdb.vuln values (1, "rocks");
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
            <form>
                <div class="form-group">
                    <label>JSON 方式查询</label>
                    <input id="jsoninput" class="form-control" name="id" value='{"id":"<%=escid%>"}' >
                </div>
                <button type="button" onclick="send_json()" class="btn btn-primary">JSON 方式提交查询</button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <form>
                <div class="form-group">
                    <label>header 方式查询</label><br>
                    <label>header 字段名</label>
                    <input id="header_key" class="form-control" name="key" value='X-Forwarded-For' >
                    <br>
                    <label>查询条件</label>
                    <input id="header_input" class="form-control" name="id" value='<%=id%>' >
                </div>
                <button type="button" onclick="send_header()" class="btn btn-primary">Header 方式提交查询</button>
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
