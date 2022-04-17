package com.testnet;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface MyService extends Remote {
   boolean registerTicket(String ticketID) throws RemoteException;
   void vistTalk(String talkname) throws RemoteException;
   void poke(Object attende) throws RemoteException;
}