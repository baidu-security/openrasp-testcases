<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="net.sf.json.*" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>001 任意目录读取</title>
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
    data = "{\"dirname\":\"../../../../../../../../../../../../../../../var/log/\"}"
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
</script>

    <h1>001 - 使用 File.listFiles 遍历目录（有路径拼接）</h1>
<%

String dirname = null;

String content_type = request.getContentType();
if(content_type != null && content_type.indexOf("application/json") != -1){
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
                    dirname = json.getString("dirname");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
else{
    dirname = request.getParameter("dirname");
}

//echo "<script>send_json('" + $_GET['json'] + "')</script>";

String normal_querystring = "?dirname=reports";
String linux_querystring = "?dirname=../../../../../../../../../../../../../../../var/log/";
String windows_querystring = "?dirname=../../../";
String linux_json_curl = "curl -d \"{\\\"dirname\\\":\\\"../../../../../../../../../../../../../../../var/log/\\\"}\" -H \"Content-Type: application/json\" '" + request.getRequestURL() + "'";

if (dirname != null) {
    try {
        File folder;
        String serverInfo = application.getServerInfo();
        if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
            folder = new File(application.getResource("/").getPath() + "/" + dirname);
        } else {
            folder = new File(application.getRealPath("/") + "/" + dirname);
        }
        File[] listOfFiles = folder.listFiles();
        for (File file : listOfFiles) {
            if (file.isFile()) {
                out.println(file.getName());
            }
        }
    } catch (Exception e) {
        out.print(e);
    }
}
else {
%>
<p>正常调用: </p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL() + normal_querystring%></a>'</p>

<p>不正常调用 - Linux: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL() + linux_querystring%></a>'</p>

<p>不正常调用 - Linux: </p>
<p><a href=# onclick=send_json() ><%=linux_json_curl%></a></p>

<p>不正常调用 - Windows: </p>
<p>curl '<a href="<%=request.getRequestURL()+windows_querystring%>" target="_blank"><%=request.getRequestURL() + windows_querystring %></a>'</p>


<%
}
%>
</body>
</html>
