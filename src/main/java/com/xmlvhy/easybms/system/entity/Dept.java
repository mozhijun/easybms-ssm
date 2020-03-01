package com.xmlvhy.easybms.system.entity;

public class Dept {
    /*部门编号*/
    private Integer id;
    /*父级部门编号*/
    private Integer pid;
    /*名称*/
    private String name;
    /*是否展开，0展开，1展开*/
    private Integer open;
    /*是否是父节点*/
    private Integer parent;
    /*备注信息*/
    private String remark;
    /*地址*/
    private String loc;
    /*状态：0不可用，1可用*/
    private Integer available;
    /*部门显示顺序*/
    private Integer ordernum;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getOpen() {
        return open;
    }

    public void setOpen(Integer open) {
        this.open = open;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getLoc() {
        return loc;
    }

    public void setLoc(String loc) {
        this.loc = loc == null ? null : loc.trim();
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }

    public Integer getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }
}