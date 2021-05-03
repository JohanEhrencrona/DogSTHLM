package com.example.accessingdatamysql;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;



@ServletComponentScan
@SpringBootApplication
@RequestMapping(path="/app")
public class AccessingDataMysqlApplication {

	public static void main(String[] args) {

		SpringApplication.run(AccessingDataMysqlApplication.class, args);
	}
}
