package com.xmlvhy.easybms.system.entity.server;

import com.xmlvhy.easybms.system.utils.Arith;

/**
 * @ClassName CpuInfo
 * @Description TODO: CPU信息
 * @Author 小莫
 * @Date 2019/07/25 13:56
 * @Version 1.0
 **/
public class CpuInfo {
    /**
     * cpu核心数
     */
    private Integer cpuNum;

    /**
     * cpu总的是用率
     */
    private Double total;

    /**
     * cpu系统使用率
     */
    private Double sys;

    /**
     * cpu用户使用率
     */
    private Double used;

    /**
     * cpu当前等待率
     */
    private Double wait;

    /**
     * cpu当前空闲率
     */
    private Double free;

    public Integer getCpuNum() {
        return cpuNum;
    }

    public void setCpuNum(Integer cpuNum) {
        this.cpuNum = cpuNum;
    }

    public Double getTotal() {
        return Arith.round(Arith.mul(total, 100), 2);
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getSys() {
        return Arith.round(Arith.mul(sys/total, 100), 2);
    }

    public void setSys(Double sys) {
        this.sys = sys;
    }

    public Double getUsed() {
        return Arith.round(Arith.mul(used/total, 100), 2);
    }

    public void setUsed(Double used) {
        this.used = used;
    }

    public Double getWait() {
        return Arith.round(Arith.mul(wait/total, 100), 2);
    }

    public void setWait(Double wait) {
        this.wait = wait;
    }

    public Double getFree() {
        return Arith.round(Arith.mul(free/total, 100), 2);
    }

    public void setFree(Double free) {
        this.free = free;
    }
}