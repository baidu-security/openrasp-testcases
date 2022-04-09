package com.example.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Arrays;
import java.util.List;

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
