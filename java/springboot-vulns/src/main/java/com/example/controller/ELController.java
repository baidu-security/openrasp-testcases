package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.el.ELProcessor;

@RestController
@RequestMapping(value = "/el")
public class ELController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="expression", required=true) String expression) throws Exception {
        ELProcessor elp = new ELProcessor();
        return elp.eval(expression).toString();
    }
}