package com.example;

import com.alibaba.fastjson.parser.ParserConfig;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {
	public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
		SpringApplication.run(DemoApplication.class, args);
	}
}
