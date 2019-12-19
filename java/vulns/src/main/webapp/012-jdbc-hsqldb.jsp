<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.http.HttpUtils.*" %>
<%@ page import="java.sql.*" %>

<%-- Declare and define the runQuery() method. --%>
<%! String runQuery(String id, Connection conn) throws SQLException {
    Statement stmt = null;
    ResultSet rset = null;
    try {
        Class.forName("org.hsqldb.jdbcDriver");
        conn = DriverManager.getConnection("jdbc:hsqldb:mem:user");
        stmt = conn.createStatement();
        rset = stmt.executeQuery("SELECT * FROM user WHERE id = " + id);
        return (formatResult(rset));
    } catch (Exception e) {
        return ("<P> Error: <PRE> " + e + " </PRE> </P>\n");
    } finally {
        if (rset != null) rset.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
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

    public void jspInit() {
        try {
            Connection conn = null;
            Class.forName("org.hsqldb.jdbcDriver");
            Statement stmt = null;
            conn = DriverManager.getConnection("jdbc:hsqldb:mem:user");
            stmt = conn.createStatement();
            stmt.execute("CREATE TABLE user (\n" +
                    "         id INTEGER NOT NULL PRIMARY KEY,\n" +
                    "         name VARCHAR(20),\n" +
                    " )");
            stmt.execute("INSERT INTO user (id,name) VALUES (1,'user1')");
            stmt.execute("INSERT INTO user (id,name) VALUES (2,'user2')");
            stmt.execute("INSERT INTO user (id,name) VALUES (3,'user3')");
            stmt.execute("INSERT INTO user (id,name) VALUES (4,'user4')");
        } catch (Exception e) {

        }
    }
%>

<%
    String id = null;
    String content_type = request.getContentType();
    Connection conn = null;
    Statement stmt = null;
    conn = DriverManager.getConnection("jdbc:hsqldb:mem:user");
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
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
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
        </div>
    </div>

    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <p>第一步: 尝试发起SQL注入攻击 - 为了保证性能，默认只会检测长度超过15的语句</p>
            <form action="<%= javax.servlet.http.HttpUtils.getRequestURL(request) %>" method="get">
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
            <p>第二步: 检查注入结果</p>
            <%= runQuery(id, conn) %>
            <table class="table">
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>


</body>



