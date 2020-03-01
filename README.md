**基于SSM的后台管理系统：EasyBMS**			

> **个人博客：**[https://www.xmlvhy.com](https://www.xmlvhy.com "https://www.xmlvhy.com")，Java技术交流，技术分享以及经验总结和资源分享。欢迎来访~

##### 一、介绍

上手SSM后，一直想做一款后台管理系统，根据所学知识进行一个全面整合。于是也就利用空闲时间写了一套后台权限系统：EasyBMS。这是一套简单易上手的后台权限管理系统，使用Spring、SpringMVC、Mybatis、Shiro、Layui构建。它可以应用到各种Web应用中，比如网站管理后台、CMS、商城、CRM等。另外，对于上手了SSM想进一步进行权限系统构建学习的童鞋，我相信EasyBMS-SSM会是不错的选择，学后个人加以改造升级作为私活开发脚手架也不错~~

> 实现的系统功能：
>
> - 系统管理
>   - 部门管理
>   - 菜单管理
>   - 权限管理
>   - 角色管理
>   - 用户管理
>   - 系统参数设置
> - 系统监控
>   - 服务监控
>   - 数据监控
> - 其它管理
>   - 登录日志
>   - 系统公告
>   - 图标管理
>   - 接口文档

##### 二、技术选型
###### 2.1、技术组合
- 数据库：Mysql
- 技术组合：Spring、SpringMvc、Mybatis、pageHelper、Redis、Jsp、Shiro
- 前端框架：Layui、后台开源模板layuicms、zTree
- Lombok、swagger、druid数据源监控
- 其它：RBAC权限模型设计、权限菜单树、下拉树、左树右表设计等

##### 三、开发环境
###### 3.1、工具与环境
- IDEA 2018.3.5
- Maven 3
- JDK8
- Mysql 5.7+
- Win10 64位系统

##### 四、项目演示

###### 4.1、相关页面截图

<table>
    <tr>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-login.png"/></td>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-index.png"/></td>
    </tr>
    <tr>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-dept.png"/></td>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-menu.png"/></td>
    </tr>
    <tr>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-permission.png"/></td>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-role.png"/></td>
    </tr>
	<tr>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-user.png"/></td>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-dataSource.png"/></td>
    </tr>	 
    <tr>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-loginRecord.png"/></td>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-notice.png"/></td>
    </tr>
	<tr>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-server.png"/></td>
        <td><img src="http://static.xmlvhy.com/easybms/easybms-swagger.png"/></td>
    </tr>
</table>



##### 五、启动

可以使用maven tomcat插件进行启动，也可以配置本地tomcat进行启动

```
1. 主配置文件：dataSource.properties，此文件中配置数据库账户密码，先导入数据库脚本，然后配置你本地数据库的账户密码
2. 其它配置：mybatis-config.xml，这个文件为mybatis的全局配置文件
3. 启动访问：http://localhost:您配置的tomcat端口号（配置本地tomcat启动，运行完成自动启动登录页面）
4. 账户密码：system/123456(隐藏的超级管理员账号)，其它见数据库。密码尝试123456

tips:项目中使用了lombok插件，IDE得装lombok插件
```

 