package com.dubbo.provider.main;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

/**
 * Created by anyang on 2018/6/25.
 */
public class Provider {

    static int count=0;
    public static void main(String[] args) throws IOException {
        count++;
        System.out.println("123开始，count="+count+"，执行了--"+count+"次");
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"applicationContext-provider.xml"});
        context.start();
        System.in.read();

    }
}
