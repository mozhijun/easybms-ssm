package com.xmlvhy.easybms.system.dao;

import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.vo.PermissionVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Permission record);

    int insertSelective(Permission record);

    Permission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Permission record);

    int updateByPrimaryKey(Permission record);

    /**
     * 传type类型，查询菜单或者权限
     * 没有传type则查询所有
     */
    List<Permission> selectAllPermission(@Param("permissionVo") PermissionVo permissionVo);

    int countMenuByPidAndName(@Param("pId") Integer pId,
                              @Param("id") Integer id,
                              @Param("name") String name);

    int countMenuByIdAndType(@Param("permissionVo") PermissionVo permissionVo);

    List<Permission> selectAllChildMenuByPid(@Param("id") Integer id,
                                             @Param("type")String type);

    List<Permission> selectPermissionsByRoleId(@Param("available") int available,
                                               @Param("roleId") Integer roleId);

    List<Permission> selectUserPermissionByUserId(@Param("permissionVo") PermissionVo permissionVo,
                                                  @Param("userId") Integer id);
}