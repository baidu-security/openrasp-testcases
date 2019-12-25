<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.mongodb.*" %>
<%@ page import="com.mongodb.util.JSON" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.http.HttpUtils.*" %>


<%-- Declare and define the runQuery() method. --%>
<%! String runQuery(String id) {
        MongoClient mongoClient = new MongoClient("localhost" , 27017);
        MongoDatabase testDatabase = mongoClient.getDatabase("test");
        MongoCollection col = testDatabase.getCollection("col");

        String stringQuery = "{ 'id' : " + id + "}";
        String stringExclude = "{ _id:0 }";

        Document doc = Document.parse(stringQuery);
        Document result = (Document)col.find(doc).first();
        return result.toJson();
    }
    String formatResult(DBCursor rset) {
        StringBuffer sb = new StringBuffer();
        if (!rset.hasNext()) {
            sb.append("<P> No matching rows.<P>\n");
        } else {  
            do {  
                sb.append(rset.next() + "\n");
            } while (rset.hasNext());
        }
        return sb.toString();
    }
%>

<%
    String id = null;
    String content_type = request.getContentType();
    id = request.getParameter("id");
    if (id == null) {
        id = "1";
    }
    String escid = id.replaceAll("'", "&#39;");
%>

<html>
    <head>
        <meta charset="UTF-8"/>
        <title>020 - mongodb 注入测试</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    </head>
<body>

    <div class="container-fluid" style="margin-top: 50px;">
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
                <h4>mongodb注入</h4>
                <p>第一步: 请使用mongo shell执行下面的语句创建表</p>
            <pre>db.col.insert({id:1, name:"openrasp"})
db.col.insert({id:2, name:"user"})
db.col.insert({id:3, name:"jack"})
</pre>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
                <p>第二步: 尝试发起注入攻击(json注入, 例如 {'$gt':0} )</p>
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

