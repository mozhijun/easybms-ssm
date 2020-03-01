package com.xmlvhy.easybms.system.entity.server;

import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.utils.Arith;
import com.xmlvhy.easybms.system.utils.IpUtil;
import lombok.Data;
import oshi.hardware.CentralProcessor;
import oshi.hardware.GlobalMemory;
import oshi.hardware.HardwareAbstractionLayer;
import oshi.software.os.FileSystem;
import oshi.software.os.OSFileStore;
import oshi.software.os.OperatingSystem;
import oshi.util.Util;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Properties;

/**
 * @ClassName ServerInfo
 * @Description TODO : 服务器相关信息：jvm 内存 磁盘 等
 * @Author 小莫
 * @Date 2019/07/25 14:27
 * @Version 1.0
 **/
@Data
public class ServerInfo {
    /**
     * 设置sleep时间
     */
    private static final int OSHI_SLEEP_SECOND = 1000;

    /**
     * 设置cpu信息项目
     */
    private CpuInfo cpuInfo = new CpuInfo();

    /**
     * 设置磁盘信息相关
     */
    private List<DiskInfo> diskInfoList = Lists.newLinkedList();

    /**
     * 设置jvm信息相关
     */
    private JvmInfo jvmInfo = new JvmInfo();

    /**
     * 设置内存信息相关
     */
    private MemoryInfo memoryInfo = new MemoryInfo();

    /**
     * 设置系统信息相关
     */
    private SystemInfo systemInfo = new SystemInfo();


    public void serverInfoAdapt() throws Exception {
        /**
         * 获取 oshi.SystemInfo 对象
         */
        oshi.SystemInfo sysInfo = new oshi.SystemInfo();
        HardwareAbstractionLayer hardware = sysInfo.getHardware();

        /**
         * 获取并设置cpu信息
         */
        setCpuInfo(hardware.getProcessor());

        /**
         * 获取并设置内存信息
         */
        setMemoryInfo(hardware.getMemory());

        /**
         * 获取系统信息
         */
        setSysInfo();
        /**
         * 获取jvm信息
         */
        setJvmInfo();
        /**
         * 获取系统磁盘信息
         */
        setSysFiles(sysInfo.getOperatingSystem());
    }


    /**
     * 设置CPU信息
     */
    private void setCpuInfo(CentralProcessor processor) {
        // CPU信息
        long[] prevTicks = processor.getSystemCpuLoadTicks();
        Util.sleep(OSHI_SLEEP_SECOND);
        long[] ticks = processor.getSystemCpuLoadTicks();
        long nice = ticks[CentralProcessor.TickType.NICE.getIndex()] - prevTicks[CentralProcessor.TickType.NICE.getIndex()];
        long irq = ticks[CentralProcessor.TickType.IRQ.getIndex()] - prevTicks[CentralProcessor.TickType.IRQ.getIndex()];
        long softirq = ticks[CentralProcessor.TickType.SOFTIRQ.getIndex()] - prevTicks[CentralProcessor.TickType.SOFTIRQ.getIndex()];
        long steal = ticks[CentralProcessor.TickType.STEAL.getIndex()] - prevTicks[CentralProcessor.TickType.STEAL.getIndex()];
        long cSys = ticks[CentralProcessor.TickType.SYSTEM.getIndex()] - prevTicks[CentralProcessor.TickType.SYSTEM.getIndex()];
        long user = ticks[CentralProcessor.TickType.USER.getIndex()] - prevTicks[CentralProcessor.TickType.USER.getIndex()];
        long iowait = ticks[CentralProcessor.TickType.IOWAIT.getIndex()] - prevTicks[CentralProcessor.TickType.IOWAIT.getIndex()];
        long idle = ticks[CentralProcessor.TickType.IDLE.getIndex()] - prevTicks[CentralProcessor.TickType.IDLE.getIndex()];
        long totalCpu = user + nice + cSys + idle + iowait + irq + softirq + steal;
        cpuInfo.setCpuNum(processor.getLogicalProcessorCount());
        cpuInfo.setTotal(Double.valueOf(totalCpu));
        cpuInfo.setSys(Double.valueOf(cSys));
        cpuInfo.setUsed(Double.valueOf(user));
        cpuInfo.setWait(Double.valueOf(iowait));
        cpuInfo.setFree(Double.valueOf(idle));
    }

    /**
     * 设置内存信息
     */
    private void setMemoryInfo(GlobalMemory memory) {
        memoryInfo.setTotal(Double.valueOf(memory.getTotal()));
        memoryInfo.setUsed(Double.valueOf(memory.getTotal() - memory.getAvailable()));
        memoryInfo.setFree(Double.valueOf(memory.getAvailable()));
    }

    /**
     * 设置服务器信息
     */
    private void setSysInfo() {
        Properties props = System.getProperties();
        systemInfo.setServerName(IpUtil.getHostName());
        systemInfo.setServerIp(IpUtil.getHostIp());
        systemInfo.setOsName(props.getProperty("os.name"));
        systemInfo.setOsArch(props.getProperty("os.arch"));
        systemInfo.setProjectDir(props.getProperty("user.dir"));
    }

    /**
     * 设置Java虚拟机
     */
    private void setJvmInfo() throws UnknownHostException {
        Properties props = System.getProperties();
        jvmInfo.setTotal(Double.valueOf(Runtime.getRuntime().totalMemory()));
        jvmInfo.setMax(Double.valueOf(Runtime.getRuntime().maxMemory()));
        jvmInfo.setFree(Double.valueOf(Runtime.getRuntime().freeMemory()));
        jvmInfo.setJdkVersion(props.getProperty("java.version"));
        jvmInfo.setJdkHome(props.getProperty("java.home"));
    }

    /**
     * 设置磁盘信息
     */
    private void setSysFiles(OperatingSystem os) {
        FileSystem fileSystem = os.getFileSystem();
        OSFileStore[] fsArray = fileSystem.getFileStores();
        for (OSFileStore fs : fsArray) {
            long free = fs.getUsableSpace();
            long total = fs.getTotalSpace();
            long used = total - free;
            DiskInfo sysFile = new DiskInfo();
            sysFile.setDiskName(fs.getMount());
            sysFile.setDiskTypeName(fs.getType());
            sysFile.setDiskFileTypeName(fs.getName());
            sysFile.setTotal(convertFileSize(total));
            sysFile.setFree(convertFileSize(free));
            sysFile.setUsed(convertFileSize(used));
            sysFile.setUsage(Arith.mul(Arith.div(used, total, 4), 100));
            diskInfoList.add(sysFile);
        }
    }

    /**
     * 字节转换
     *
     * @param size 字节大小
     * @return 转换后值
     */
    public String convertFileSize(long size) {
        long kb = 1024;
        long mb = kb * 1024;
        long gb = mb * 1024;
        if (size >= gb) {
            return String.format("%.1f GB", (float) size / gb);
        } else if (size >= mb) {
            float f = (float) size / mb;
            return String.format(f > 100 ? "%.0f MB" : "%.1f MB", f);
        } else if (size >= kb) {
            float f = (float) size / kb;
            return String.format(f > 100 ? "%.0f KB" : "%.1f KB", f);
        } else {
            return String.format("%d B", size);
        }
    }
}
