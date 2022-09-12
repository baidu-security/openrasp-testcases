package com.example.controller;

import java.io.File;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping(value = "/file")
public class FileUploadController {
    @RequestMapping(value = "/upload")
    public String parseJson(@RequestParam("file") MultipartFile file) {
        try {
            file.transferTo(new File("/tmp/" + file.getOriginalFilename()));
            return "saved to /tmp/" + file.getOriginalFilename() + "\n";
        } catch (Exception e) {
            return e.toString();
        }		
    }
}
