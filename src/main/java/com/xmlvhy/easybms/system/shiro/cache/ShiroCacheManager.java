package com.xmlvhy.easybms.system.shiro.cache;

import org.apache.shiro.cache.Cache;

/**
 * @Author: 小莫
 * @Date: 2019-07-27 23:49
 * @Description TODO
 */
public interface ShiroCacheManager {
    <K, V> Cache<K, V> getCache(String name);
    void destroy();
}
