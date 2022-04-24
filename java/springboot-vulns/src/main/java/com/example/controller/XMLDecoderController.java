package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;

import java.beans.XMLDecoder;
import java.io.InputStream;

@RestController
@RequestMapping(value = "/xmldecoder")
public class XMLDecoderController {
    @RequestMapping(value = "/parse")
    public String parseJson(InputStream dataStream) throws Exception {
        XMLDecoder xmlDecoder = new XMLDecoder(dataStream);
        Object obj = xmlDecoder.readObject();
        xmlDecoder.close();

        return obj.toString();
    }
}