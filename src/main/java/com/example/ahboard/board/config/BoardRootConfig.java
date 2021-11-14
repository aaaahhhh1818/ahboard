package com.example.ahboard.board.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(basePackages = "com.example.ahboard.board.mapper")
@ComponentScan(basePackages = "com.example.ahboard.board.service")
public class BoardRootConfig{
}