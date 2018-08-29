package com.dubbo.provider.mapper;

import com.dubbo.demo_interface.pojo.User;
import org.mybatis.spring.annotation.MapperScan;

/**
 * Created by anyang on 2018/6/25.
 */
@MapperScan
public interface UserMapper {

    public User selectById(int id);
    public User selectByName(String name);
}
