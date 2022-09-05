package com.example.models;

import org.apache.ibatis.annotations.*;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
@Mapper
public interface EmployeeMapper {
	@Insert("INSERT INTO employee(name) values (#{name})")
	public int insert(Employee emp);

	@Insert("INSERT INTO employee(name) values ('${name}')")
	public int insert2(Employee emp);
	
	@Select("SELECT * FROM employee WHERE name = #{name} LIMIT 1")
	public Employee get(@Param("name") String name);

	@Select("SELECT * FROM employee WHERE name = '${name}' LIMIT 1")
	public Employee get2(@Param("name") String name);
}
