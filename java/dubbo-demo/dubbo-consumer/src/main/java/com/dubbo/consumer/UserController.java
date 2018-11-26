package com.dubbo.consumer;

import com.dubbo.demo_interface.api.IUserService;
import com.dubbo.demo_interface.pojo.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by anyang on 2018/6/25.
 */
@Controller
public class UserController {

    @Resource
    private IUserService userService;



    @RequestMapping("/find")
    public String find(int id,HttpServletRequest request){
        System.out.println(id+"2222222222222");
        User user = userService.selectById(id);
        System.out.println(user+"--"+user.getId()+user.getUsername());
        request.setAttribute("user", user);
        return "main";
    }

}
