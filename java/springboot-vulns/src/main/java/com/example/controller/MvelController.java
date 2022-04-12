package com.example.controller;

import org.mvel2.*;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping(value = "/mvel")
public class MvelController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="expression", required=true) String expression) throws Exception {
        Map<String, Object> context = new HashMap<String, Object>();
        context.put("user", "123");

        return MVEL.eval(expression, context).toString();
    }
}