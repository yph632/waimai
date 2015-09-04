package com.chen.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public abstract class AbstractFilter implements Filter{
	
	
	
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("过滤器初始化...");
	}

	public abstract void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException;

	public void destroy() {
		System.out.println("过滤器销毁");
	}

}
