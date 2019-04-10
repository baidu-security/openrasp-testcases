package com.dubbo.consumer;

import com.dubbo.demo_interface.api.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by anyang on 2018/6/25.
 */
@Controller
public class UserController {

    @Autowired
    private IUserService userService;

    @RequestMapping("/mysql")
    public String find(@RequestParam(value = "id", required = false) String id, HttpServletRequest request) throws Exception {
        String result = "参数错误";
        if (id != null) {
            result = userService.select(id);
        } else {
            result = userService.select();
        }
        request.setAttribute("result", result);
        return "main";
    }

    @RequestMapping("/array")
    public String find(@RequestParam(value = "params[]", required = false) String[] params, HttpServletRequest request) throws Exception {
        String result = "参数错误";
        if (params != null) {
            result = userService.select(params);
        } else {
            result = userService.select();
        }
        request.setAttribute("result", result);
        return "main";
    }

}
