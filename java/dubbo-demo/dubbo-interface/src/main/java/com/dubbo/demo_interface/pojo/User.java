package com.dubbo.demo_interface.pojo;

import java.io.Serializable;

/**
 * Created by anyang on 2018/6/25.
 */
public class User implements Serializable{
    public int id;
    public String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}
