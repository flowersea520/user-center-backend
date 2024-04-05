package com.lxc.usercenter.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
				.allowedOrigins("http://39.101.78.159", "http://localhost:8000") // 允许这些源访问
				.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 允许的方法
				.allowedHeaders("*") // 允许的头部
				.allowCredentials(true); // 是否允许携带凭证
	}
}