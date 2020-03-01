package com.xmlvhy.easybms.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.dao.RoleMapper;
import com.xmlvhy.easybms.system.dao.UserMapper;
import com.xmlvhy.easybms.system.entity.Role;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.service.UserService;
import com.xmlvhy.easybms.system.utils.MD5Util;
import com.xmlvhy.easybms.system.utils.RandomUtil;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.vo.RoleVo;
import com.xmlvhy.easybms.system.vo.UserVo;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName UserServiceImpl
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/04 16:22
 * @Version 1.0
 **/
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Autowired
    private RoleMapper roleMapper;

    /**
     * 功能描述: 根据登录名查询用户
     *
     * @param loginName
     * @return com.xmlvhy.easybms.system.entity.User
     * @Author 小莫
     * @Date 11:04 2019/07/17
     */
    @Override
    public User findUserByLoginName(String loginName) {
        return userMapper.queryUserByLoginName(loginName);
    }

    /**
     * 功能描述: 分页查询用户信息
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 11:18 2019/07/17
     */
    @Override
    public JsonData getAllUsersByPage(UserVo userVo) {
        BeanValidator.check(userVo);
        Page<User> page = PageHelper.startPage(userVo.getPage(), userVo.getLimit());
        /**
         * 查询用户
         */
        List<User> userList = userMapper.selectAllUsersByParams(userVo);
        if (CollectionUtils.isEmpty(userList)) {
            userList = Lists.newArrayList();
        }
        return JsonData.success(page.getTotal(), userList);
    }

    /**
     * 功能描述: 根据部门ID查询系统普通可用的用户
     *
     * @param deptId
     * @return java.util.List<com.xmlvhy.easybms.system.entity.User>
     * @Author 小莫
     * @Date 23:06 2019/07/17
     */
    @Override
    public List<User> getUserByDeptId(Integer deptId) {
        return userMapper.selectUserByDeptId(deptId, SysConstant.AVAIABLE_TYPE_ENABLE, SysConstant.SYSTEM_USER_TYPE);
    }

    /**
     * 功能描述: 保存用户
     *
     * @param userVo
     * @return void
     * @Author 小莫
     * @Date 10:16 2019/07/18
     */
    @Override
    public void addUser(UserVo userVo) {
        BeanValidator.check(userVo);
        /**
         * 1.设置默认密码
         * 2.保存随机生成的盐
         * 3.设置用户类型：超级管理员 or 系统管理员
         * 4.设置默认头像
         */
        //String salt = userVo.getName() + userVo.getAddress();
        //TODO:盐使用随机UUID
        String salt = RandomUtil.generateRandomUUID();
        userVo.setSalt(salt);
        //TODO:这里的密码使用默认123456,这里也可以根据情况，生成一个随机密码，然后发送邮件给对应用户
        userVo.setPwd(MD5Util.encodeUserPwdWithMD5(SysConstant.DEFAULT_USER_PWD, salt, SysConstant.HASHITERATIONS));
        userVo.setType(SysConstant.SYSTEM_USER_TYPE);
        userVo.setImgpath(SysConstant.DEFAULT_HEAD_IMAGE);
        int rows = userMapper.insertSelective(userVo);
        if (rows == 0) {
            throw new EasyBmsException("新增用户失败，插入数据库出错");
        }
    }

    /**
     * 功能描述: 根据用户ID查询用户
     *
     * @param id
     * @return com.xmlvhy.easybms.system.entity.User
     * @Author 小莫
     * @Date 10:51 2019/07/18
     */
    @Override
    public User getUserById(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }

    /**
     * 功能描述: 更新用户信息
     *
     * @param userVo
     * @return void
     * @Author 小莫
     * @Date 13:26 2019/07/18
     */
    @Override
    public void modifyUser(UserVo userVo) {
        BeanValidator.check(userVo);
        User user = userMapper.selectByPrimaryKey(userVo.getId());
        if (null == user) {
            throw new EasyBmsException("更新失败，用户不存在");
        }
        int rows = userMapper.updateByPrimaryKeySelective(userVo);
        if (rows == 0) {
            throw new EasyBmsException("更新失败，数据库操作出现错误");
        }
    }

    /**
     * 功能描述: 根据ID删除用户
     *
     * @param id
     * @return void
     * @Author 小莫
     * @Date 13:45 2019/07/18
     */
    @Override
    public void removeUserById(Integer id) {
        User user = userMapper.selectByPrimaryKey(id);
        Preconditions.checkNotNull(user, "删除失败，用户不存在");
        /**
         * 查询该用户是否还有下属
         */
        int count = userMapper.countUserById(id);
        if (count > 0) {
            throw new EasyBmsException("当前用户存在下属，无法删除");
        }
        int num = userMapper.deleteByPrimaryKey(id);
        if (num == 0) {
            throw new EasyBmsException("用户删除失败，数据库出现错误");
        }
    }

    /**
     * 功能描述: 批量删除用
     * todo:这里如果删除的是领导，如果下属及时没被选或选完，也会把它以及他的下属删除
     *
     * @param userVo
     * @return void
     * @Author 小莫
     * @Date 13:58 2019/07/18
     */
    @Override
    public void batchDeleteUser(UserVo userVo) {
        BeanValidator.check(userVo);

        Integer[] ids = StringUtils.stringIdsToInt(userVo.getIds());
        if (ids != null && ids.length > 0) {
            for (Integer id : ids) {
                recursiveDeleteUser(id);
            }
        }
    }

    /**
     * 功能描述: 查询所有用户
     *
     * @param
     * @return java.util.List<com.xmlvhy.easybms.system.entity.User>
     * @Author 小莫
     * @Date 16:07 2019/07/18
     */
    @Override
    public List<User> getAllUsers() {
        return userMapper.selectAllUsers();
    }

    /**
     * 功能描述: 重置密码
     *
     * @param userId
     * @return void
     * @Author 小莫
     * @Date 16:17 2019/07/18
     */
    @Override
    public void modifyUserPwd(String oldPwd, String newPwd, Integer userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        Preconditions.checkNotNull(user, "用户不存在，密码无法修改");
        if (oldPwd == null && newPwd == null) {
            //如果这两个都是null,则表示用户重置密码
            /**
             * 更新密码，这里重置的密码使用默认密码，可以根据需要改成随机密码，然后通过发邮件的方式告诉客户
             */
            String newEncoderPwd = MD5Util.encodeUserPwdWithMD5(SysConstant.DEFAULT_USER_PWD, user.getSalt(), SysConstant.HASHITERATIONS);
            int rows = userMapper.updateUserPwd(newEncoderPwd, userId);
            if (rows == 0) {
                throw new EasyBmsException("重置密码失败，数据库更新出现错误");
            }
        }
        /**
         * 用户修改密码，先校验原始密码是否正确
         */
        checkOldPwdIsExsit(oldPwd,userId);
        /**
         * 如果原始密码正确，则更新用户密码
         */
        String encoderPwd = MD5Util.encodeUserPwdWithMD5(newPwd,user.getSalt(),SysConstant.HASHITERATIONS);
        int rows = userMapper.updateUserPwd(encoderPwd, userId);
        if (rows == 0) {
            throw new EasyBmsException("密码更新出现错误");
        }
    }

    /**
     * 功能描述: 加载用户角色列表
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:20 2019/07/18
     */
    @Override
    public JsonData loadAllUserRole(UserVo userVo) {
        /**
         * 1.首先根据用户ID获取当前已经拥有的角色
         */
        List<Role> userRoles = roleMapper.selectUserRoleByUserId(userVo.getId());
        /**
         * 2.获取系统中所有的角色
         */
        RoleVo roleVo = new RoleVo();
        roleVo.setAvailable(SysConstant.AVAIABLE_TYPE_ENABLE);
        List<Role> allRoles = roleMapper.selectAllRole(roleVo);
        /**
         * 如果当前用户拥有权限，则设置当前用户所拥有的角色为选中状态，设置 LAY_CHECKED 属性：
         */
        if (CollectionUtils.isNotEmpty(userRoles)) {
            List<RoleVo> userRoleList = Lists.newArrayList();
            for (Role allRole : allRoles) {
                Boolean LAY_CHECKED = false;
                for (Role userRole : userRoles) {
                    if (allRole.getId() == userRole.getId()) {
                        LAY_CHECKED = true;
                        break;
                    }
                }
                RoleVo temp = new RoleVo();
                BeanUtils.copyProperties(allRole, temp);
                temp.setLAY_CHECKED(LAY_CHECKED);
                userRoleList.add(temp);
            }
            return JsonData.success(Long.valueOf(userRoleList.size()), userRoleList);
        } else {
            /**
             * 直接返回全部角色列表
             */
            return JsonData.success(Long.valueOf(allRoles.size()), allRoles);
        }
    }

    /**
     * 功能描述: 保存用户角色关系
     *
     * @param userVo
     * @return void
     * @Author 小莫
     * @Date 21:27 2019/07/18
     */
    @Override
    public void saveUserRole(UserVo userVo) {
        BeanValidator.check(userVo);
        User user = userMapper.selectByPrimaryKey(userVo.getId());
        Preconditions.checkNotNull(user, "用户不存在，无法分配角色");
        /**
         * 1.先删除原来的用户角色
         */
        List<Role> userRoles = roleMapper.selectUserRoleByUserId(userVo.getId());
        if (CollectionUtils.isNotEmpty(userRoles)) {
            int rows = roleMapper.deleteUserRoleByUserId(userVo.getId());
            if (rows == 0) {
                throw new EasyBmsException("删除用户角色出错");
            }
        }
        /**
         * 2.保存用户角色关系
         */
        Integer[] roleIds = StringUtils.stringIdsToInt(userVo.getIds());
        if (roleIds != null && roleIds.length > 0) {
            for (Integer roleId : roleIds) {
                int count = roleMapper.insertUserRole(roleId, userVo.getId());
                if (count == 0) {
                    throw new EasyBmsException("用户角色关系保存失败，数据库出现错误");
                }
            }
        }
    }

    /**
     * 功能描述: 校验原始密码是否存在
     *
     * @param oldPwd
     * @param userId
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 9:11 2019/07/20
     */
    @Override
    public void checkOldPwdIsExsit(String oldPwd, Integer userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        String oldDbPwd = user.getPwd();
        String oldEncoderPwd = MD5Util.encodeUserPwdWithMD5(oldPwd, user.getSalt(), SysConstant.HASHITERATIONS);
        /**
         * 如果密码相等,则原始密码输入正确
         */
        if (!oldEncoderPwd.equals(oldDbPwd)) {
            throw new EasyBmsException("原始密码错误");
        }
    }

    /**
     * 功能描述: 更新用户头像
     * @Author 小莫
     * @Date 17:29 2019/07/23
     * @param loginname
     * @param src
     * @return void
     */
    @Override
    public User modifyHeadImg(String loginname, String src) {
        User user = userMapper.selectUserByLoginName(loginname);
        Preconditions.checkNotNull(user,"当前用户非法，无法更新头像");
        if (StringUtils.isNotNull(src)) {
            user.setImgpath(src);
            int rows = userMapper.updateByPrimaryKeySelective(user);
            if (rows == 0) {
                throw new EasyBmsException("头像更新失败，数据库更新出现错误");
            }
            return user;
        }else {
            throw new EasyBmsException("更新失败,头像路径不能为空");
        }

    }

    /**
     * 功能描述: 递归删除用户
     *
     * @param id
     * @return void
     * @Author 小莫
     * @Date 14:08 2019/07/18
     */
    private void recursiveDeleteUser(Integer id) {
        //根据ID查询所有的下属
        List<User> userList = userMapper.selectUserByMgr(id);
        if (CollectionUtils.isNotEmpty(userList)) {
            for (User user : userList) {
                recursiveDeleteUser(user.getId());
            }
        }
        /**
         * 删除前判断一下该用户是否还存在
         */
        User user = userMapper.selectByPrimaryKey(id);
        if (user != null) {
            int rows = userMapper.deleteByPrimaryKey(id);
            if (rows == 0) {
                throw new EasyBmsException("用户删除失败,数据库出现错误");
            }
        }
    }
}
