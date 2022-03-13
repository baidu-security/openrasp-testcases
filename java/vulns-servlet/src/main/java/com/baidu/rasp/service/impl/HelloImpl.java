package com.baidu.rasp.service.impl;

import com.baidu.rasp.service.IHello;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class HelloImpl extends UnicastRemoteObject implements IHello {


    public HelloImpl() throws RemoteException {
    }

    @Override
    public String sayHello(String name) throws RemoteException {
        return "Hi," + name;
    }
}