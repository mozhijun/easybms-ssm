package com.xmlvhy.easybms.system.service;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.Role;
import com.xmlvhy.easybms.system.vo.RoleVo;

import java.util.List;

/**
 * @Author: 小莫
 * @Date: 2019-07-08 13:32
 * @Description TODO
 */
public interface RoleService {
    /**
     * 加载部门列表
     */
    JsonData getAllRolesByPage(RoleVo RoleVo);

    void addRole(RoleVo RoleVo);

    Role getRoleById(Integer id);

    void modifyRole(RoleVo RoleVo);

    void removeRoleById(Integer id);

    void batchDeleteRole(RoleVo RoleVo);

    void saveRolePermissions(RoleVo roleVo);

    List<Role> getUserRoleByUserId(Integer id);
}
