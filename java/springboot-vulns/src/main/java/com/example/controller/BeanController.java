package com.example.controller;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping(value = "/bean")
public class BeanController {
    @RequestMapping(value = "/app")
    public String loadAppContext(@RequestParam String path) {
        ClassPathXmlApplicationContext appContext = new ClassPathXmlApplicationContext(path);
        appContext.close();
        return path;
    }

    @RequestMapping(value = "/file")
    public String loadFileContext(@RequestParam String path) {
        FileSystemXmlApplicationContext appContext = new FileSystemXmlApplicationContext(path);
        appContext.close();
        return path;
    }
}