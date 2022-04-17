package com.testnet;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class MyServiceImpl extends UnicastRemoteObject  implements MyService  {

	public MyServiceImpl() throws RemoteException {}
	
	public boolean registerTicket(String ticketID) throws RemoteException {
		System.out.println("registerTicket called: " + ticketID);
		return false;
	}

	public void vistTalk(String talkname) throws RemoteException {
		System.out.println("visitTalk called: " + talkname);
	}

	public void poke(Object attende) throws RemoteException {
		System.out.println("poking " + attende.toString());
	}
}