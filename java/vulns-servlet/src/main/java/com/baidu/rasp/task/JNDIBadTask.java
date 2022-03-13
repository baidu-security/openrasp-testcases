package com.baidu.rasp.task;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.util.concurrent.Callable;

public class JNDIBadTask implements Callable {

    private String host;
    private int port;
    private String serviceName;

    public JNDIBadTask(String host,int port,String serviceName){
        this.host = host;
        this.port = port;
        this.serviceName = serviceName;
    }

    @Override
    public Object call() {
        return CallBadService(this.host,this.port,this.serviceName);
    }

    public static String CallBadService(String host,int port,String serviceName) {
        String uri = "rmi://"+host +":"+port +"/"+serviceName;
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