package com.xmlvhy.easybms.system.service;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.LogLogin;
import com.xmlvhy.easybms.system.vo.LogLoginVo;

/**
 * @Author: 小莫
 * @Date: 2019-07-21 9:15
 * @Description TODO
 */
public interface LoginLogService {
    JsonData getLoginLogByPage(LogLoginVo logLoginVo);

    void saveLoginLog(LogLogin logLogin);

    void removeOneLoginLogById(Integer id);

    void batchDeleteLogInfo(LogLoginVo logLoginVo);
}
