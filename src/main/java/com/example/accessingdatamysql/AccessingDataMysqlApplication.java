package com.example.accessingdatamysql;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@ServletComponentScan
@SpringBootApplication
public class AccessingDataMysqlApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {

		SpringApplication.run(AccessingDataMysqlApplication.class, args);
	}
	
	@GetMapping("/hello")
	public String hello(@RequestParam(value ="name", defaultValue ="World")String name) {
		return String.format("hello %s", name);
	}
}
