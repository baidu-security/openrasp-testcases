package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping(value = "/jackson")
public class JacksonController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="json", required=true) String json) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping();

        Object obj = objectMapper.readValue(json, Object.class);
        return obj.toString();
    }
}