package com.baidu.rasp.service;

import java.rmi.RemoteException;

public interface IHello extends java.rmi.Remote{
    String sayHello(String name) throws RemoteException;
}