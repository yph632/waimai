package com.chen.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.filter.OncePerRequestFilter;

import com.chen.util.Const;

public class BusinessFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest req,
			HttpServletResponse resp, FilterChain filterChain)
			throws ServletException, IOException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		if(request.getRequestURI().startsWith("/shangjia/manage")){
			HttpSession session = request.getSession();
			if(session.getAttribute(Const.BUSINESS_IN_SESSION) != null){
				filterChain.doFilter(req, resp);
				return;
			}else{
				System.out.println("Î´µÇÂ¼£¬½øÈëµÇÂ½Ò³Ãæ");
				response.sendRedirect("/shangjia/login");
				return;
			}
				
		}
		
	}

	

	
	
}
