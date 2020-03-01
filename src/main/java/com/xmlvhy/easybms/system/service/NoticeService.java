package com.xmlvhy.easybms.system.service;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.Notice;
import com.xmlvhy.easybms.system.vo.NoticeVo;


/**
 * @Author: 小莫
 * @Date: 2019-07-23 10:58
 * @Description TODO
 */
public interface NoticeService {

    JsonData loadAllNoticeInfoByPage(NoticeVo noticeVo);

    void removeNoticeInfoById(Integer noticeId);

    void batchDeleteNoticeByIds(NoticeVo noticeVo);

    void saveNotice(NoticeVo noticeVo);

    void modifyNotice(NoticeVo noticeVo);

    Notice getNoticeInfoById(NoticeVo noticeVo);
}
