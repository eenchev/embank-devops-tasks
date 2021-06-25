package com.example.loremapp.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
class LoremappController {
    @RequestMapping(path = "/", method= RequestMethod.GET)
    String root() {
        return "lorem";
    }
}