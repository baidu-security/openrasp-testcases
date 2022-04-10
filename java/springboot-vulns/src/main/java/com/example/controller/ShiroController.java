package com.example.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/shiro")
public class ShiroController {
    @RequestMapping(value = "/no-auth", method = RequestMethod.GET)
    public String noAuth() {
        return "This interface does not required authentication\n";
    }
 
    @RequestMapping(value = "/auth", method = RequestMethod.GET)
    public String auth() {
        return "You're authenticated as admin\n";
    }
}