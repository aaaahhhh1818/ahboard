package com.example.ahboard.board.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.example.ahboard.board.controller")
public class BoardServletConfig implements WebMvcConfigurer {

}
