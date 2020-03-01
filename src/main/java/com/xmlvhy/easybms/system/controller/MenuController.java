package com.xmlvhy.easybms.system.controller;

import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.service.PermissionService;
import com.xmlvhy.easybms.system.utils.TreeNode;
import com.xmlvhy.easybms.system.vo.PermissionVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName MenuController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/13 9:21
 * @Version 1.0
 **/
@RequestMapping("/menu")
@Controller
@Api(tags = "菜单管理模块")
@Slf4j
public class MenuController {

    @Autowired
    private PermissionService menuService;

    /**
     * 功能描述: 跳转到菜单管理页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 9:31 2019/07/13
     */
    @RequestMapping(value = "toMenuManager.page", method = RequestMethod.GET)
    @ApiOperation(value = "菜单管理页面", notes = "跳转到菜单管理页面")
    public String toMenuManager() {
        return "system/menu/menuManager";
    }

    /**
     * 功能描述: 跳转到菜单树
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 10:42 2019/07/13
     */
    @RequestMapping(value = "toMenuLeft.page", method = RequestMethod.GET)
    @ApiOperation(value = "菜单树页面", notes = "菜单管理中的左侧菜单树")
    public String toMenuLeft() {
        return "system/menu/menuLeft";
    }

    /**
     * 功能描述: 跳转到菜单列表
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 10:43 2019/07/13
     */
    @RequestMapping(value = "toMenuRight.page", method = RequestMethod.GET)
    @ApiOperation(value = "菜单列表", notes = "菜单管理中的右侧菜单列表")
    public String toMenuRight() {
        return "system/menu/menuRight";
    }

    /**
     * 功能描述: 加载菜单树数据，这里使用zTree标准数据类型
     *
     * @param menuVo
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     * @Author 小莫
     * @Date 11:26 2019/07/13
     */
    @RequestMapping(value = "menuTree.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "菜单树", notes = "菜单管理中，获取左侧的菜单树数据")
    public List<TreeNode> menuTree(PermissionVo menuVo) {
        try {
            menuVo.setType(SysConstant.PERMISSION_TYPE_MENU);
            List<TreeNode> menus = menuService.getMenuTree(menuVo);
            return menus;
        }catch (Exception e){
            log.error("e: {}",e);
            return Lists.newArrayList();
        }
    }

    /**
     * 功能描述: 加载菜单列表
     *
     * @param menuVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 20:37 2019/07/13
     */
    @RequestMapping(value = "loadAllMenu.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "加载菜单列表", notes = "菜单管理中，点击菜单加载对应的菜单数据")
    public JsonData loadAllMenu(PermissionVo menuVo) {
        menuVo.setType(SysConstant.PERMISSION_TYPE_MENU);
        return menuService.getAllMenuByPage(menuVo);
    }

    /**
     * 功能描述: 跳转添加菜单页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 22:20 2019/07/13
     */
    @RequestMapping(value = "toAddMenu.page", method = RequestMethod.GET)
    @ApiOperation(value = "添加菜单页面", notes = "跳转到添加菜单页面")
    public String toAddMenu() {
        return "system/menu/menuAdd";
    }

    /**
     * 功能描述: 选择图标页面
     * @Author 小莫
     * @Date 14:15 2019/07/22
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toMenuSelectIcon.page", method = RequestMethod.GET)
    @ApiOperation(value = "选择图标")
    public String toMenuSelectIcon() {
        return "system/menu/menuSelectIcon";
    }

    /**
     * 功能描述: 新增菜单，保存数据库
     *
     * @param menuVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 22:20 2019/07/13
     */
    @RequestMapping(value = "addMenu.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加菜单", notes = "新增一个菜单，保存数据库")
    public JsonData addMenu(PermissionVo menuVo) {
        try {
            /**
             * 设置菜单类型是 menu
             */
            menuVo.setType(SysConstant.PERMISSION_TYPE_MENU);
            menuService.addMenu(menuVo);
            return JsonData.success("菜单添加成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 修改菜单页面
     *
     * @param menuVo
     * @return org.springframework.web.servlet.ModelAndView
     * @Author 小莫
     * @Date 8:09 2019/07/14
     */
    @RequestMapping(value = "toUpdateMenu.page",method = RequestMethod.GET)
    @ApiOperation(value = "修改菜单页面", notes = "跳转修改菜单页面，回传当前要修改菜单初始值")
    public String toUpdateMenu(PermissionVo menuVo,Model model) {
        Permission menu = menuService.showMenu(menuVo);
        //ModelAndView mav = new ModelAndView("system/menu/menuUpdate");
        //mav.addObject("menu", menu);
        model.addAttribute("menu",menu);
        return "system/menu/menuUpdate";
    }

    /**
     * 功能描述: 修改菜单
     * @Author 小莫
     * @Date 10:55 2019/07/14
     * @param menuVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "updateMenu.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "更新菜单数据", notes = "将更新的菜单数据保存到数据库")
    public JsonData updateMenu(PermissionVo menuVo) {
        try {
            menuService.modifyMenu(menuVo);
            return JsonData.success("菜单修改成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 删除菜单
     * @Author 小莫
     * @Date 11:09 2019/07/14
     * @param menuVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "deleteMenu.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除菜单",notes = "根据ID删除菜单")
    public JsonData deleteMenu(PermissionVo menuVo){
        try {
            menuService.removeMenu(menuVo);
            return JsonData.success("菜单删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除菜单
     * @Author 小莫
     * @Date 18:55 2019/07/14
     * @param menuVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "batchDeleteMenu.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除菜单",notes = "根据选中的ID进行批量删除菜单以及子菜单，有权限点的菜单无法删除")
    public JsonData batchDeleteMenu(PermissionVo menuVo){
        try {
            menuService.batchRemoveMenus(menuVo);
            return JsonData.success("菜单删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

}
