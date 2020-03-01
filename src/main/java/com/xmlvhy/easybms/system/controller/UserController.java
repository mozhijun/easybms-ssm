package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.service.DeptService;
import com.xmlvhy.easybms.system.service.UserService;
import com.xmlvhy.easybms.system.utils.PinYinUtil;
import com.xmlvhy.easybms.system.utils.ZtreeSimpleData;
import com.xmlvhy.easybms.system.vo.DeptVo;
import com.xmlvhy.easybms.system.vo.UserVo;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName UserController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/06 16:09
 * @Version 1.0
 **/
@Controller
@RequestMapping("/user")
@Api(tags = "用户管理模块")
@Slf4j
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private DeptService deptService;

    /**
     * 跳转到userManager.jsp
     */
    @RequestMapping(value = "toUserManager.page", method = RequestMethod.GET)
    @ApiOperation(value = "用户管理页面", notes = "跳转到用户管理页面")
    public String toUserManager() {
        return "system/user/userManager";
    }

    /**
     * 跳转用户左边部门树
     */
    @RequestMapping(value = "toUserLeft.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转到用户左边部门树")
    public String toUserLeft() {
        return "system/user/userLeft";
    }

    /**
     * 跳转用户右边列表
     */
    @RequestMapping(value = "toUserRight.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转到用户右边列表")
    public String toUserRight() {
        return "system/user/userRight";
    }

    /**
     * 功能描述: 加载用户树
     *
     * @param deptVo
     * @return java.util.List<com.xmlvhy.easybms.system.utils.ZtreeSimpleData>
     * @Author 小莫
     * @Date 17:38 2019/07/08
     */
    @ApiOperation(value = "加载用户部门树", notes = "加载用户列表部门树")
    @RequestMapping(value = "deptTree.json", method = RequestMethod.POST)
    @ResponseBody
    public List<ZtreeSimpleData> loadDeptTree(DeptVo deptVo) {
        return deptService.getDeptTreeData(deptVo);
    }

    /**
     * 功能描述: 加载用户列表
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @ApiOperation(value = "加载用户列表", notes = "加载用户以及子用户列表详情")
    @RequestMapping(value = "loadAllUser.json", method = RequestMethod.GET)
    @ResponseBody
    public JsonData loadAllUser(UserVo userVo) {
        return userService.getAllUsersByPage(userVo);
    }

    /**
     * 功能描述: 跳转添加用户的页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @RequestMapping(value = "toAddUser.page", method = RequestMethod.GET)
    @ApiOperation(value = "添加用户页面", notes = "跳转到添加用户页面")
    public String toAddUser() {
        return "system/user/userAdd";
    }

    @RequestMapping(value = "autoGenerateLoginName.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "获取登录名", notes = "根据用户输入的姓名自动生成对应全拼拼音作为登录名")
    public Map<String, String> autoGenerateLoginName(@RequestParam(value = "name", required = false) String name) {
        Map<String, String> ret = new HashMap<>();
        String loginName = PinYinUtil.getPinYin(name);
        ret.put("loginName", loginName);
        return ret;
    }

    @RequestMapping(value = "loadUserByDeptId.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查找部门领导", notes = "根据部门领导ID,获取该部门所有的用户")
    public List<User> loadUserByDeptId(@RequestParam(value = "deptid", required = false) Integer deptId) {
        return userService.getUserByDeptId(deptId);
    }

    /**
     * 功能描述: 添加用户信息
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @RequestMapping(value = "addUser.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加用户信息", notes = "新增用户数据")
    public JsonData addUser(UserVo userVo) {
        try {
            userService.addUser(userVo);
            return JsonData.success("用户添加成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 回显当前要修改用户的信息
     *
     * @param id
     * @param model
     * @return java.lang.String
     * @Author 小莫
     * @Date 14:50 2019/07/09
     */
    @RequestMapping(value = "toUpdateUser.page", method = RequestMethod.GET)
    @ApiOperation(value = "修改用户信息", notes = "回显当前要修改的用户信息")
    public String toUpdateUser(@RequestParam(value = "id", required = true) Integer id, Model model) {
        //查询出当前要修改的用户信息
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "system/user/userUpdate";
    }

    /**
     * 功能描述:根据mgr获取领导信息
     *
     * @param leaderId
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 11:10 2019/07/18
     */
    @RequestMapping(value = "getLeaderInfo.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "获取部门领导信息", notes = "根据领导mgr id 查询出部门领导信息")
    public JsonData getLeaderInfo(@RequestParam(value = "leaderId", required = true) Integer leaderId) {
        User leader = userService.getUserById(leaderId);
        return JsonData.success(leader);
    }

    /**
     * 功能描述: 修改用户信息
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 15:58 2019/07/09
     */
    @RequestMapping(value = "updateUser.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改用户信息", notes = "修改用户信息")
    public JsonData updateUser(UserVo userVo) {
        try {
            userService.modifyUser(userVo);
            return JsonData.success("用户更新成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 根据ID删除用户
     *
     * @param id
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:28 2019/07/09
     */
    @RequestMapping(value = "deleteUser.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除用户", notes = "根据ID修改用户信息")
    public JsonData deleteUser(@RequestParam(value = "id", required = true) Integer id) {
        try {
            userService.removeUserById(id);
            return JsonData.success("用户删除成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除用户
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 21:16 2019/07/09
     */
    @RequestMapping(value = "batchDeleteUser.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除用户", notes = "批量删除选中的用户")
    public JsonData batchDeleteUser(UserVo userVo) {
        try {
            userService.batchDeleteUser(userVo);
            return JsonData.success("用户删除成功");
        } catch (Exception e) {
            log.error("error: {}", e);
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 重置密码
     *
     * @param userId
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 16:06 2019/07/18
     */
    @RequestMapping(value = "resetUserPwd.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "重置密码", notes = "根据用户ID重置用户密码")
    public JsonData resetUserPwd(@RequestParam(value = "id", required = true) Integer userId) {
        try {
            userService.modifyUserPwd(null,null,userId);
            return JsonData.success("密码重置成功");
        } catch (Exception e) {
            return JsonData.success(e.getMessage());
        }
    }

    /**
     * 功能描述: 用户分配角色
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 16:35 2019/07/18
     */
    @RequestMapping(value = "assignUserRole.page", method = RequestMethod.GET)
    @ApiOperation(value = "用户分配角色", notes = "跳转用户角色分配页面")
    public ModelAndView assignUserRole(UserVo userVo) {
        ModelAndView mav = new ModelAndView("system/user/assignRole");
        mav.addObject("userId", userVo.getId());
        return mav;
    }

    /**
     * 功能描述: 获取用户角色列表，当前用户已拥有的角色则为选中状态
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 16:57 2019/07/18
     */
    @RequestMapping(value = "loadAllRole.json", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "用户角色列表", notes = "获取用户角色列表，当前用户已拥有的角色则为选中状态")
    public JsonData loadAllRole(UserVo userVo) {
        return userService.loadAllUserRole(userVo);
    }

    /**
     * 功能描述: 保存用户角色关系
     *
     * @param userVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 21:19 2019/07/18
     */
    @RequestMapping(value = "saveUserRole.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "保存用户角色", notes = "保存用户和角色的关系")
    public JsonData saveUserRole(UserVo userVo) {
        try {
            userService.saveUserRole(userVo);
            return JsonData.success("用户角色分配成功");
        } catch (Exception e) {
            return JsonData.success(e.getMessage());
        }
    }

    /**
     * 功能描述: 跳转用户修改密码页面
     * @Author 小莫
     * @Date 23:15 2019/07/19
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "changePwd.page",method = RequestMethod.GET)
    @ApiOperation(value = "修改密码页面",notes = "跳转用户修改密码页面")
    public String changePwd(){
        return "system/user/userModifyPwd";
    }

    /**
     * 功能描述: 跳转用户个人资料页面
     * @Author 小莫
     * @Date 23:15 2019/07/19
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "userInfo.page",method = RequestMethod.GET)
    @ApiOperation(value = "个人资料页面",notes = "跳转用户个人资料页面")
    public String userInfo(){
        return "system/user/userInfo";
    }

    /**
     * 功能描述: 校验原始密码是否正确
     * @Author 小莫
     * @Date 9:17 2019/07/20
     * @param oldPwd
     * @param userId
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "checkOldPwd.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "校验原始密码",notes = "根据旧密码和用户ID校验原密码")
    public JsonData checkOldPwd(@RequestParam(value = "oldPwd",required = true) String oldPwd,
                                @RequestParam(value = "userId",required = true) Integer userId){
        try {
            userService.checkOldPwdIsExsit(oldPwd,userId);
            return JsonData.success("原始密码正确");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 用户修改密码
     * @Author 小莫
     * @Date 11:11 2019/07/20
     * @param oldPwd
     * @param newPwd
     * @param userId
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "modifyPwd.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改密码",notes = "用户修改密码")
    public JsonData modifyPwd(@RequestParam(value = "oldPwd",required = true) String oldPwd,
                              @RequestParam(value = "newPwd",required = true) String newPwd,
                              @RequestParam(value = "userId",required = true) Integer userId){
        try {
            userService.modifyUserPwd(oldPwd,newPwd,userId);
            return JsonData.success("密码修改成功,请重新登录系统");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }
}
