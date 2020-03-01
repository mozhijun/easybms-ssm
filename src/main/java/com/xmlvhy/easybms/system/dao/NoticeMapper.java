package com.xmlvhy.easybms.system.dao;

import com.xmlvhy.easybms.system.entity.Notice;
import com.xmlvhy.easybms.system.vo.NoticeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NoticeMapper {
    int deleteByPrimaryKey(Integer noticeId);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer noticeId);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    List<Notice> selectAllNoticeByParams(@Param("noticeVo") NoticeVo noticeVo);

}