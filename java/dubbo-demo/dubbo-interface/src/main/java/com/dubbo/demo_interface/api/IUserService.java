package com.dubbo.demo_interface.api;

import com.dubbo.demo_interface.pojo.User;

/**
 * Created by anyang on 2018/6/25.
 */
public interface IUserService {

    public User selectById(int id);

}
