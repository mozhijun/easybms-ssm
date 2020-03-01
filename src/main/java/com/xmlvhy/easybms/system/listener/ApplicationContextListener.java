package com.xmlvhy.easybms.system.listener;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * @ClassName ApplicationContextListener
 * @Description TODO:监听ServletContext创建的信息
 * @Author 小莫
 * @Date 2019/07/04 17:04
 * @Version 1.0
 **/
@WebListener
@Slf4j
public class ApplicationContextListener implements ServletContextListener {

    /**
     * 这里设置一个全局变量记录 contextPath路径，简化取路径的方式
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        String contextPath = servletContext.getContextPath();
        servletContext.setAttribute("ctx",contextPath);
        log.info("ApplicationContextListener--加载成功,contextPath: {}",contextPath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        log.info("监听器销毁");
    }
}
