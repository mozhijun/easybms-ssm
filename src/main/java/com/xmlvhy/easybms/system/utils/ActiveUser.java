package com.xmlvhy.easybms.system.utils;

import com.xmlvhy.easybms.system.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @ClassName ActiveUser
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/04 16:39
 * @Version 1.0
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActiveUser {
    /**
     * 当前登录用户
     */
    private User currentUser;

    /**
     * 用户角色
     */
    List<String> roles;

    /**
     * 用户权限
     */
    List<String> permissions;
}
