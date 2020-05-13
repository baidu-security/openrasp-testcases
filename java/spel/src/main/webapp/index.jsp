<%@ page import="java.io.*" %>
<%@ page import="org.springframework.expression.Expression" %>
<%@ page import="org.springframework.web.util.HtmlUtils" %>
<%@ page import="org.springframework.expression.spel.standard.SpelExpressionParser" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
String spel   = request.getParameter("spel");
String result = "";

if (spel != null)
{
  try
  {
    SpelExpressionParser parser = new SpelExpressionParser();
    Expression expression = parser.parseExpression(spel);
    result = expression.getValue().toString();
  }
  catch (Exception e)
  {
    result = e.toString();
  }
}
else
{
  spel = "";
}
%>

<html>
  <head>
    <title>SPEL 执行</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
  </head>

  <body>
    <div class="container" style="margin-top: 60px ">
      <div class="row">
        <div class="col">
          <form method="post">
            <div class="input-group">
              <input type="text" name="spel" class="form-control" id="spel" value="<%= HtmlUtils.htmlEscape(spel) %>">
              <div class="input-group-btn">
                <button type="submit" class="btn btn-primary">提交</button>                
              </div>       
            </div>
           </form>
        </div>
      </div>

      <div class="row">
        <div class="col">
          <pre style="white-space: inherit;"><%= result %></pre>
        </div>
      </div>
    </div>

    <script type="text/javascript">
      document.getElementById("spel").addEventListener("keyup", (event) => {
        if (event.keyCode === 13) {
          document.forms[0].submit()
        }
      });
    </script>
  </body>
</html>