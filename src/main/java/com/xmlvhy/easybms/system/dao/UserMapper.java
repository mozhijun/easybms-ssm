package com.xmlvhy.easybms.system.dao;

import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.vo.UserVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    /**
     * 根据登录名查询用户
     */
    User queryUserByLoginName(@Param("loginName") String loginName);

    int countUserByDeptId(@Param("deptId") Integer id);

    List<User> selectAllUsersByParams(@Param("userVo") UserVo userVo);

    List<User> selectUserByDeptId(@Param("deptId") Integer deptId,
                                  @Param("available") Integer available,
                                  @Param("userType") Integer userType);

    int countUserById(@Param("id") Integer id);

    List<User> selectUserByMgr(@Param("id") Integer id);

    List<User> selectAllUsers();

    int updateUserPwd(@Param("newPwd") String newPwd,
                      @Param("userId") Integer userId);

    User selectUserByLoginName(@Param("loginName") String loginname);
}