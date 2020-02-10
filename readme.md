# 说明

OpenRASP 漏洞测试环境

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
* Jackson databind 反序列化漏洞
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
   * 011 - SSRF 漏洞
   * 012 - JDBC MySQL 注入测试，表单形式
* 微信 XXE 漏洞   

#### PHP 

* 常见漏洞
   * 001 - 文件目录列出
   * 002 - 任意文件下载
   * 004 - 命令执行漏洞，有回显/无回显
   * 005 - 任意文件写入 - file_put_contents 方式
   * 008 - 基于 move_upload_file 上传文件
   * 010 - include 方式任意文件包含
   * 011 - SSRF 漏洞 - cURL 方式
   * 012 - SQL注入 - mysqli 方式
   * 013 - WebShell - 回调类型后门
   * 014 - WebShell - 中国菜刀
   * 015 - WebShell - 小马上传后门
   * 016 - WebShell - 文件包含方式




