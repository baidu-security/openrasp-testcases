package com.baidu.rasp.task;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;

public class DNSTask implements Callable {

    public String host;

    public DNSTask(String host) {
        this.host = host;
    }

    @Override
    public Object call() {
        return getHostNames(host);
    }

    public static String getHostNames(String host) {
        InetAddress[] addresses = new InetAddress[0];
        try {
            addresses = InetAddress.getAllByName(host);
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return "UnknownHost";
        }
        List<String> list = new ArrayList<String>();
        for (int i = 0; i < addresses.length; i++) {
            String hostname = addresses[i].getHostName();
            list.add(hostname);
        }
        return list.toString();
    }
}
