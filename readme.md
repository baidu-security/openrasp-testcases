# 说明

OpenRASP 漏洞测试环境

其中，SQL注入漏洞测试案例，需要你先在 `/sqlcase/WEB-INF/sqlcase.properties` 中配置SQL相关参数后，方可使用；若需更改jdbc driver版本，还要修改 pom.xml；详细[参考](https://github.com/baidu-security/openrasp-testcases/tree/master/java/sqlcase)。

# 目录

#### Java 应用服务器

* Struts 系列漏洞
   * S2-001
   * S2-007
   * S2-008
   * S2-012
   * S2-013
   * S2-015
   * S2-016
   * S2-029
   * S2-032
* Fastjson 反序列化漏洞
* SQL 注入漏洞
   * MySQL
   * Oracle
   * PostgreSQL
   * SQLite
   * MSSQL
* 其他常见漏洞/后门
   * 001 - 文件目录遍历
   * 002 - 任意文件下载
   * 004 - 命令执行后门
   * 005 - 文件上传后门，小马传大马的场景
   * 006 - 日志文件包含敏感信息，e.g 身份证、银行卡、CVV
   * 007 - XXE 漏洞
   * 008 - 基于 common io 上传文件
   * 009 - Transformer 反序列化
   * 010 - jstl import 任意文件包含
   * 011 - jsp include 任意文件包含

#### PHP 

即将添加



