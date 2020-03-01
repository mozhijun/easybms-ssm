package com.xmlvhy.easybms.system.utils;

import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * @ClassName MD5Util
 * @Description TODO MD5加密工具类
 * @Author 小莫
 * @Date 2019/07/18 9:58
 * @Version 1.0
 **/
public class MD5Util {

    /**
     * 功能描述: shiro MD5加密
     * @Author 小莫
     * @Date 10:05 2019/07/18
     * @param source 加密原始密码
     * @param salt  加密盐
     * @param hashiterations 散列次数
     * @return java.lang.String
     */
    public static String encodeUserPwdWithMD5(String source,String salt,Integer hashiterations){
        if (source == null) {
            return null;
        }
        return new Md5Hash(source,salt,hashiterations).toString();
    }
}
