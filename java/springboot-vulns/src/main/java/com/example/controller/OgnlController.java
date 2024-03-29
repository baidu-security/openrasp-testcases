package com.example.controller;

import ognl.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping(value = "/ognl")
public class OgnlController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="expression", required=true) String expression) throws Exception {
        OgnlContext context = new OgnlContext();
        context.put("user", "test");
        context.setRoot(new Object());

        Object ognl = Ognl.parseExpression(expression);
        Object value = Ognl.getValue(ognl, context, context.getRoot());
        return value.toString();
    }
}