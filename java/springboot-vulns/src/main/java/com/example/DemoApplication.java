package com.example;

import com.alibaba.fastjson.parser.ParserConfig;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
import de.codecentric.boot.admin.server.config.EnableAdminServer;

@SpringBootApplication
@EnableSwagger2
// @EnableAdminServer
public class DemoApplication {
	public static void main(String[] args) {
		ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
		SpringApplication.run(DemoApplication.class, args);
	}

	@Bean
	public Docket productApi() {
		return new Docket(DocumentationType.SWAGGER_2).select()
				.apis(RequestHandlerSelectors.basePackage("com.example.controller")).build();
	}
}
