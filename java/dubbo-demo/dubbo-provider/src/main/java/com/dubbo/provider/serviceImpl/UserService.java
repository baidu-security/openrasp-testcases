package com.dubbo.provider.serviceImpl;


import com.dubbo.demo_interface.api.IUserService;
import com.dubbo.demo_interface.pojo.User;
import com.dubbo.provider.mapper.UserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by anyang on 2018/6/25.
 */
@Service
public class UserService implements IUserService {

    @Resource
    private UserMapper userDao;

    public User selectById(int id) {

        return userDao.selectById(id);
    }
}
