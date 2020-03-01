package com.xmlvhy.easybms.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.dao.PermissionMapper;
import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.service.PermissionService;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.utils.TreeNode;
import com.xmlvhy.easybms.system.utils.TreeNodeBuilder;
import com.xmlvhy.easybms.system.vo.PermissionVo;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName PermissionImpl
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/06 14:08
 * @Version 1.0
 **/
@Service
public class PermissionServiceImpl implements PermissionService {

    @Resource
    private PermissionMapper permissionMapper;

    /**
     * 功能描述: 根据type查询菜单或权限树
     *
     * @param rootId 根节点ID
     * @param user   当前系统登录的用户
     * @return java.util.List<com.xmlvhy.easybms.system.entity.Permission>
     * @Author 小莫
     * @Date 14:10 2019/07/06
     */
    @Override
    public List<TreeNode> getNavTreeMenus(User user, Integer rootId) {
        /**
         * 如果是超级管理员，拥有全部菜单
         */
        List<Permission> permissions = null;
        /**
         * 构造查询条件
         */
        PermissionVo permissionVo = new PermissionVo();
        permissionVo.setAvailable(SysConstant.AVAIABLE_TYPE_ENABLE);
        permissionVo.setType(SysConstant.PERMISSION_TYPE_MENU);

        if (user.getType().equals(SysConstant.SUPER_SYSTEM_USER_TYPE)) {
            //这里先获取所有的菜单或权限
            permissions = permissionMapper.selectAllPermission(permissionVo);
        } else {
            /**
             * 普通管理员:根据ID获取拥有的菜单
             */
            permissions = permissionMapper.selectUserPermissionByUserId(permissionVo, user.getId());
        }

        if (CollectionUtils.isEmpty(permissions)) {
            return Lists.newArrayList();
        }

        List<TreeNode> treeNodeList = Lists.newArrayList();
        for (Permission p : permissions) {
            treeNodeList.add(TreeNode.adaptNavMenuTree(p));
        }
        //
        /**
         *  构造树的对象,这里只支持二级菜单
         *  这里把简单的集合对象转换为树标准json对象
         */
        //return TreeNodeBuilder.builder(treeNodeList,1);
        return TreeNodeBuilder.buildMenuTreeByMap(treeNodeList, rootId);
    }

    /**
     * 功能描述: 获取菜单管理菜单树
     *
     * @param permissionVo
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     * @Author 小莫
     * @Date 11:13 2019/07/13
     */
    @Override
    public List<TreeNode> getMenuTree(PermissionVo permissionVo) {
        BeanValidator.check(permissionVo);

        List<Permission> permissions = permissionMapper.selectAllPermission(permissionVo);

        if (CollectionUtils.isEmpty(permissions)) {
            return Lists.newArrayList();
        }

        List<TreeNode> treeNodeList = Lists.newArrayList();
        for (Permission p : permissions) {
            treeNodeList.add(TreeNode.adaptMenuTree(p));
        }
        return treeNodeList;
    }

    /**
     * 功能描述: 获取菜单或权限分页列表
     *
     * @param menuVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 20:35 2019/07/13
     */
    @Override
    public JsonData getAllMenuByPage(PermissionVo menuVo) {
        Page<Permission> page = PageHelper.startPage(menuVo.getPage(), menuVo.getLimit());

        List<Permission> permissions = permissionMapper.selectAllPermission(menuVo);

        if (CollectionUtils.isEmpty(permissions)) {
            permissions = Lists.newArrayList();
        }
        return JsonData.success(page.getTotal(), permissions);
    }

    /**
     * 功能描述: 新增菜单
     *
     * @param menuVo
     * @return void
     * @Author 小莫
     * @Date 22:18 2019/07/13
     */
    @Override
    public void addMenu(PermissionVo menuVo) {
        BeanValidator.check(menuVo);
        /**
         * 判断是否存在相同的菜单或权限名称
         */
        if (checkMenuNameExist(menuVo.getPid(), menuVo.getId(), menuVo.getName())) {
            if (menuVo.getType().equals(SysConstant.PERMISSION_TYPE_MENU)) {
                throw new EasyBmsException("当前菜单下存在相同名称的子菜单");
            } else {
                throw new EasyBmsException("当前菜单下存在相同名称的权限");
            }
        }
        int rows = permissionMapper.insertSelective(menuVo);
        if (rows == 0) {
            throw new EasyBmsException("添加失败，保存数据出现错误");
        }
    }

    /**
     * 功能描述: 根据id查询菜单或权限信息
     *
     * @param menuVo
     * @return com.xmlvhy.easybms.system.entity.Permission
     * @Author 小莫
     * @Date 8:07 2019/07/14
     */
    @Override
    public Permission showMenu(PermissionVo menuVo) {
        BeanValidator.check(menuVo);
        Preconditions.checkNotNull(menuVo, "请传入ID");
        Permission menu = permissionMapper.selectByPrimaryKey(menuVo.getId());
        /**
         * &#xe702;图标需要转码一下，要不然回显数据的时候会出现乱码
         * & 转换为 &amp;
         */
        if ((menu.getIcon() != null && !(menu.getIcon()).equals(""))) {
            menu.setIcon(menu.getIcon().replace("&", "&amp;"));
        }
        return menu;
    }

    /**
     * 功能描述: 修改菜单或权限
     *
     * @param menuVo
     * @return void
     * @Author 小莫
     * @Date 8:20 2019/07/14
     */
    @Override
    public void modifyMenu(PermissionVo menuVo) {
        BeanValidator.check(menuVo);
        Permission before = permissionMapper.selectByPrimaryKey(menuVo.getId());
        if (null == before) {
            //如果是修改权限
            if (menuVo.getType().equals(SysConstant.PERMISSION_TYPE_PERMISSION)) {
                throw new EasyBmsException("当前修改的权限不存在");
            } else {
                throw new EasyBmsException("当前修改的菜单不存在");
            }
        }
        /**
         * 判断菜单或者权限名称是否已存在
         */
        if (checkMenuNameExist(menuVo.getPid(), menuVo.getId(), menuVo.getName())) {
            //如果是修改权限
            if (menuVo.getType().equals(SysConstant.PERMISSION_TYPE_PERMISSION)) {
                throw new EasyBmsException("当前父级菜单下存在相同名称的权限");
            } else {
                throw new EasyBmsException("当前父级菜单下存在相同名称的菜单");
            }
        }
        int rows = permissionMapper.updateByPrimaryKeySelective(menuVo);
        if (rows == 0) {
            throw new EasyBmsException("修改失败，数据库更新时出错");
        }
    }

    /**
     * 功能描述: 根据ID删除菜单或权限
     * 备注：删除菜单，如果当前菜单下有子菜单或有权限点，则无法删除
     * 删除权限：可直接根据ID删除
     *
     * @param menuVo
     * @return void
     * @Author 小莫
     * @Date 11:06 2019/07/14
     */
    @Override
    public void removeMenu(PermissionVo menuVo) {
        BeanValidator.check(menuVo);
        Permission menu = permissionMapper.selectByPrimaryKey(menuVo.getId());
        if (null == menu) {
            throw new EasyBmsException("当前要删除的菜单不存在");
        }
        /**
         * 如果当前删除的是菜单，则需要判断是否有子菜单和权限点
         * 有子菜单或者菜单下有权限的无法删除
         */
        if (menu.getType().equals(SysConstant.PERMISSION_TYPE_MENU)) {
            menuVo.setType(SysConstant.PERMISSION_TYPE_MENU);
            int count = permissionMapper.countMenuByIdAndType(menuVo);
            if (count > 0) {
                throw new EasyBmsException("当前菜单下存在子菜单，无法删除");
            }
            //判断是否菜单下有权限点
            menuVo.setType(SysConstant.PERMISSION_TYPE_PERMISSION);
            int num = permissionMapper.countMenuByIdAndType(menuVo);
            if (num > 0) {
                throw new EasyBmsException("当前菜单下存在权限，无法删除");
            }
        }
        permissionMapper.deleteByPrimaryKey(menuVo.getId());
    }

    /**
     * 功能描述: 批量删除菜单或权限
     *
     * @param menuVo
     * @return void
     * @Author 小莫
     * @Date 18:52 2019/07/14
     */
    @Override
    public void batchRemoveMenus(PermissionVo menuVo) {
        BeanValidator.check(menuVo);
        if (menuVo.getIds() != null && menuVo.getIds().length > 0) {
            Integer[] menuIds = StringUtils.stringIdsToInt(menuVo.getIds());
            //递归删除选中的菜单
            for (Integer id : menuIds) {
                recursiveDeleteMenu(id);
            }
        }
    }

    /**
     * 功能描述: 批量删除权限
     *
     * @param permissionVo
     * @return void
     * @Author 小莫
     * @Date 13:42 2019/07/15
     */
    @Override
    public void batchRemovePermissions(PermissionVo permissionVo) {
        BeanValidator.check(permissionVo);
        Integer[] permissionIds = StringUtils.stringIdsToInt(permissionVo.getIds());
        if (permissionIds != null && permissionIds.length > 0) {
            for (Integer permissionId : permissionIds) {
                int rows = permissionMapper.deleteByPrimaryKey(permissionId);
                if (rows == 0) {
                    throw new EasyBmsException("权限删除失败，删除数据过程中出现错误");
                }
            }
        }
    }

    /**
     * 功能描述: 根据角色ID拿到对应的权限
     *
     * @param roleId
     * @return java.util.List<com.xmlvhy.easybms.system.entity.Permission>
     * @Author 小莫
     * @Date 15:30 2019/07/16
     */
    @Override
    public List<Permission> getPermissionsByRoleId(Integer roleId) {
        return permissionMapper.selectPermissionsByRoleId(SysConstant.AVAIABLE_TYPE_ENABLE, roleId);
    }

    /**
     * 功能描述: 获取角色权限关系
     * @Author 小莫
     * @Date 14:25 2019/07/19
     * @param roleId
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     */
    @Override
    public List<TreeNode> getRolePermissions(Integer roleId) {
        //根据角色ID拿到对应的权限
        List<Permission> rolePermissions = permissionMapper.selectPermissionsByRoleId(SysConstant.AVAIABLE_TYPE_ENABLE, roleId);

        //获取系统所有的菜单权限
        PermissionVo permissionVo = new PermissionVo();
        permissionVo.setAvailable(SysConstant.AVAIABLE_TYPE_ENABLE);
        List<Permission> allPermissions = permissionMapper.selectAllPermission(permissionVo);

        List<TreeNode> treeNodeList = Lists.newArrayList();
        for (Permission p1 : allPermissions) {
            //是否选中
            Boolean isChecked = false;
            for (Permission p2 : rolePermissions) {
                if (p1.getId() == p2.getId()) {
                    //查询到当前角色对应的权限并且设置为选中状态
                    isChecked = true;
                    break;
                }
            }
            TreeNode treeNode = TreeNode.adaptRolePermissionTree(p1);
            treeNode.setChecked(isChecked);
            treeNodeList.add(treeNode);
        }
        //构造zTree标准数据结构
        return TreeNodeBuilder.buildMenuTreeByMap(treeNodeList, SysConstant.TREE_ROOT_ID_ZERO);
        /**
         * 这里也可以直接返回，使用zTree简单数据结构，对应页面中需要设置
         * data: {
         * 		simpleData: {
         * 			enable: true
         *      }
         * }
         */
        //return treeNodeList;
    }

    /**
     * 功能描述: 根据用户ID查询出用户拥有的权限
     * @Author 小莫
     * @Date 14:25 2019/07/19
     * @param permissionVo
     * @param userId
     * @return java.util.List<com.xmlvhy.easybms.system.entity.Permission>
     */
    @Override
    public List<Permission> getUserPermissionsByUserId(PermissionVo permissionVo, Integer userId) {
        return permissionMapper.selectUserPermissionByUserId(permissionVo,userId);
    }

    /**
     * 递归删除当前选中菜单以及其子菜单
     * 当前菜单下如果存在权限点无法删除
     */
    private void recursiveDeleteMenu(Integer id) {
        /**
         * 拿到当前菜单下所有子菜单，type = menu
         */
        List<Permission> permissionList = permissionMapper.selectAllChildMenuByPid(id, SysConstant.PERMISSION_TYPE_MENU);
        if (CollectionUtils.isNotEmpty(permissionList)) {
            for (Permission p : permissionList) {
                recursiveDeleteMenu(p.getId());
            }
        }

        /**
         *  判断当前菜单下是否有权限点，有权限不可以删除
         */
        //构造一个菜单对象
        PermissionVo menuVo = new PermissionVo();
        menuVo.setId(id);
        menuVo.setType(SysConstant.PERMISSION_TYPE_PERMISSION);
        int count = permissionMapper.countMenuByIdAndType(menuVo);
        if (count > 0) {
            Permission permission = permissionMapper.selectByPrimaryKey(id);
            throw new EasyBmsException("当前选中的菜单或子菜单：[" + permission.getName() + "]下存在权限,无法删除");
        }

        /**
         * 删除菜单前，判断当前菜单是否已被删除（如果是选择父菜单的情况下会把子菜单一起删除，这样如果批量中有子菜单的ID则会出现：
         * 已经被删除的情况）
         */
        Permission menu = permissionMapper.selectByPrimaryKey(id);
        if (menu != null) {
            int rows = permissionMapper.deleteByPrimaryKey(id);
            if (rows == 0) {
                throw new EasyBmsException("菜单删除失败，数据库操作出错");
            }
        }
    }


    /**
     * 功能描述: 检查同级菜单下是否存在相同菜单名称
     *
     * @param pId  父级菜单ID
     * @param id   id
     * @param name 菜单名称
     * @return java.lang.Boolean
     * @Author 小莫
     * @Date 22:14 2019/07/13
     */
    public Boolean checkMenuNameExist(Integer pId, Integer id, String name) {
        return permissionMapper.countMenuByPidAndName(pId, id, name) > 0 ? true : false;
    }
}
