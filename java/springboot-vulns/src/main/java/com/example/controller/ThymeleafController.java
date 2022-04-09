package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/thymeleaf")
public class ThymeleafController {

    @RequestMapping("/path")
    public String path(@RequestParam String lang) {
        return "user/" + lang + "/welcome";
    }
     
    @RequestMapping("/fragment")
    public String fragment(@RequestParam String section) {
        return "welcome :: " + section;
    }
}
