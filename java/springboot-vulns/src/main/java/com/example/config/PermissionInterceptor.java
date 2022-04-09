package com.example.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class PermissionInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response,
            Object handler) throws Exception {
        String uri = request.getRequestURI();
        uri = uri.replaceAll("//", "/");

        System.out.println("PermissionInterceptor::preHandle RequestURI: " + uri);
        if (uri.contains("..") || uri.contains("./")) {
            return false;
        }
        if (uri.startsWith("/admin/no-auth")) {
            return true;
        }

        response.getWriter().println("Access is denied");
        return false;
    }
}