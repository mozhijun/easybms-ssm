package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.Role;
import com.xmlvhy.easybms.system.service.PermissionService;
import com.xmlvhy.easybms.system.service.RoleService;
import com.xmlvhy.easybms.system.utils.TreeNode;
import com.xmlvhy.easybms.system.vo.RoleVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @ClassName RoleController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/06 16:09
 * @Version 1.0
 **/
@Controller
@RequestMapping("/role")
@Api(tags = "角色管理模块")
@Slf4j
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    /**
     * 跳转到roleManager.jsp
     */
    @RequestMapping(value = "toRoleManager.page", method = RequestMethod.GET)
    @ApiOperation(value = "角色管理页面", notes = "跳转到角色管理页面")
    public String toRoleManager() {
        return "system/role/roleManager";
    }

    /**
     * 功能描述: 加载角色列表
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @ApiOperation(value = "加载角色列表", notes = "加载角色以及子角色列表详情")
    @RequestMapping(value = "loadAllRole.json", method = RequestMethod.GET)
    @ResponseBody
    public JsonData loadAllRole(RoleVo roleVo) {
        return roleService.getAllRolesByPage(roleVo);
    }

    /**
     * 功能描述: 跳转添加角色的页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @RequestMapping(value = "toAddRole.page", method = RequestMethod.GET)
    @ApiOperation(value = "添加角色页面", notes = "跳转到添加角色页面")
    public String toAddRole() {
        return "system/role/roleAdd";
    }

    /**
     * 功能描述: 添加角色信息
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @RequestMapping(value = "addRole.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加角色信息", notes = "新增角色数据")
    public JsonData addRole(RoleVo roleVo) {
        try {
            roleService.addRole(roleVo);
            return JsonData.success("角色添加成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 回显当前要修改角色的信息
     *
     * @param id
     * @param model
     * @return java.lang.String
     * @Author 小莫
     * @Date 14:50 2019/07/09
     */
    @RequestMapping(value = "toUpdateRole.page", method = RequestMethod.GET)
    @ApiOperation(value = "修改角色信息", notes = "回显当前要修改的角色信息")
    public String toUpdateRole(@RequestParam(value = "id", required = true) Integer id, Model model) {
        //查询出当前要修改的角色信息
        Role role = roleService.getRoleById(id);
        model.addAttribute("role", role);
        return "system/role/roleUpdate";
    }

    /**
     * 功能描述: 修改角色信息
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 15:58 2019/07/09
     */
    @RequestMapping(value = "updateRole.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改角色信息", notes = "修改角色信息")
    public JsonData updateRole(RoleVo roleVo) {
        try {
            roleService.modifyRole(roleVo);
            return JsonData.success("角色更新成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 根据ID删除角色
     *
     * @param id
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:28 2019/07/09
     */
    @RequestMapping(value = "deleteRole.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除角色", notes = "根据ID修改角色信息")
    public JsonData deleteRole(@RequestParam(value = "id", required = true) Integer id) {
        try {
            roleService.removeRoleById(id);
            return JsonData.success("角色删除成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除角色
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 21:16 2019/07/09
     */
    @RequestMapping(value = "batchDeleteRole.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除角色", notes = "批量删除选中的角色")
    public JsonData batchDeleteRole(RoleVo roleVo) {
        try {
            roleService.batchDeleteRole(roleVo);
            return JsonData.success("角色删除成功");
        } catch (Exception e) {
            log.error("error: {}", e);
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 权限分配页面
     *
     * @param roleId
     * @return org.springframework.web.servlet.ModelAndView
     * @Author 小莫
     * @Date 15:17 2019/07/16
     */
    @RequestMapping(value = "toAssignPermission.page", method = RequestMethod.GET)
    @ApiOperation(value = "权限分配", notes = "给角色分配权限页面")
    public ModelAndView toAssignPermission(@RequestParam(value = "id", required = true) Integer roleId) {
        log.info("roleId: =======>{}", roleId);
        ModelAndView mav = new ModelAndView("system/role/permissionAssign");
        mav.addObject("roleId", roleId);
        //根据角色ID获取当前拥有的权限
        return mav;
    }

    /**
     * 功能描述: 加载角色权限树数据
     *
     * @param roleId
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     * @Author 小莫
     * @Date 16:27 2019/07/16
     */
    @RequestMapping(value = "loadRolePermission.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "加载角色权限树数据", notes = "分配权限中，获取角色权限树")
    public List<TreeNode> loadRolePermission(@RequestParam(value = "id", required = true) Integer roleId) {
        return permissionService.getRolePermissions(roleId);
    }

    /**
     * 功能描述: 保存角色权限关系
     *
     * @param roleVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 20:12 2019/07/16
     */
    @RequestMapping(value = "saveRolePermissions.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "保存分配的权限", notes = "保存角色和分配权限的关系")
    public JsonData saveRolePermissions(RoleVo roleVo) {
        try {
            roleService.saveRolePermissions(roleVo);
            return JsonData.success("权限分配成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }
}
