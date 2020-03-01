package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.service.PermissionService;
import com.xmlvhy.easybms.system.vo.PermissionVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName PermissionController
 * @Description TODO：左侧导航菜单
 * @Author 小莫
 * @Date 2019/07/06 14:35
 * @Version 1.0
 **/
@Controller
@RequestMapping("/permission")
@Api(tags = "权限模块")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    /**
     * 功能描述: 跳转到权限管理页面
     * @Author 小莫
     * @Date 20:10 2019/07/14
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toPermissionManager.page",method = RequestMethod.GET)
    @ApiOperation(value = "权限管理页面",notes = "跳转到权限管理页面")
    public String toPermissionPage(){
        return "system/permission/permissionManager";
    }

    /**
     * 功能描述: 加载权限管理页左侧菜单树页面
     * @Author 小莫
     * @Date 20:46 2019/07/14
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toPermissionLeft.page",method = RequestMethod.GET)
    @ApiOperation(value = "权限菜单页面",notes = "加载权限管理中左侧菜单树页面")
    public String toPermissionLeftPage(){
        return "system/permission/permissionLeft";
    }

    /**
     * 功能描述: 加载权限管理页面中右侧的权限的列表页面
     * @Author 小莫
     * @Date 20:48 2019/07/14
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toPermissionRight.page",method = RequestMethod.GET)
    @ApiOperation(value = "权限点列表",notes = "加载当前菜单下的权限点列表")
    public String toPermissionRightPage(){
        return "system/permission/permissionRight";
    }

    /**
     * 功能描述: 获取权限点列表
     * @Author 小莫
     * @Date 22:00 2019/07/14
     * @param permissionVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "loadAllPermission.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "获取权限点列表",notes = "加载菜单下的权限点列表")
    public JsonData loadAllPermission(PermissionVo permissionVo){
        permissionVo.setType(SysConstant.PERMISSION_TYPE_PERMISSION);
        return permissionService.getAllMenuByPage(permissionVo);
    }

    /**
     * 功能描述: 添加权限页面
     * @Author 小莫
     * @Date 22:43 2019/07/14
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toAddPermission.page",method = RequestMethod.GET)
    @ApiOperation(value = "添加权限页面",notes = "跳转到权限添加页面")
    public String toAddPermissionPage(){
        return "system/permission/permissionAdd";
    }

    /**
     * 功能描述: 添加权限
     * @Author 小莫
     * @Date 11:16 2019/07/15
     * @param permissionVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "addPermission.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加权限",notes = "保存权限到数据库")
    public JsonData addPermission(PermissionVo permissionVo){
        try {
            permissionVo.setType(SysConstant.PERMISSION_TYPE_PERMISSION);
            permissionService.addMenu(permissionVo);
            return JsonData.success("权限添加成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 权限修改页面
     * @Author 小莫
     * @Date 11:17 2019/07/15
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toUpdatePermission.page",method = RequestMethod.GET)
    @ApiOperation(value = "修改权限页面",notes = "跳转到权限修改页面")
    public ModelAndView toUpdatePermission(PermissionVo permissionVo){
        Permission permission = permissionService.showMenu(permissionVo);
        ModelAndView mav = new ModelAndView("system/permission/permissionUpdate");
        mav.addObject("permission",permission);
        return mav;
    }

    /**
     * 功能描述: 修改权限
     * @Author 小莫
     * @Date 11:31 2019/07/15
     * @param permissionVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "updatePermission.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改权限",notes = "更新权限数据到数据库")
    public JsonData updatePermission(PermissionVo permissionVo){
        try {
            permissionService.modifyMenu(permissionVo);
            return JsonData.success("权限修改成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 删除权限
     * @Author 小莫
     * @Date 12:05 2019/07/15
     * @param permissionVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "deletePermission.json",method = RequestMethod.POST)
    @ApiOperation(value = "删除权限",notes = "根据权限ID删除权限")
    @ResponseBody
    public JsonData deletePermission(PermissionVo permissionVo){
        try {
            permissionService.removeMenu(permissionVo);
            return JsonData.success("权限删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除权限
     * @Author 小莫
     * @Date 13:35 2019/07/15
     * @param permissionVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "batchDeletePermission.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除权限",notes = "删除选中的权限")
    public JsonData batchDeletePermission(PermissionVo permissionVo){
        try {
            permissionService.batchRemoveMenus(permissionVo);
            return JsonData.success("权限删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }
}
