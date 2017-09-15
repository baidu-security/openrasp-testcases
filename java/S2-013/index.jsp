<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>S2-013</title>
</head>
<body>
<h2>S2-013 Demo</h2>
<p>link: <a href="https://struts.apache.org/docs/s2-013.html">https://struts.apache.org/docs/s2-013.html</a></p>

<p>Try add some parameters in URL</p>
<p><s:a id="link1" action="link" includeParams="all">"s:a" tag</s:a></p>
<p><s:url id="link2" action="link" includeParams="all">"s:url" tag</s:url></p>
</body>
</html>