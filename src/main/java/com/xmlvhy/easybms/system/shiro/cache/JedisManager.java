package com.xmlvhy.easybms.system.shiro.cache;

import com.xmlvhy.easybms.system.utils.SerializeUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.session.Session;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.exceptions.JedisConnectionException;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * @ClassName JedisManager
 * @Description TODO: redis 操作类
 * @Author 小莫
 * @Date 2019/07/27 19:32
 * @Version 1.0
 **/
@Slf4j
public class JedisManager {

    private JedisPool jedisPool;

    /**
     * 功能描述: 获取jedis实例
     *
     * @param
     * @return redis.clients.jedis.Jedis
     * @Author 小莫
     * @Date 20:22 2019/07/27
     */
    public Jedis getJedis() {
        Jedis jedis = null;
        try {
            jedis = getJedisPool().getResource();
        } catch (JedisConnectionException e) {
            String message = StringUtils.trim(e.getMessage());
            if ("Could not get a resource from the pool".equalsIgnoreCase(message)) {
                log.error("无法从redis连接池中取到jedis实例");
                System.exit(0);//停止项目
            }
            throw new JedisConnectionException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return jedis;
    }

    /**
     * 功能描述: 关闭jedis,释放资源
     *
     * @param jedis
     * @param isBroken
     * @return void
     * @Author 小莫
     * @Date 20:25 2019/07/27
     */
    public void returnResource(Jedis jedis, boolean isBroken) {
        if (jedis == null)
            return;
        /**
         * @deprecated starting from Jedis 3.0 this method will not be exposed.
         * Resource cleanup should be done using @see {@link redis.clients.jedis.Jedis#close()}
        if (isBroken){
        getJedisPool().returnBrokenResource(jedis);
        }else{
        getJedisPool().returnResource(jedis);
        }
         */
        jedis.close();
    }

    /**
     * 功能描述: 根据key获取value
     *
     * @param dbIndex
     * @param key
     * @return byte[]
     * @Author 小莫
     * @Date 20:25 2019/07/27
     */
    public byte[] getValueByKey(int dbIndex, byte[] key) throws Exception {
        Jedis jedis = null;
        byte[] result = null;
        boolean isBroken = false;
        try {
            jedis = getJedis();
            jedis.select(dbIndex);
            result = jedis.get(key);
        } catch (Exception e) {
            isBroken = true;
            throw e;
        } finally {
            returnResource(jedis, isBroken);
        }
        return result;
    }

    /**
     * 功能描述: 根据KEY删除value
     *
     * @param dbIndex
     * @param key
     * @return void
     * @Author 小莫
     * @Date 20:26 2019/07/27
     */
    public void deleteByKey(int dbIndex, byte[] key) throws Exception {
        Jedis jedis = null;
        boolean isBroken = false;
        try {
            jedis = getJedis();
            jedis.select(dbIndex);
            Long result = jedis.del(key);
            log.error("删除Session结果: {}", result);
        } catch (Exception e) {
            isBroken = true;
            throw e;
        } finally {
            returnResource(jedis, isBroken);
        }
    }

    /**
     * 功能描述: 保存并设置超时时间
     *
     * @param dbIndex
     * @param key
     * @param value
     * @param expireTime
     * @return void
     * @Author 小莫
     * @Date 20:22 2019/07/27
     */
    public void saveValueByKey(int dbIndex, byte[] key, byte[] value, int expireTime)
            throws Exception {
        Jedis jedis = null;
        boolean isBroken = false;
        try {
            jedis = getJedis();
            jedis.select(dbIndex);
            jedis.set(key, value);
            if (expireTime > 0)
                jedis.expire(key, expireTime);
        } catch (Exception e) {
            isBroken = true;
            throw e;
        } finally {
            returnResource(jedis, isBroken);
        }
    }

    /**
     * 获取所有Session
     *
     * @param dbIndex
     * @param redisShiroSession
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Collection<Session> AllSession(int dbIndex, String redisShiroSession) throws Exception {
        Jedis jedis = null;
        boolean isBroken = false;
        Set<Session> sessions = new HashSet<Session>();
        try {
            jedis = getJedis();
            jedis.select(dbIndex);

            Set<byte[]> byteKeys = jedis.keys((JedisShiroSessionRepository.REDIS_SHIRO_ALL).getBytes());
            if (byteKeys != null && byteKeys.size() > 0) {
                for (byte[] bs : byteKeys) {
                    Session obj = SerializeUtil.deserialize(jedis.get(bs),
                            Session.class);
                    if (obj instanceof Session) {
                        sessions.add(obj);
                    }
                }
            }
        } catch (Exception e) {
            isBroken = true;
            throw e;
        } finally {
            returnResource(jedis, isBroken);
        }
        return sessions;
    }

    /**
     * 获取 jedisPool
     */
    public JedisPool getJedisPool() {
        return jedisPool;
    }

    /**
     * 注入jedisPool
     */
    public void setJedisPool(JedisPool jedisPool) {
        this.jedisPool = jedisPool;
    }
}
