package com.xmlvhy.easybms.system.entity.server;

import com.xmlvhy.easybms.system.utils.Arith;
import com.xmlvhy.easybms.system.utils.DateUtils;

import java.lang.management.ManagementFactory;

/**
 * @ClassName JvmInfo
 * @Description TODO: jvm 信息
 * @Author 小莫
 * @Date 2019/07/25 14:05
 * @Version 1.0
 **/
public class JvmInfo {

    /**
     * 当前jvm占用的内存总数（M）
     */
    private Double total;

    /**
     * 当前jvm可用的最大内存总数（M）
     */
    private Double max;

    /**
     * jvm空闲内存（M）
     */
    private Double free;

    /**
     * JDK版本
     */
    private String jdkVersion;

    /**
     * JDK路径
     */
    private String jdkHome;

    public Double getTotal() {
        return Arith.div(total, (1024 * 1024), 2);
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getMax() {
        return Arith.div(max, (1024 * 1024), 2);
    }

    public void setMax(Double max) {
        this.max = max;
    }

    public Double getFree() {
        return Arith.div(free, (1024 * 1024), 2);
    }

    public void setFree(Double free) {
        this.free = free;
    }

    /**
     * 当前已经使用的
     */
    public Double getUsed() {
        return Arith.div(total - free, (1024 * 1024), 2);
    }

    /**
     * 使用率
     */
    public double getUsage() {
        return Arith.mul(Arith.div(total - free, total, 4), 100);
    }

    /**
     * 获取JDK名称
     */
    public String getJDKName() {
        return ManagementFactory.getRuntimeMXBean().getVmName();
    }

    public String getJdkVersion() {
        return jdkVersion;
    }

    public void setJdkVersion(String jdkVersion) {
        this.jdkVersion = jdkVersion;
    }

    public String getJdkHome() {
        return jdkHome;
    }

    public void setJdkHome(String jdkHome) {
        this.jdkHome = jdkHome;
    }

    /**
     * JDK启动时间
     */
    public String getStartTime() {
        return DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, DateUtils.getServerStartDate());
    }

    /**
     * JDK运行时间
     */
    public String getRunTime() {
        return DateUtils.getDatePoor(DateUtils.getNowDate(), DateUtils.getServerStartDate());
    }
}
