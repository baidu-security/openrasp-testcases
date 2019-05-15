## 编译说明
sqlcase是maven构建，可通过 `mvn clean package` 进行编译。
## 配置说明
修改 `src/webapp/WEB-INF/sqlcase.properties` 配置数据库必要参数.以mysql为例:
```
mysqlurl=jdbc:mysql://127.0.0.1:3306
mysqldb=test
mysqluser=rasp
mysqlpassword=xxxxxx
# table名
mysqltable=person
# where clause field 名
mysqlcheckfield=last
# 展示的string字段
mysqlstringresult=first,last
# 展示的int字段
mysqlintresult=id,age
```
默认配置处理`http://localhost:8080/sqlcase/mysql?last=xxx`请求,对应执行的SQL语句为：
```
SELECT * FROM person WHERE last='xxx'
```
其中：`person`为`mysqltable`字段；`last`为`mysqlcheckfield`字段。
