package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

@RestController
@RequestMapping(value = "/script")
public class ScriptEngineManagerController {
    @RequestMapping(value = "/javascript")
    public String parseJson(@RequestParam(name="expression", required=true) String expression) throws Exception {
        ScriptEngineManager manager = new ScriptEngineManager();
        ScriptEngine engine = manager.getEngineByName("JavaScript");
        return engine.eval(expression).toString();
    }
}