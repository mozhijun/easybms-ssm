package com.xmlvhy.easybms.system.entity;

public class Permission {
    /*权限编号*/
    private Integer id;
    /*父级编号*/
    private Integer pid;
    /*权限类型：menu,菜单 permission:按钮 */
    private String type;
    /*是否是父节点，对应zTree中isParent*/
    private Integer parent;
    /*权限编码，只有type=permission才有，user:view*/
    private String percode;
    /*名称*/
    private String name;
    /*图标*/
    private String icon;
    /*跳转的url*/
    private String href;
    /*url打开的方式，target: _blank or _self*/
    private String target;
    /*是否展开，0不展开，1展开，同spread属性*/
    private Integer open;
    /*排序码*/
    private Integer ordernum;
    /*状态：0不可用，1可用*/
    private Integer available;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public String getPercode() {
        return percode;
    }

    public void setPercode(String percode) {
        this.percode = percode == null ? null : percode.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href == null ? null : href.trim();
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target == null ? null : target.trim();
    }

    public Integer getOpen() {
        return open;
    }

    public void setOpen(Integer open) {
        this.open = open;
    }

    public Integer getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(Integer ordernum) {
        this.ordernum = ordernum;
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }
}