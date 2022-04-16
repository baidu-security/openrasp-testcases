package com.example.controller;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import freemarker.cache.*;
import freemarker.core.*;
import freemarker.template.*;

@RestController
@RequestMapping(value = "/freemarker")
public class FreeMarkerController {
    private String run(String template, String username, Boolean hardened) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>() {{
            put("username", username);
        }};

        StringTemplateLoader tempLoader = new StringTemplateLoader();
        tempLoader.putTemplate("test", template);

        Configuration cfg = new Configuration(Configuration.VERSION_2_3_31);
        if (hardened)
            cfg.setNewBuiltinClassResolver(TemplateClassResolver.SAFER_RESOLVER);
        cfg.setTemplateLoader(tempLoader);

        Template tmpl = cfg.getTemplate("test");
        StringWriter writer = new StringWriter();
        tmpl.process(data, writer);

        return writer.toString();
    }

    @RequestMapping(value = "/unsafe")
    public String parse_unsfe(@RequestParam(name="template", required=true) String template) throws Exception {
        return run(template, "test", false);
    }

    @RequestMapping(value = "/eval")
    public String parse_eval(@RequestParam(name="username", required=true) String username) throws Exception {
        return run("<#assign m=username?eval>", username, false);
    }    

    @RequestMapping(value = "/safe")
    public String parse_safe(@RequestParam(name="template", required=true) String template) throws Exception {
        return run(template, "test", true);
    }
}