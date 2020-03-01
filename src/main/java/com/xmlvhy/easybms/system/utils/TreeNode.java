package com.xmlvhy.easybms.system.utils;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.entity.Permission;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.List;

/**
 * @ClassName TreeNode
 * @Description TODO: 左侧导航菜单 + zTree菜单树数据封装
 * @Author 小莫
 * @Date 2019/07/06 11:47
 * @Version 1.0
 **/
@Data
public class TreeNode {
    /*编号*/
    private Integer id;
    /*父级菜单的id*/
    @JsonProperty(value = "pId")
    private Integer pid;
    /*菜单名称*/
    private String title;
    /*菜单跳转的url*/
    private String href;
    /*菜单的图标*/
    private String icon;
    /*默认是否展开，true:展开，false:不展开*/
    private Boolean spread;
    /*设置url打开的 target 属性：_blank or _self*/
    private String target;
    /*排序码*/
    private Integer ordernum;

    /**
     * zTree相关属性
     */
    /*节点名称*/
    private String name;
    /*是否默认展开*/
    private Boolean open;
    /*是否是父节点*/
    private Boolean isParent;
    /*复选框选项*/
    private Boolean checked;
    /*子菜单*/
    private List<TreeNode> children = Lists.newArrayList();

    /**
     * 功能描述: 主页面左侧导航菜单树数据适配
     * @Author 小莫
     * @Date 10:54 2019/07/13
     * @param permission
     * @return com.xmlvhy.easybms.system.utils.TreeNode
     */
    public static TreeNode adaptNavMenuTree(Permission permission){
        TreeNode treeNode = new TreeNode();
        BeanUtils.copyProperties(permission,treeNode);
        //设置title
        treeNode.setTitle(permission.getName());
        //设置是否展开，TODO:注意这里open为空的问题
        treeNode.setSpread(permission.getOpen() == 1 ? true : false);
        return treeNode;
    }

    /**
     * 功能描述: 菜单管理中左侧菜单树数据适配
     * @Author 小莫
     * @Date 11:06 2019/07/13
     * @param permission
     * @return com.xmlvhy.easybms.system.utils.TreeNode
     */
    public static TreeNode adaptMenuTree(Permission permission){
        TreeNode treeNode = new TreeNode();
        BeanUtils.copyProperties(permission,treeNode);
        treeNode.setIsParent(permission.getParent() == 1 ? true : false);
        treeNode.setOpen(permission.getOpen() == 1 ? true : false);
        //这里需要将icon为null,使用默认zTree的icon+
        treeNode.setIcon(null);
        return treeNode;
    }

    /**
     * 功能描述: zTree: 角色权限树数据适配
     * @Author 小莫
     * @Date 16:13 2019/07/16
     * @param permission
     * @return com.xmlvhy.easybms.system.utils.TreeNode
     */
    public static TreeNode adaptRolePermissionTree(Permission permission){
        TreeNode treeNode = new TreeNode();
        BeanUtils.copyProperties(permission,treeNode);
        treeNode.setOpen(permission.getOpen() == 1 ? true : false);
        //这里需要将icon为null,使用默认zTree的icon，如果不设置会出现：zTree展示时候没有图标
        treeNode.setIcon(null);
        //TODO:分配权限时候,菜单都需要设置为是父节点，这样才能把子菜单下的所有权限也展示出来
        treeNode.setIsParent(permission.getType().equals(SysConstant.PERMISSION_TYPE_MENU) ? true : false);
        return treeNode;
    }
}
