package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.naming.*;

@RestController
@RequestMapping(value = "/jndi")
public class JndiController {
    @RequestMapping(value = "/lookup")
    public String lookup(@RequestParam(name="url", required=true) String url) throws Exception {
        Context ctx = new InitialContext();
        Object object = ctx.lookup(url);
        return url;
    }
}