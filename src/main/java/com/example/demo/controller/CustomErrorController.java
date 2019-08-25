package com.example.demo.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jline.internal.Log;

@Controller
public class CustomErrorController implements ErrorController{
	private final String PATH = "/error";    
    
    @RequestMapping(value = PATH)
    public String error(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        String statusCode = String.valueOf(status);
        
        if (statusCode.equalsIgnoreCase(HttpStatus.INTERNAL_SERVER_ERROR.toString().split(" ")[0])) {        	
            return "error/5xx";
        }
        
       return "error/error";
    }

    @Override
    public String getErrorPath() {
        return PATH;
    }
}
