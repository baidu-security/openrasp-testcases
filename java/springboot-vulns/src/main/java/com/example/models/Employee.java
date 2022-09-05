package com.example.models;

import java.io.Serializable;

public class Employee implements Serializable {
    private int id;
    private String name;

    public Employee(String name) {
        this.name = name;
    }

    public Employee(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public String toString() {
        return "Employee[name=" + this.name + "; id=" + this.id + "]";
    }
}
