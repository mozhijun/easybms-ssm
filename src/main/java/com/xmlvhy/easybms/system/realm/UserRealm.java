package com.xmlvhy.easybms.system.realm;

import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.entity.Permission;
import com.xmlvhy.easybms.system.entity.Role;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.service.PermissionService;
import com.xmlvhy.easybms.system.service.RoleService;
import com.xmlvhy.easybms.system.service.UserService;
import com.xmlvhy.easybms.system.utils.ActiveUser;
import com.xmlvhy.easybms.system.vo.PermissionVo;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @ClassName UserRealm
 * @Description TODO:用户认证和授权
 * @Author 小莫
 * @Date 2019/07/04 15:18
 * @Version 1.0
 **/
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    /**
     * 获取当前类的名称
     */
    public String getRealmName() {
        return this.getClass().getSimpleName();
    }

    /**
     * 功能描述: 用户授权
     *
     * @param principals
     * @return org.apache.shiro.authz.AuthorizationInfo
     * @Author 小莫
     * @Date 13:52 2019/07/19
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        /**
         * 获取认证用户信息
         */
        ActiveUser activeUser = (ActiveUser) principals.getPrimaryPrincipal();

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

        User user = activeUser.getCurrentUser();
        List<String> roles = activeUser.getRoles();
        List<String> permissions = activeUser.getPermissions();
        /**
         * 判断认证用户如果是超级管理员，则设置拥有所有角色和权限
         */
        if (user.getType().equals(SysConstant.SUPER_SYSTEM_USER_TYPE)) {
            info.addRole("*");
            info.addStringPermission("*:*");
        } else {
            if (CollectionUtils.isNotEmpty(roles)) {
                info.addRoles(roles);
            }
            if (CollectionUtils.isNotEmpty(permissions)) {
                info.addStringPermissions(permissions);
            }
        }
        return info;
    }

    /**
     * 功能描述: 用户认证
     *
     * @param token
     * @return org.apache.shiro.authc.AuthenticationInfo
     * @Author 小莫
     * @Date 13:52 2019/07/19
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        /**
         * 获取登录用户身份
         */
        String loginName = token.getPrincipal().toString();
        /**
         * 根据用户登录名从数据库查询用户
         */
        User user = userService.findUserByLoginName(loginName);
        if (null != user) {
            //获取用户密码
            String dbPassword = user.getPwd();

            //1.TODO:这里可以考虑优化在授权当中去查询用户的角色和权限，同时为了避免频繁查询数据库，可以考虑使用缓存将角色权限信息缓存下来
            //2.TODO:在认证这里面查询出用户的角色和权限的话，这样有个问题，如果第一次登录进入系统，当前用户权限被修改了，如果一直没退出重新登录，则修改的权限无效！

            /**
             * 1.根据用户ID查询用户拥有的角色
             */
            List<Role> roleList = roleService.getUserRoleByUserId(user.getId());
            List<String> userRoles = Lists.newArrayList();
            if (CollectionUtils.isNotEmpty(roleList)) {
                for (Role role : roleList) {
                    userRoles.add(role.getName());
                }
            }

            /**
             * 构造查询条件
             */
            PermissionVo permissionVo = new PermissionVo();
            permissionVo.setType(SysConstant.PERMISSION_TYPE_PERMISSION);
            permissionVo.setAvailable(SysConstant.AVAIABLE_TYPE_ENABLE);
            /**
             * 2.根据用户ID查询用户所拥有的权限
             */
            List<Permission> permissionList = permissionService.getUserPermissionsByUserId(permissionVo, user.getId());
            List<String> userPermissions = Lists.newArrayList();
            if (CollectionUtils.isNotEmpty(permissionList)) {
                for (Permission p : permissionList) {
                    userPermissions.add(p.getPercode());
                }
            }

            /**
             * 封装当前登录用户 ActiveUser
             */
            ActiveUser activeUser = ActiveUser.builder().currentUser(user)
                    .permissions(userPermissions).roles(userRoles).build();
            //加密的盐，这里使用用户真实姓名和用户地址作为盐
            ByteSource salt = ByteSource.Util.bytes(user.getSalt());
            SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(activeUser, dbPassword, salt, getName());
            return info;
        } else {
            //用户名不存在
            return null;
        }
    }

    /**
     * 清空当前用户权限信息
     */
    public  void clearCachedAuthorizationInfo() {
        PrincipalCollection principalCollection = SecurityUtils.getSubject().getPrincipals();
        SimplePrincipalCollection principals = new SimplePrincipalCollection(
                principalCollection, getName());
        super.clearCachedAuthorizationInfo(principals);
    }
    /**
     * 指定principalCollection 清除
     */
    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principalCollection) {
        SimplePrincipalCollection principals = new SimplePrincipalCollection(
                principalCollection, getName());
        super.clearCachedAuthorizationInfo(principals);
    }
}
