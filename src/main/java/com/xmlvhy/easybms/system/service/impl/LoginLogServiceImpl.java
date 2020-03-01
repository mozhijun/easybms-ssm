package com.xmlvhy.easybms.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.dao.LogLoginMapper;
import com.xmlvhy.easybms.system.entity.LogLogin;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.service.LoginLogService;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.vo.LogLoginVo;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName LoginLogServiceImpl
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/21 9:16
 * @Version 1.0
 **/
@Service
public class LoginLogServiceImpl implements LoginLogService {

    @Resource
    private LogLoginMapper logLoginMapper;

    /**
     * 功能描述: 分页获取登录日志
     * @Author 小莫
     * @Date 11:30 2019/07/21
     * @param logLoginVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @Override
    public JsonData getLoginLogByPage(LogLoginVo logLoginVo) {
        Page <LogLogin> page = PageHelper.startPage(logLoginVo.getPage(),logLoginVo.getLimit());
        List <LogLogin> logLoginList = logLoginMapper.selectAllLoginLogByParams(logLoginVo);
        if (CollectionUtils.isEmpty(logLoginList)) {
            logLoginList = Lists.newArrayList();
        }
        return JsonData.success(page.getTotal(),logLoginList);
    }

    /**
     * 功能描述: 保存登录日志
     * @Author 小莫
     * @Date 11:33 2019/07/21
     * @param logLogin
     * @return void
     */
    @Override
    public void saveLoginLog(LogLogin logLogin) {
        int rows = logLoginMapper.insertSelective(logLogin);
        if (rows == 0) {
            throw new EasyBmsException("登录日志保存出错");
        }
    }

    /**
     * 功能描述: 根据日志ID删除一条日志
     * @Author 小莫
     * @Date 19:22 2019/07/21
     * @param id
     * @return void
     */
    @Override
    public void removeOneLoginLogById(Integer id) {
        LogLogin logLogin = logLoginMapper.selectByPrimaryKey(id);
        Preconditions.checkNotNull(logLogin,"登录日志不存在，无法删除");
        int rows = logLoginMapper.deleteByPrimaryKey(id);
        if (rows == 0) {
            throw new EasyBmsException("登录日志删除失败,数据库删除错误");
        }
    }

    /**
     * 功能描述: 批量删除日志
     * @Author 小莫
     * @Date 19:49 2019/07/21
     * @param logLoginVo
     * @return void
     */
    @Override
    public void batchDeleteLogInfo(LogLoginVo logLoginVo) {
        BeanValidator.check(logLoginVo);
        Integer[] ids = StringUtils.stringIdsToInt(logLoginVo.getIds());
        if (ids != null && ids.length > 0) {
            for (Integer id : ids){
                int rows = logLoginMapper.deleteByPrimaryKey(id);
                if (rows == 0) {
                    throw new EasyBmsException("日志删除失败，数据库出现错误");
                }
            }
        }
    }
}
