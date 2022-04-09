package com.example.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping(value = "/object")
public class ObjectController {
    @PostMapping(value = "/parse")
    public String parseJson(@RequestBody byte[] body) throws Exception {
        InputStream is = new ByteArrayInputStream(body);
        ObjectInputStream ois = new ObjectInputStream(is);
        Object obj = ois.readObject();
        return obj.toString();
    }
}