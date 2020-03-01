package com.xmlvhy.easybms.system.shiro.cache.impl;

import com.xmlvhy.easybms.system.shiro.cache.JedisManager;
import com.xmlvhy.easybms.system.shiro.cache.JedisShiroCache;
import com.xmlvhy.easybms.system.shiro.cache.ShiroCacheManager;
import org.apache.shiro.cache.Cache;

/**
 * @ClassName JedisShiroCacheManager
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/27 23:53
 * @Version 1.0
 **/
public class JedisShiroCacheManager implements ShiroCacheManager {

    private JedisManager jedisManager;

    @Override
    public <K, V> Cache<K, V> getCache(String name) {
        return new JedisShiroCache<K, V>(name, getJedisManager());
    }

    @Override
    public void destroy() {
        //如果和其他系统，或者应用在一起就不能关闭
        //getJedisManager().getJedis().shutdown();
    }

    public JedisManager getJedisManager() {
        return jedisManager;
    }

    public void setJedisManager(JedisManager jedisManager) {
        this.jedisManager = jedisManager;
    }
}
