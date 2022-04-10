package com.example.controller;

import com.thoughtworks.xstream.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping(value = "/xstream")
public class XStreamController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestBody String body) throws Exception {
        XStream xstream = new XStream();
        Object obj = xstream.fromXML(body);
        return obj.toString();
    }
}