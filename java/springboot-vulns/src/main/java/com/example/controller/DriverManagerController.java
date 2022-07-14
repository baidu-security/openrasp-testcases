package com.example.controller;

import java.sql.DriverManager;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping(value = "/drivermanager")
public class DriverManagerController {
    @RequestMapping(value = "/connect")
    public void loadAppContext(@RequestParam String url) throws Exception {
        DriverManager.registerDriver(new org.postgresql.Driver());
        DriverManager.getConnection(url);
    }
}