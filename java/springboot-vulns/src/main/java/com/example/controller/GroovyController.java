package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import groovy.lang.GroovyClassLoader;
import groovy.lang.Script;

@RestController
@RequestMapping(value = "/groovy")
public class GroovyController {
    @RequestMapping(value = "/parse")
    public String parse(@RequestParam(name="expression", required=true) String expression) throws Exception {
        GroovyClassLoader classLoader = new GroovyClassLoader();
        Class clazz = classLoader.parseClass(expression);
        Script script = (Script) clazz.newInstance();
        Object obj = script.run();

        classLoader.close();
        if (obj == null) {
            return "null";
        }
        
        return obj.toString();
    }
}