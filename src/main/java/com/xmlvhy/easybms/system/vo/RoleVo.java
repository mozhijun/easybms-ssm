package com.xmlvhy.easybms.system.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.xmlvhy.easybms.system.entity.Role;
import lombok.Data;

/**
 * @ClassName DeptVo
 * @Description
 * @Author 小莫
 * @Date 2019/07/08 11:27
 * @Version 1.0
 **/
@Data
public class RoleVo extends Role {

    /**
     * 1.角色id组成的数组，用于批量删除
     * 2.权限分配中：选中的权限ID集合，用于保存角色和权限的关系
     */
    private String[] ids;

    /**
     * 当前页码，匹配layui数据表格
     */
    private Integer page;

    /**
     * 每页的数据大小，匹配layui 数据表格
     */
    private Integer limit;

    /**
     * TODO: LAY_CHECKED
     * layui form 表单项是否为默认选中，这里默认false
     * 属性名称一定是全大写，这里注意：如果不指定LAY_CHECKED属性，json返回的时候
     * 属性 LAY_CHECKED 会变为 lay_CHECKED，不符合layui 要求
     */
    @JsonProperty(value = "LAY_CHECKED")
    private Boolean LAY_CHECKED = false;
}
