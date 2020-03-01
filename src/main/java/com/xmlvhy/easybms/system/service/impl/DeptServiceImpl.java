package com.xmlvhy.easybms.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.dao.DeptMapper;
import com.xmlvhy.easybms.system.dao.UserMapper;
import com.xmlvhy.easybms.system.entity.Dept;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.service.DeptService;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.utils.ZtreeSimpleData;
import com.xmlvhy.easybms.system.vo.DeptVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName DeptServiceImpl
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/08 13:33
 * @Version 1.0
 **/
@Service
@Slf4j
public class DeptServiceImpl implements DeptService {

    @Resource
    private DeptMapper deptMapper;

    @Resource
    private UserMapper userMapper;

    /**
     * 功能描述:
     *
     * @param deptVo
     * @return java.util.List<com.xmlvhy.easybms.system.utils.ZtreeSimpleData>
     * @Author 小莫
     * @Date 17:37 2019/07/09
     */
    @Override
    public List<ZtreeSimpleData> getDeptTreeData(DeptVo deptVo) {
        //获取所有部门信息
        List<Dept> deptList = deptMapper.selectAllDept(deptVo);
        //判空
        if (CollectionUtils.isEmpty(deptList)) {
            return Lists.newArrayList();
        }
        //转化zTree数据
        List<ZtreeSimpleData> deptTreeSimpleData = Lists.newArrayList();
        for (Dept dept : deptList) {
            deptTreeSimpleData.add(ZtreeSimpleData.adapt(dept));
        }
        return deptTreeSimpleData;
    }

    /**
     * 功能描述: 分页获取部门列表
     *
     * @param deptVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:37 2019/07/09
     */
    @Override
    public JsonData getAllDeptsByPage(DeptVo deptVo) {
        /**
         * 使用分页
         */
        Page<Dept> page = PageHelper.startPage(deptVo.getPage(), deptVo.getLimit());

        /**
         * 查询部门列表，根据ID 部门名称 地址备注信息 查询
         * 若相关属性为空，则全查询
         */
        List<Dept> deptList = deptMapper.selectAllDept(deptVo);

        if (CollectionUtils.isEmpty(deptList)) {
            deptList = Lists.newArrayList();
        }
        return JsonData.success(page.getTotal(), deptList);
    }

    /**
     * 功能描述: 添加部门信息
     *
     * @param deptVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 17:33 2019/07/08
     */
    @Override
    public void addDept(DeptVo deptVo) {
        BeanValidator.check(deptVo);
        //判断是否重名
        if (checkExist(deptVo.getPid(),deptVo.getId(),deptVo.getName())) {
            throw new EasyBmsException("添加失败，部门名称已存在");
        }
        int row = deptMapper.insert(deptVo);
        if (row != 1) {
            throw new EasyBmsException("添加失败，保存数据出错");
        }
    }

    /**
     * 功能描述: 根据Id获取当前部门信息
     *
     * @param id
     * @return com.xmlvhy.easybms.system.entity.Dept
     * @Author 小莫
     * @Date 14:18 2019/07/09
     */
    @Override
    public Dept getDeptById(Integer id) {
        return deptMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新部门信息
     */
    @Override
    public void modifyDept(DeptVo deptVo) {
        BeanValidator.check(deptVo);
        //判断是否重名
        if (checkExist(deptVo.getPid(), deptVo.getId(), deptVo.getName())) {
            throw new EasyBmsException("同一层级下存在相同名称的部门");
        }
        //查询当前需要更新的部门是否存在
        Dept dept = deptMapper.selectByPrimaryKey(deptVo.getId());
        Preconditions.checkNotNull(dept, "待更新的部门不存在");

        int rows = deptMapper.updateByPrimaryKeySelective(deptVo);
        if (rows == 0) {
            throw new EasyBmsException("更新部门出现错误");
        }
    }

    /**
     * 判断当前同级是否存在相同的部门名称
     */
    public boolean checkExist(Integer pid, Integer id, String name) {
        return deptMapper.countByNameAndParentId(pid, id, name) > 0 ? true : false;
    }

    /**
     * 根据id删除指定部门
     */
    @Override
    public void removeDeptById(Integer id) {
        //先判断部门是否存在
        Dept dept = deptMapper.selectByPrimaryKey(id);
        if (dept == null) {
            throw new EasyBmsException("当前部门信息不存在");
        }
        //判断是否有子部门，有子部门不能删除
        int ret = deptMapper.countChildDeptById(id);
        if (ret > 0) {
            throw new EasyBmsException("当前部门下有子部门");
        }

        //TODO:判断该部门下是否有员工，有员工不能删除
        int count = userMapper.countUserByDeptId(id);
        if (count > 0) {
            throw new EasyBmsException("当前部门下存在员工，不能删除");
        }

        //删除部门
        int rows = deptMapper.deleteByPrimaryKey(id);
        if (rows == 0) {
            throw new EasyBmsException("部门删除出现错误");
        }
    }

    /**
     * 功能描述: 批量删除部门
     *
     * @param deptVo
     * @return void
     * @Author 小莫
     * @Date 21:12 2019/07/09
     */
    @Override
    public void batchDeleteDept(DeptVo deptVo) {
        //1.删除父节点则默认删除该节点下所有的子节点
        BeanValidator.check(deptVo);
        //循环遍历删除每一个选中的部门以及其子部门
        Integer[] ids = StringUtils.stringIdsToInt(deptVo.getIds());

        if (ids != null && ids.length > 0) {
            for (Integer id : ids) {
                recursiveDeleteDept(id);
            }
        }
    }

    /**
     * 递归删除部门以及子部门
     */
    public void recursiveDeleteDept(Integer id) {
        //拿到所有的子部门
        List<Dept> deptList = deptMapper.selectDeptListByPid(id);
        if (CollectionUtils.isNotEmpty(deptList)) {
            for (Dept dept : deptList) {
                //递归删除子部门下的子部门....
                recursiveDeleteDept(dept.getId());
            }
        }
        //TODO: 这里应该判断当前部门是否有员工,有员工则不能删除
        int count = userMapper.countUserByDeptId(id);
        if (count > 0) {
            Dept dept = deptMapper.selectByPrimaryKey(id);
            throw new EasyBmsException("当前["+dept.getName()+"]下存在员工，不能删除");
        }
        deptMapper.deleteByPrimaryKey(id);
    }
}
