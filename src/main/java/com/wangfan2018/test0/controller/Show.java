package com.wangfan2018.test0.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/show")
public class Show{

	@RequestMapping("/")
	@ResponseBody
	String home() {
		return "Hello World!";
	}
	
	@RequestMapping("/hello")
    public String hello(Map<String,Object> map) {
        map.put("message", "hello,world");

        return "index";
    }
	
}