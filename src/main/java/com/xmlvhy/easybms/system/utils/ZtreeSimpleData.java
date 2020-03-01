package com.xmlvhy.easybms.system.utils;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.xmlvhy.easybms.system.entity.Dept;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName ZtreeSimpleData
 * @Description TODO:封装zTree简单数据类型
 * @Author 小莫
 * @Date 2019/07/08 13:18
 * @Version 1.0
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ZtreeSimpleData {
    /**
     * 节点ID
     */
    private Integer id;
    /**
     * 父节点
     */
    @JsonProperty("pId")
    private Integer pid;
    /**
     * 节点名称
     */
    private String name;
    /**
     * 是否是父节点
     */
    private Boolean isParent;
    /**
     * 是否默认展开
     */
    private Boolean open;

    /**
     * 是否可选
     */
    private Boolean chkDisabled;

    /**
     * 转换对象
     */
    public static ZtreeSimpleData adapt(Dept dept){
        ZtreeSimpleData data = ZtreeSimpleData.builder().id(dept.getId())
                //父节点id，这里适配zTree，需要将属性修改为 pId
                .pid(dept.getPid())
                //节点名称
                .name(dept.getName())
                //是否默认展开，zTree 字段是open
                .open(dept.getOpen() == 1 ? true : false)
                //是否作为父节点，父节点和子节点样式不一样
                .isParent(dept.getParent() == 1 ? true : false)
                //是否可选，如果禁用的节点就不可选
                .chkDisabled(dept.getAvailable() == 1 ? true : false)
                .build();
        return data;
    }
}
