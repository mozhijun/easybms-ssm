package com.xmlvhy.easybms.system.entity.server;

/**
 * @ClassName DiskInfo
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/25 14:25
 * @Version 1.0
 **/
public class DiskInfo {
    /**
     * 盘符路径
     */
    private String diskName;

    /**
     * 盘符类型
     */
    private String diskTypeName;
    /**
     * 文件类型
     */
    private String diskFileTypeName;

    /**
     * 总大小
     */
    private String total;

    /**
     * 剩余大小
     */
    private String free;

    /**
     * 已经使用量
     */
    private String used;

    /**
     * 资源的使用率
     */
    private double usage;

    public String getDiskName() {
        return diskName;
    }

    public void setDiskName(String diskName) {
        this.diskName = diskName;
    }

    public String getDiskTypeName() {
        return diskTypeName;
    }

    public void setDiskTypeName(String diskTypeName) {
        this.diskTypeName = diskTypeName;
    }

    public String getDiskFileTypeName() {
        return diskFileTypeName;
    }

    public void setDiskFileTypeName(String diskFileTypeName) {
        this.diskFileTypeName = diskFileTypeName;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getFree() {
        return free;
    }

    public void setFree(String free) {
        this.free = free;
    }

    public String getUsed() {
        return used;
    }

    public void setUsed(String used) {
        this.used = used;
    }

    public double getUsage() {
        return usage;
    }

    public void setUsage(double usage) {
        this.usage = usage;
    }
}
