package com.example.loremapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages={"com.example"})
public class LoremappApplication {
	public static void main(String[] args) {
		SpringApplication.run(LoremappApplication.class, args);
	}

}
