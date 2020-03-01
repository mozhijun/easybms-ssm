package com.xmlvhy.easybms.system.dao;

import com.xmlvhy.easybms.system.entity.Dept;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeptMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Dept record);

    int insertSelective(Dept record);

    Dept selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Dept record);

    int updateByPrimaryKey(Dept record);

    List<Dept> selectAllDept(@Param("dept") Dept dept);

    int countChildDeptById(@Param("id") Integer id);

    int countByNameAndParentId(@Param("pid") Integer pid,
                               @Param("id") Integer id,
                               @Param("name") String name);

    List<Dept> selectDeptListByPid(@Param("id") Integer id);

}