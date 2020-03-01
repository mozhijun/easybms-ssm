package com.xmlvhy.easybms.system.entity;

public class Role {
    /*角色编号*/
    private Integer id;
    /*角色名称*/
    private String name;
    /*备注*/
    private String remark;
    /*是否可用：0不可用，1可用*/
    private Integer available;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }
}