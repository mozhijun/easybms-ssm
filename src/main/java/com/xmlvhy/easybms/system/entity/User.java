package com.xmlvhy.easybms.system.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    /*用户编号*/
    private Integer id;
    /*用户名*/
    private String name;
    /*登录名*/
    private String loginname;
    /*地址*/
    private String address;
    /*用户性别*/
    private Integer sex;
    /*备注信息*/
    private String remark;
    /*登录密码*/
    private String pwd;
    /*部门编号*/
    private Integer deptid;

    /*入职时间*/
    @DateTimeFormat(pattern = "yyyy-MM-dd") //接收前端提交的数据格式化
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8") //响应给前端的数据格式化
    private Date hiredate;

    /*上级领导ID，工作流汇总需要使用*/
    private Integer mgr;
    /*状态：0，不可用 1，可用*/
    private Integer available;
    /*排序吗，可以调换菜单顺序*/
    private Integer ordernum;
    /*用户类型*/
    private Integer type;
    /*用户头像*/
    private String imgpath;
    /*加密密码使用的盐*/
    private String salt;
    /**
     * 添加额外属性
     */
    private String deptname;
    private String leadername;

    public String getDeptname() {
        return deptname;
    }

    public void setDeptname(String deptname) {
        this.deptname = deptname;
    }

    public String getLeadername() {
        return leadername;
    }

    public void setLeadername(String leadername) {
        this.leadername = leadername;
    }
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

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname == null ? null : loginname.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd == null ? null : pwd.trim();
    }

    public Integer getDeptid() {
        return deptid;
    }

    public void setDeptid(Integer deptid) {
        this.deptid = deptid;
    }

    public Date getHiredate() {
        return hiredate;
    }

    public void setHiredate(Date hiredate) {
        this.hiredate = hiredate;
    }

    public Integer getMgr() {
        return mgr;
    }

    public void setMgr(Integer mgr) {
        this.mgr = mgr;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getImgpath() {
        return imgpath;
    }

    public void setImgpath(String imgpath) {
        this.imgpath = imgpath == null ? null : imgpath.trim();
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }
}