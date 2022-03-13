package com.baidu.rasp.task;

import com.baidu.rasp.service.IHello;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.concurrent.Callable;

public class JNDITask implements Callable {

    private String host;
    private int port;
    private String serviceName;

    public JNDITask(String host, int port, String serviceName) {
        this.host = host;
        this.port = port;
        this.serviceName = serviceName;
    }

    @Override
    public Object call() {
        return CallService(this.host, this.port, this.serviceName);
    }

    public static String CallService(String host, int port, String serviceName) {
        try {
            Registry registry = LocateRegistry.getRegistry(host, port);
            IHello service = (IHello) registry.lookup(serviceName);
            return service.sayHello("test");
        } catch (RemoteException e) {
            e.printStackTrace();
        } catch (NotBoundException e) {
            e.printStackTrace();
        }
        return "";
    }
}