package com.dubbo.demo_interface.api;


/**
 * Created by anyang on 2018/6/25.
 */
public interface IUserService {

    String select() throws Exception;
    String select(String id) throws Exception;
    String select(String[] ids) throws Exception;

}
