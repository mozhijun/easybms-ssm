package com.xmlvhy.easybms.system.service;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.Dept;
import com.xmlvhy.easybms.system.utils.ZtreeSimpleData;
import com.xmlvhy.easybms.system.vo.DeptVo;

import java.util.List;

/**
 * @Author: 小莫
 * @Date: 2019-07-08 13:32
 * @Description TODO
 */
public interface DeptService {
    /**
     * 加载部门树
     */
    List<ZtreeSimpleData> getDeptTreeData(DeptVo deptVo);
    /**
     * 加载部门列表
     */
    JsonData getAllDeptsByPage(DeptVo deptVo);

    void addDept(DeptVo deptVo);

    Dept getDeptById(Integer id);

    void modifyDept(DeptVo deptVo);

    void removeDeptById(Integer id);

    void batchDeleteDept(DeptVo deptVo);
}
