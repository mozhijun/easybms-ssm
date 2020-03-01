package com.xmlvhy.easybms.system.dao;

import com.xmlvhy.easybms.system.entity.Role;
import com.xmlvhy.easybms.system.vo.RoleVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

    List<Role> selectAllRole(@Param("roleVo") RoleVo roleVo);

    int countByName(@Param("name") String name,
                    @Param("roleId") Integer roleId);

    int deleteOriginPermissions(@Param("roleId") Integer id);

    int insertRolePermissions(@Param("roleId") Integer id,
                              @Param("permissionId") Integer permissionId);

    List<Role> selectUserRoleByUserId(@Param("userId") Integer id);

    int insertUserRole(@Param("roleId") Integer roleId,
                       @Param("userId") Integer id);

    int deleteUserRoleByUserId(@Param("userId") Integer userId);
}