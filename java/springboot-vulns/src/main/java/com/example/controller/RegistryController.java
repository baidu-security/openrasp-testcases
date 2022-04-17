package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

@RestController
@RequestMapping(value = "/registry")
public class RegistryController {
    @RequestMapping(value = "/lookup")
    public String lookup(@RequestParam(name="ip", required=true) String ip, @RequestParam(name="port", required=true) int port, @RequestParam(name="name", required=true) String name) throws Exception {
        Registry registry = LocateRegistry.getRegistry(ip, port);
        registry.lookup(name);

        return registry.list().toString();
    }
}