package com.xmlvhy.easybms.system.service;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.vo.UserVo;

import java.util.List;

/**
 * @Author: 小莫
 * @Date: 2019-07-04 16:21
 * @Description TODO
 */
public interface UserService {
    /**
     * 根据登录名查询用户
     */
    User findUserByLoginName(String loginName);

    JsonData getAllUsersByPage(UserVo userVo);

    List<User> getUserByDeptId(Integer deptId);

    void addUser(UserVo userVo);

    User getUserById(Integer id);

    void modifyUser(UserVo userVo);

    void removeUserById(Integer id);

    void batchDeleteUser(UserVo userVo);

    List<User> getAllUsers();

    void modifyUserPwd(String oldPwd,String newPwd,Integer userId);

    JsonData loadAllUserRole(UserVo userVo);

    void saveUserRole(UserVo userVo);

    void checkOldPwdIsExsit(String oldPwd, Integer userId);

    User modifyHeadImg(String loginname, String src);
}
