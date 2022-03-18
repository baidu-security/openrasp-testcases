package main.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Arrays;
import java.util.List;

@Controller
public class WelcomeController {

    @GetMapping("/path")
    public String path(@RequestParam String lang) {
        return "user/" + lang + "/welcome";
    }
     
    @GetMapping("/fragment")
    public String fragment(@RequestParam String section) {
        return "welcome :: " + section;
    }

}