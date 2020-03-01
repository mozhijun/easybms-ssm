package com.xmlvhy.easybms.system.common;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * @ClassName ApplicationContextHelper
 * @Description TODO: bean 工具类，解决一些不被Spring IOC容器管理的类中获取bean方法
 * @Author 小莫
 * @Date 2019/07/05 12:06
 * @Version 1.0
 **/
@Component(value = "applicationContextHelper")
public class ApplicationContextHelper implements ApplicationContextAware {

    private static ApplicationContext applicationContext;


    @Override
    public void setApplicationContext(ApplicationContext context) throws BeansException {
        applicationContext = context;
    }

    /**
     * 功能描述: 根据class 获取bean
     * @Author 小莫
     * @Date 12:10 2019/07/05
     * @param clazz
     * @return T
     */
    public static <T> T getBean(Class<T> clazz){
        if (applicationContext == null) {
            return null;
        }
        return applicationContext.getBean(clazz);
    }

    /**
     * 功能描述: 根据指定名称获取对应的bean
     * @Author 小莫
     * @Date 12:11 2019/07/05
     * @param name
     * @param clazz
     * @return T
     */
    public static <T> T getBean(String name,Class<T> clazz){
        if (applicationContext == null) {
            return null;
        }
        return applicationContext.getBean(name,clazz);
    }
}
