package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.yaml.snakeyaml.Yaml;

@RestController
@RequestMapping(value = "/snakeyaml")
public class SnakeYAMLController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name = "yaml", required = true) String data) {
        Yaml yaml = new Yaml();
        Object obj = yaml.load(data);
        return obj.toString();
    }
}