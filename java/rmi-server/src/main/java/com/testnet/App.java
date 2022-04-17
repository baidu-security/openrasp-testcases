package com.testnet;

import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

public class App
{
    public static void StartVulnServer() throws Exception
    {
        LocateRegistry.createRegistry(1099);
        Naming.bind("MyService", new MyServiceImpl());
        System.out.println("RMI server listening on port 1099");
    }

    public static void StartVulnServer2() throws Exception
    {
        LocateRegistry.createRegistry(1099);
        Naming.bind("rmi://127.0.0.1:1099/MyService", new MyServiceImpl());
        System.out.println("RMI server listening on port 1099");
    }    

    public static void main(String[] args) throws Exception
    {
        StartVulnServer();
    }
}