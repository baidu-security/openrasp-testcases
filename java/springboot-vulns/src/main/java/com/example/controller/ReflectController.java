package com.example.controller;

import java.lang.reflect.Method;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping(value = "/reflect")
public class ReflectController {
    @RequestMapping(value = "/construct")
    public String construct(@RequestParam(name = "class") String className, @RequestParam(name = "method") String methodName) throws Exception {
        Class clazz = Class.forName(className);
        for (Method method : clazz.getMethods())
        {
            if (method.getName().equals(methodName))
            {
                return method.toString();
            }
        }

        return clazz.toString();
    }
}