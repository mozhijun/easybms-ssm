package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.service.NoticeService;
import com.xmlvhy.easybms.system.vo.NoticeVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ClassName NoticeController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/23 10:44
 * @Version 1.0
 **/
@Controller
@RequestMapping("/notice")
@Api(tags = "公告管理")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 功能描述: 跳转公告管理页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 10:46 2019/07/23
     */
    @RequestMapping(value = "toNoticeManager.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转公告管理页面")
    public String toNoticeManager() {
        return "system/notice/noticeManager";
    }

    /**
     * 功能描述: 加载公告列表
     *
     * @param
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 10:48 2019/07/23
     */
    @RequestMapping(value = "loadAllNoticeInfo.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "加载公告列表", notes = "分页加载公告列表")
    public JsonData loadAllNoticeInfo(NoticeVo noticeVo) {
        return noticeService.loadAllNoticeInfoByPage(noticeVo);
    }

    /**
     * 功能描述: 删除公告通知
     *
     * @param
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 11:39 2019/07/23
     */
    @RequestMapping(value = "deleteNoticeInfo.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除公告通知", notes = "根据ID删除公告通知")
    public JsonData deleteNoticeInfo(NoticeVo noticeVo) {
        try {
            noticeService.removeNoticeInfoById(noticeVo.getNoticeId());
            return JsonData.success("内容删除成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除公告通知
     * @Author 小莫
     * @Date 11:48 2019/07/23
     * @param noticeVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "batchDeleteNoticeInfo.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除公告通知", notes = "批量删除公告通知")
    public JsonData batchDeleteNoticeInfo(NoticeVo noticeVo) {
        try {
            noticeService.batchDeleteNoticeByIds(noticeVo);
            return JsonData.success("内容删除成功");
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 跳转添加公告页面
     * @Author 小莫
     * @Date 13:48 2019/07/23
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toSaveNotice.page",method = RequestMethod.GET)
    @ApiOperation(value = "跳转添加公告页面")
    public String toSaveNoticePage(){
        return "system/notice/noticeAdd";
    }

    /**
     * 功能描述: 添加公告信息
     * @Author 小莫
     * @Date 14:11 2019/07/23
     * @param
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "addNotice.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加公告",notes = "保存添加的系统公告信息")
    public JsonData addNotice(NoticeVo noticeVo){
        try {
            noticeService.saveNotice(noticeVo);
            return JsonData.success("内容添加成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 跳转修改公告页面
     * @Author 小莫
     * @Date 13:48 2019/07/23
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toModifyNotice.page",method = RequestMethod.GET)
    @ApiOperation(value = "跳转修改公告页面")
    public ModelAndView toModifyNoticePage(NoticeVo noticeVo){
        ModelAndView mav = new ModelAndView("system/notice/noticeUpdate");
        mav.addObject("notice",noticeService.getNoticeInfoById(noticeVo));
        return mav;
    }

    /**
     * 功能描述: 修改公告|通知
     * @Author 小莫
     * @Date 14:29 2019/07/23
     * @param noticeVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "modifyNotice.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改公告",notes = "修改系统公告信息")
    public JsonData modifyNotice(NoticeVo noticeVo){
        try {
            noticeService.modifyNotice(noticeVo);
            return JsonData.success("内容修改成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }
}
