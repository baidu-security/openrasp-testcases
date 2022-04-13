package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jodd.json.JsonParser;

@RestController
@RequestMapping(value = "/jodd")
public class JoddController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="json", required=true) String json, @RequestParam(name="type", required=true) String typeName) throws Exception {
        Class clazz = Class.forName(typeName);
        JsonParser jsonParser = new JsonParser();
        Object obj = jsonParser.parse(json, clazz);
        return obj.toString();
    }

    @RequestMapping(value = "/parse2")
    public String parseJson2(@RequestParam(name="json", required=true) String json, @RequestParam(name="type", required=true) String typeName) throws Exception {
        JsonParser jsonParser = new JsonParser();
        Object obj = jsonParser.setClassMetadataName(typeName).parse(json);
        return obj.toString();
    }    
}