package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.Dept;
import com.xmlvhy.easybms.system.service.DeptService;
import com.xmlvhy.easybms.system.utils.ZtreeSimpleData;
import com.xmlvhy.easybms.system.vo.DeptVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ClassName DeptController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/06 16:09
 * @Version 1.0
 **/
@Controller
@RequestMapping("/dept")
@Api(tags = "部门管理模块")
@Slf4j
public class DeptController {

    @Autowired
    private DeptService deptService;

    /**
     * 跳转到deptManager.jsp
     */
    @RequestMapping(value = "toDeptManager.page", method = RequestMethod.GET)
    @ApiOperation(value = "部门管理页面", notes = "跳转到部门管理页面")
    public String toDeptManager() {
        return "system/dept/deptManager";
    }

    /**
     * 跳转部门左边树
     */
    @RequestMapping(value = "toDeptLeft.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转到部门左边树")
    public String toDeptLeft() {
        return "system/dept/deptLeft";
    }

    /**
     * 跳转部门右边列表
     */
    @RequestMapping(value = "toDeptRight.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转到部门右边列表")
    public String toDeptRight() {
        return "system/dept/deptRight";
    }

    /**
     * 功能描述: 加载部门树
     *
     * @param deptVo
     * @return java.util.List<com.xmlvhy.easybms.system.utils.ZtreeSimpleData>
     * @Author 小莫
     * @Date 17:38 2019/07/08
     */
    @ApiOperation(value = "加载部门树", notes = "加载部门列表树结构")
    @RequestMapping(value = "deptTree.json", method = RequestMethod.POST)
    @ResponseBody
    public List<ZtreeSimpleData> loadDeptTree(DeptVo deptVo) {
        return deptService.getDeptTreeData(deptVo);
    }

    /**
     * 功能描述: 加载部门列表
     *
     * @param deptVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @ApiOperation(value = "加载部门列表", notes = "加载部门以及子部门列表详情")
    @RequestMapping(value = "loadAllDept.json", method = RequestMethod.GET)
    @ResponseBody
    public JsonData loadAllDept(DeptVo deptVo) {
        return deptService.getAllDeptsByPage(deptVo);
    }

    /**
     * 功能描述: 跳转添加部门的页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @RequestMapping(value = "toAddDept.page", method = RequestMethod.GET)
    @ApiOperation(value = "添加部门页面", notes = "跳转到添加部门页面")
    public String toAddDept() {
        return "system/dept/deptAdd";
    }

    /**
     * 功能描述: 添加部门信息
     *
     * @param deptVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:39 2019/07/08
     */
    @RequestMapping(value = "addDept.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加部门信息", notes = "新增部门数据")
    public JsonData addDept(DeptVo deptVo) {
        try {
            deptService.addDept(deptVo);
            return JsonData.success("部门添加成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 回显当前要修改部门的信息
     * @Author 小莫
     * @Date 14:50 2019/07/09
     * @param id
     * @param model
     * @return java.lang.String
     */
    @RequestMapping(value = "toUpdateDept.page",method = RequestMethod.GET)
    @ApiOperation(value = "修改部门信息",notes = "回显当前要修改的部门信息")
    public String toUpdateDept(@RequestParam(value = "id",required = true) Integer id, Model model){
        //查询出当前要修改的部门信息
       Dept dept = deptService.getDeptById(id);
       model.addAttribute("dept",dept);
       return "system/dept/deptUpdate";
    }

    /**
     * 功能描述: 修改部门信息
     * @Author 小莫
     * @Date 15:58 2019/07/09
     * @param deptVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "updateDept.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改部门信息",notes = "修改部门信息")
    public JsonData updateDept(DeptVo deptVo){
        try {
            deptService.modifyDept(deptVo);
            return JsonData.success("部门更新成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 根据ID删除部门
     * @Author 小莫
     * @Date 17:28 2019/07/09
     * @param id
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "deleteDept.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除部门",notes = "根据ID修改部门信息")
    public JsonData deleteDept(@RequestParam(value = "id",required = true) Integer id){
        try {
            deptService.removeDeptById(id);
            return JsonData.success("部门删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除部门
     * @Author 小莫
     * @Date 21:16 2019/07/09
     * @param deptVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "batchDeleteDept.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除部门",notes = "批量删除选中的部门")
    public JsonData batchDeleteDept(DeptVo deptVo){
        try {
            deptService.batchDeleteDept(deptVo);
            return JsonData.success("部门删除成功");
        }catch (Exception e){
            log.error("error: {}",e);
            return JsonData.fail(e.getMessage());
        }
    }
}
