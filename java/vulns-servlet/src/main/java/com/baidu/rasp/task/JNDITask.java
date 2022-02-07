package com.baidu.rasp.task;

import com.baidu.rasp.service.IHello;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.concurrent.Callable;

public class JNDITask implements Callable {

    @Override
    public Object call()  {
        return CallService();
    }

    public static String CallService() {
        try {
            Registry registry = LocateRegistry.getRegistry("localhost",1099);
            IHello service = (IHello) registry.lookup("hello");
            return service.sayHello("test");
        } catch (RemoteException e) {
            e.printStackTrace();
        } catch (NotBoundException e) {
            e.printStackTrace();
        }
        return "";
    }
}