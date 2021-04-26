package com.example.accessingdatamysql;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import javax.servlet.annotation.WebServlet;



@SpringBootApplication
public class AccessingDataMysqlApplication {

	public static void main(String[] args) {
		System.setProperty("server.servlet.context-path", "/app");
		SpringApplication.run(AccessingDataMysqlApplication.class, args);
	}
}
