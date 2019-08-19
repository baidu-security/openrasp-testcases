"use strict";

var cases = [
    {"name": "001 - 列目录操作 - readdirSync 方式", "path": '001-dir'},
    {"name": "002 - 任意文件读取 - readfileSync 方式", "path": '002-file-read'},
    {"name": "004 - 命令执行 - exec 方式，无回显", "path": '004-command'},
    // {"name": "004 - 命令执行 - system 方式", "path": '004-command-2'},
    // {"name": "005 - 任意文件写入 - file_put_contents 方式", "path": '005-file-write'},
    // {"name": "008 - 任意文件上传 - move_uploaded_file 方式", "path": "008-file-upload"},
    // {"name": "009 - 文件重命名 - rename 方式", "path": "009-file-rename"},
    // {"name": "010 - 任意文件包含 - include 方式", "path": "010-file-include"},
    // {"name": "012 - SSRF - cURL 方式", "path": "011-ssrf-curl"},
    // {"name": "012 - SQL 注入测试- MySQLi 方式", "path": "012-mysqli"},
    // {"name": "013 - WebShell - 回调类型后门", "path": "013-webshell-array_walk"},
    // {"name": "014 - WebShell - 中国菜刀", "path": "014-webshell-eval"},
    // {"name": "015 - WebShell - 文件上传小马", "path": "015-webshell-dropper"},
    // {"name": "016 - WebShell - 文件包含方式", "path": "016-webshell-include"},
    // {"name": "017 - XSS - 反射型XSS", "path": "017-xss"},
    // {"name": "018 - EVAL 代码执行测试", "path": "018-eval"},
    // {"name": "018 - ASSERT 代码执行测试", "path": "018-assert"},
]

module.exports = cases