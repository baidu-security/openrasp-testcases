package com.baidu.rasp.task;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.util.concurrent.Callable;

public class JNDIBadTask implements Callable {

    @Override
    public Object call() {
        return CallBadService();
    }

    public static String CallBadService() {
        String uri = "rmi://127.0.0.1:1098/hello";
        Context ctx = null;
        try {
            ctx = new InitialContext();
            ctx.lookup(uri);
            return "调用成功";
        } catch (NamingException e) {
            e.printStackTrace();
        }
        return "调用失败";
    }
}