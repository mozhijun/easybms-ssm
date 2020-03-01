package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * @ClassName FileController
 * @Description TODO 文件上传
 * @Author 小莫
 * @Date 2019/07/20 20:02
 * @Version 1.0
 **/
@Controller
@RequestMapping("/file")
@Slf4j
@Api(tags = "文件上传")
public class FileController {

    /**
     * 保存图片的本地地址，可以优化：动态注入
     */
    private static String filePath = "E:\\upload\\";

    @Autowired
    private UserService userService;

    /**
     * 功能描述: 文件上传 TODO:可以优化
     * @Author 小莫
     * @Date 17:33 2019/07/23
     * @param files
     * @param request
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "/upload.json", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "文件上传", notes = "上传头像")
    public JsonData fileUpload(@RequestParam(value = "file", required = false) MultipartFile[] files, HttpServletRequest request) {

        String loginname = request.getParameter("loginname");
        log.info("当前: {} 更新头像", loginname);
        /**
         * 封装响应layui文件上传的响应
         */
        Map<String, Object> data = new HashMap<>();

        if (files.length > 0) {
            for (MultipartFile file : files) {
                String originalFilename = file.getOriginalFilename();
                long size = file.getSize();

                String prefix = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
                String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
                String fileName = new Random().nextInt(1000) + prefix + suffix;

                String pathName = filePath + fileName;

                //获取文件访问的url
                String src = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/images/" + fileName;

                File fileDir = new File(filePath);
                log.info("文件保存在 {} 目录中", fileDir.getParentFile());
                //判断当前文件目录是否存在,没有则创建
                if (!fileDir.exists()) {
                    fileDir.mkdirs();
                }
                try {
                    //文件上传
                    file.transferTo(new File(filePath + fileName));
                } catch (IOException e) {
                    log.error("e: {}", e);
                    return JsonData.fail("文件上传失败");
                }

                //打印日志
                log.info("originalFilename: {}, size: {}, suffix: {}, pathName: {}, src: {}, fileName: {}",
                        originalFilename, size, suffix, pathName, src, fileName);
                data.put("src", src);

                /**
                 * 这里更新头像
                 */
                try {
                    User user = userService.modifyHeadImg(loginname, src);
                    data.put("msg","头像更新成功");
                    /**
                     * 更新session中的 activeUser
                     */
                    request.getSession().setAttribute("user",user);

                    return JsonData.success(data);
                } catch (Exception e) {
                    return JsonData.fail(e.getMessage());
                }
            }
        }
        return JsonData.success(data);
    }
}
