package com.xmlvhy.easybms.system.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.dao.NoticeMapper;
import com.xmlvhy.easybms.system.entity.Notice;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.service.NoticeService;
import com.xmlvhy.easybms.system.utils.ActiveUser;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.vo.NoticeVo;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @ClassName NoticeServiceImpl
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/23 10:59
 * @Version 1.0
 **/
@Service
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeMapper noticeMapper;

    /**
     * 功能描述: 分页查询公告列表
     * @Author 小莫
     * @Date 11:09 2019/07/23
     * @param noticeVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @Override
    public JsonData loadAllNoticeInfoByPage(NoticeVo noticeVo) {
        //分页查询
        Page<Notice> page = PageHelper.startPage(noticeVo.getPage(), noticeVo.getLimit());

        List<Notice> noticeList = noticeMapper.selectAllNoticeByParams(noticeVo);

        if (CollectionUtils.isEmpty(noticeList)) {
            noticeList = Lists.newArrayList();
        }
        return JsonData.success(page.getTotal(),noticeList);
    }

    /**
     * 功能描述:根据ID删除系统公告
     * @Author 小莫
     * @Date 11:45 2019/07/23
     * @param noticeId
     * @return void
     */
    @Override
    public void removeNoticeInfoById(Integer noticeId) {
        Notice notice = noticeMapper.selectByPrimaryKey(noticeId);
        Preconditions.checkNotNull(notice,"公告通知不存在,删除失败");
        int rows = noticeMapper.deleteByPrimaryKey(noticeId);
        if (rows == 0) {
            throw new EasyBmsException("公告通知删除失败,数据库出现错误");
        }
    }

    /**
     * 功能描述: 批量删除公告通知
     * @Author 小莫
     * @Date 11:47 2019/07/23
     * @param noticeVo
     * @return void
     */
    @Override
    public void batchDeleteNoticeByIds(NoticeVo noticeVo) {
        BeanValidator.check(noticeVo);
        Integer[] ids = StringUtils.stringIdsToInt(noticeVo.getIds());
        if (ids != null && ids.length > 0) {
            for (Integer id : ids){
                int rows = noticeMapper.deleteByPrimaryKey(id);
                if (rows == 0) {
                    throw new EasyBmsException("公告通知删除失败,数据库出现错误");
                }
            }
        }
    }

    /**
     * 功能描述: 添加系统公告
     * @Author 小莫
     * @Date 14:13 2019/07/23
     * @param noticeVo
     * @return void
     */
    @Override
    public void saveNotice(NoticeVo noticeVo) {
        BeanValidator.check(noticeVo);

        /**
         * 获取当前用户信息
         */
        Subject subject = SecurityUtils.getSubject();
        ActiveUser user = (ActiveUser) subject.getPrincipal();

        Notice notice = new Notice();
        BeanUtils.copyProperties(noticeVo,notice);
        notice.setCreateBy(user.getCurrentUser().getName());
        notice.setCreateTime(new Date());

        int rows = noticeMapper.insertSelective(notice);
        if (rows == 0) {
            throw new EasyBmsException("保存公告信息失败，数据库插入数据出现错误");
        }
    }

    /**
     * 功能描述: 更新系统公告通知
     * @Author 小莫
     * @Date 14:24 2019/07/23
     * @param noticeVo
     * @return void
     */
    @Override
    public void modifyNotice(NoticeVo noticeVo) {
        BeanValidator.check(noticeVo);
        Notice notice = noticeMapper.selectByPrimaryKey(noticeVo.getNoticeId());
        Preconditions.checkNotNull(notice,"此条公告通知不存在,无法修改");

        /**
         * 获取当前操作的用户
         */
        Subject subject = SecurityUtils.getSubject();
        ActiveUser user = (ActiveUser) subject.getPrincipal();

        Notice newNotice = new Notice();
        BeanUtils.copyProperties(noticeVo,newNotice);
        newNotice.setUpdateBy(user.getCurrentUser().getName());
        newNotice.setUpdateTime(new Date());

        int rows = noticeMapper.updateByPrimaryKeySelective(newNotice);
        if (rows == 0) {
            throw new EasyBmsException("更新公告他通知失败,数据库更新出现错误");
        }
    }

    /**
     * 功能描述: 根据ID获取一条系统公告信息
     * @Author 小莫
     * @Date 14:37 2019/07/23
     * @param noticeVo
     * @return com.xmlvhy.easybms.system.entity.Notice
     */
    @Override
    public Notice getNoticeInfoById(NoticeVo noticeVo) {
        Notice notice = noticeMapper.selectByPrimaryKey(noticeVo.getNoticeId());
        Preconditions.checkNotNull(notice,"系统公告内容不存在");
        return notice;
    }
}
