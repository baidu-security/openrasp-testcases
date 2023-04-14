package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import groovy.lang.GroovyClassLoader;
import groovy.lang.Script;
import groovy.lang.GroovyShell;
import groovy.lang.Binding;

@RestController
@RequestMapping(value = "/groovy")
public class GroovyController {
    private String run(String expression) throws Exception {
        try {
            GroovyClassLoader classLoader = new GroovyClassLoader();
            Class clazz = classLoader.parseClass(expression);
            Script script = (Script) clazz.newInstance();
            Object obj = script.run();

            classLoader.close();
            if (obj == null) {
                return "null";
            }
            
            return obj.toString();
        } catch (Exception e) {
            return e.toString();
        }
    }

    @RequestMapping(value = "/parseClass")
    public String parseClass(@RequestBody String expression) throws Exception {
        System.out.println("groovy expression to parseClass:\n" + expression);
        return this.run(expression) + "\n";
    }

    @RequestMapping(value = "/parse")
    public String parse(@RequestBody String expression) throws Exception {
        System.out.println("groovy expression to parse:\n" + expression);
        GroovyShell shell = new GroovyShell();
        Object obj = shell.parse(expression);

        if (obj == null) return "null\n";
        return obj.toString() + "\n";
    }    

    @RequestMapping(value = "/evaluate")
    public String evaluate(@RequestBody String expression) throws Exception {
        System.out.println("groovy expression to evaluate:\n" + expression);
        GroovyShell shell = new GroovyShell();
        Object obj = shell.evaluate(expression);

        if (obj == null) return "null\n";
        return obj.toString() + "\n";
    }    
}
