package com.xmlvhy.easybms.system.vo;

import com.xmlvhy.easybms.system.entity.Notice;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @ClassName NoticeVo
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/23 10:49
 * @Version 1.0
 **/
@Data
public class NoticeVo extends Notice {

    private String[] ids;

    private Integer page;

    private Integer limit;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
}
