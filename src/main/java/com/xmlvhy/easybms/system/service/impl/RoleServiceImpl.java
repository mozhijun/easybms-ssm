package com.xmlvhy.easybms.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.dao.PermissionMapper;
import com.xmlvhy.easybms.system.dao.RoleMapper;
import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.entity.Role;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.service.RoleService;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.vo.RoleVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName RoleServiceImpl
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/08 13:33
 * @Version 1.0
 **/
@Service
@Slf4j
public class RoleServiceImpl implements RoleService {

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private PermissionMapper permissionMapper;

    /**
     * 功能描述: 分页获取角色列表
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:37 2019/07/09
     */
    @Override
    public JsonData getAllRolesByPage(RoleVo roleVo) {
        /**
         * 使用分页
         */
        Page<Role> page = PageHelper.startPage(roleVo.getPage(), roleVo.getLimit());

        /**
         * 查询角色列表，根据ID 角色名称 地址备注信息 查询
         * 若相关属性为空，则全查询
         */
        List<Role> roleList = roleMapper.selectAllRole(roleVo);

        if (CollectionUtils.isEmpty(roleList)) {
            roleList = Lists.newArrayList();
        }
        return JsonData.success(page.getTotal(), roleList);
    }

    /**
     * 功能描述: 添加角色信息
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:33 2019/07/08
     */
    @Override
    public void addRole(RoleVo roleVo) {
        BeanValidator.check(roleVo);
        //判断是否重名
        if (checkExist(roleVo.getName(), roleVo.getId())) {
            throw new EasyBmsException("角色名称已存在,无法添加");
        }
        int row = roleMapper.insert(roleVo);
        if (row != 1) {
            throw new EasyBmsException("添加失败，保存数据出错");
        }
    }

    /**
     * 功能描述: 根据Id获取当前角色信息
     *
     * @param id
     * @return com.xmlvhy.easybms.system.entity.Role
     * @Author 小莫
     * @Date 14:18 2019/07/09
     */
    @Override
    public Role getRoleById(Integer id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新角色信息
     */
    @Override
    public void modifyRole(RoleVo roleVo) {
        BeanValidator.check(roleVo);
        //判断是否重名
        if (checkExist(roleVo.getName(), roleVo.getId())) {
            throw new EasyBmsException("角色名称已存在,无法修改");
        }
        //查询当前需要更新的角色是否存在
        Role role = roleMapper.selectByPrimaryKey(roleVo.getId());
        Preconditions.checkNotNull(role, "待更新的角色不存在");

        int rows = roleMapper.updateByPrimaryKeySelective(roleVo);
        if (rows == 0) {
            throw new EasyBmsException("更新角色出现错误");
        }
    }

    /**
     * 判断当前同级是否存在相同的角色名称
     */
    public boolean checkExist(String name, Integer roleId) {
        return roleMapper.countByName(name, roleId) > 0 ? true : false;
    }

    /**
     * 根据id删除指定角色
     */
    @Override
    public void removeRoleById(Integer id) {
        //先判断角色是否存在
        Role role = roleMapper.selectByPrimaryKey(id);
        if (role == null) {
            throw new EasyBmsException("当前角色信息不存在");
        }
        //删除角色
        int rows = roleMapper.deleteByPrimaryKey(id);
        if (rows == 0) {
            throw new EasyBmsException("角色删除出现错误");
        }
    }

    /**
     * 功能描述: 批量删除角色
     *
     * @param roleVo
     * @return void
     * @Author 小莫
     * @Date 21:12 2019/07/09
     */
    @Override
    public void batchDeleteRole(RoleVo roleVo) {
        //1.删除父节点则默认删除该节点下所有的子节点
        BeanValidator.check(roleVo);
        //循环遍历删除每一个选中的角色以及其子角色
        Integer[] ids = StringUtils.stringIdsToInt(roleVo.getIds());

        if (ids != null && ids.length > 0) {
            for (Integer id : ids) {
                int rows = roleMapper.deleteByPrimaryKey(id);
                if (rows == 0) {
                    throw new EasyBmsException("删除失败，数据库出现错误");
                }
            }
        }
    }

    /**
     * 功能描述: 保存角色和权限的关系
     *
     * @param roleVo
     * @return void
     * @Author 小莫
     * @Date 20:10 2019/07/16
     */
    @Override
    public void saveRolePermissions(RoleVo roleVo) {
        BeanValidator.check(roleVo);
        /**
         *  1.先删除原来角色拥有的权限
         */
        Role role = roleMapper.selectByPrimaryKey(roleVo.getId());
        if (role == null) {
            throw new EasyBmsException("角色不存在");
        }
        /**
         *  2.可以先查询一下，这个角色是否还有权限
         *  如果有，则删除原来的权限重新进行分配
         */
        List<Permission> originPermissions = permissionMapper.selectPermissionsByRoleId(SysConstant.AVAIABLE_TYPE_ENABLE, roleVo.getId());
        if (CollectionUtils.isNotEmpty(originPermissions)) {
            int rows = roleMapper.deleteOriginPermissions(roleVo.getId());
            if (rows == 0) {
                throw new EasyBmsException("权限删除失败，数据库出现错误");
            }
        }
        //2.然后才保存新的角色权限关系
        Integer[] pIdList = StringUtils.stringIdsToInt(roleVo.getIds());
        if (pIdList != null && pIdList.length > 0) {
            for (Integer permissionId : pIdList) {
                //依次保存角色和权限的关系
                int num = roleMapper.insertRolePermissions(roleVo.getId(), permissionId);
                if (num == 0) {
                    throw new EasyBmsException("角色权限关系保存失败，数据库出现错误");
                }
            }
        }else if (originPermissions.size() > 0){
            //TODO:清空角色权限或者第一次分配权限的时候未选择任何权限直接确认
            //TODO:当然这种情况也可以由前端来判断是否选有权限
            throw new EasyBmsException("当前角色的权限已被清空");
        }else {
            throw new EasyBmsException("请先选择要分配的权限");
        }
    }

    /**
     * 功能描述: 根据用户ID获取所拥有的的角色
     * @Author 小莫
     * @Date 14:03 2019/07/19
     * @param id
     * @return java.util.List<com.xmlvhy.easybms.system.entity.Role>
     */
    @Override
    public List<Role> getUserRoleByUserId(Integer id) {
        return roleMapper.selectUserRoleByUserId(id);
    }
}
