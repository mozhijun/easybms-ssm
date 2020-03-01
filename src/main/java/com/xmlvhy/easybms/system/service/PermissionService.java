package com.xmlvhy.easybms.system.service;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.utils.TreeNode;
import com.xmlvhy.easybms.system.vo.PermissionVo;

import java.util.List;

/**
 * @Author: 小莫
 * @Date: 2019-07-06 14:07
 * @Description TODO
 */
public interface PermissionService {
    /**
     * 侧边导航栏菜单模块
     */
    List<TreeNode> getNavTreeMenus(User user, Integer rootId);
    /**
     * 菜单和权限模块：菜单树
     */
    List<TreeNode> getMenuTree(PermissionVo permissionVo);
    /**
     * 菜单模块
     */
    JsonData getAllMenuByPage(PermissionVo menuVo);
    void addMenu(PermissionVo menuVo);
    Permission showMenu(PermissionVo menuVo);
    void modifyMenu(PermissionVo menuVo);
    void removeMenu(PermissionVo menuVo);
    void batchRemoveMenus(PermissionVo menuVo);
    /**
     * 权限模块
     */
    void batchRemovePermissions(PermissionVo permissionVo);

    List<Permission> getPermissionsByRoleId(Integer roleId);

    List<TreeNode> getRolePermissions(Integer roleId);

    List<Permission> getUserPermissionsByUserId(PermissionVo permissionVo, Integer userId);
}
