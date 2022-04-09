package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.apache.logging.log4j.util.PropertiesUtil;
import org.apache.logging.log4j.*;

@RestController
public class Log4jController {
    private Logger logger = LogManager.getLogger(Log4jController.class);

    @RequestMapping(value = "/log4j")
    public String testLog(@RequestParam(name="log", required=true) String input) {
        System.out.println(PropertiesUtil.class.getPackage().getImplementationVersion());

        logger.error("str={}", input);
        return input;
    }
}