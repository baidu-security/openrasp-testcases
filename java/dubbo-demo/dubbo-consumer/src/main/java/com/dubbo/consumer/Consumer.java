package com.dubbo.consumer;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

/**
 * @description: 消费者
 * @author: anyang
 * @create: 2019/04/03 11:51
 */
public class Consumer {
    public static void main(String[] args) throws IOException {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
        context.start();
    }
}
