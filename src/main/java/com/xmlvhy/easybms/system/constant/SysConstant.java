package com.xmlvhy.easybms.system.constant;

/**
 * @ClassName SysConstant
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/06 15:47
 * @Version 1.0
 **/
public interface SysConstant {
    /**
     * 菜单类型：menu:菜单，permission:权限点
     */
    String PERMISSION_TYPE_MENU = "menu";
    String PERMISSION_TYPE_PERMISSION = "permission";

    /**
     * 禁用状态: 1可用,0禁用
     */
    int AVAIABLE_TYPE_ENABLE = 1;
    int AVAIABLE_TYPE_DISENABLE = 0;

    /**
     * 树根节点 ID,0或者 1
     */
    int TREE_ROOT_ID_ZERO = 0;
    int TREE_ROOT_ID_ONE = 1;

    /**
     * 用户相关：0 超级管理员
     *  1 系统管理员
     */
    int SUPER_SYSTEM_USER_TYPE = 0;
    int SYSTEM_USER_TYPE = 1;
    String DEFAULT_HEAD_IMAGE = "/resources/images/head.jpg";
    String DEFAULT_USER_PWD = "123456";

    /**
     * 加密相关
     */
    int HASHITERATIONS = 2;

}
