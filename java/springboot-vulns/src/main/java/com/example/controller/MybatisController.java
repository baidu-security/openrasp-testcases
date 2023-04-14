package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.models.Employee;
import com.example.models.EmployeeMapper;

@RestController
@RequestMapping(value = "/mybatis")
public class MybatisController {
    @Autowired
    private EmployeeMapper employeeMapper;

    @RequestMapping(value = "/insert2")
    public String insert(@RequestParam(name="name",  required=true) String name) throws Exception {
        int id = employeeMapper.insert2(new Employee(name));
        return "inserted id: " + id + "\n";
    }

    @RequestMapping(value = "/select")
    public String select(@RequestParam(name="name", required=true) String name) throws Exception {
        Employee employee = employeeMapper.get(name);
        if (employee == null) {
            return "user not found\n";
        }

        return employee.toString() + "\n";
    }    

    @RequestMapping(value = "/select2")
    public String select2(@RequestParam(name="name", required=true) String name) throws Exception {
        Employee employee = employeeMapper.get2(name);
        if (employee == null) {
            return "user not found\n";
        }

        return employee.toString() + "\n";
    }
}