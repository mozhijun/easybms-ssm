package com.xmlvhy.easybms.system.entity.server;

import com.xmlvhy.easybms.system.utils.Arith;

/**
 * @ClassName MemoryInfo
 * @Description TODO:内存信息
 * @Author 小莫
 * @Date 2019/07/25 14:17
 * @Version 1.0
 **/
public class MemoryInfo {
    /**
     * 内存总量（G）
     */
    private Double total;
    /**
     * 已用内存(G)
     */
    private Double used;
    /**
     * 剩余内存(G)
     */
    private Double free;

    public Double getTotal() {
        return Arith.div(total, (1024 * 1024 * 1024), 2);
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getUsed() {
        return Arith.div(used, (1024 * 1024 * 1024), 2);
    }

    public void setUsed(Double used) {
        this.used = used;
    }

    public Double getFree() {
        return Arith.div(free, (1024 * 1024 * 1024), 2);
    }

    public void setFree(Double free) {
        this.free = free;
    }

    public double getUsage() {
        return Arith.mul(Arith.div(used, total, 4), 100);
    }
}
