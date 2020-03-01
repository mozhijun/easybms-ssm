package com.xmlvhy.easybms.system.common;

import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName JsonData
 * @Description TODO:封装返回数据的实体，适配layui table数据
 * @Author 小莫
 * @Date 2019/07/04 22:27
 * @Version 1.0
 **/
@Setter
@Getter
public class JsonData {
    /**
     * 状态码：0 成功 ，1失败
     */
    private Integer code;
    /**
     * 响应消息
     */
    private String msg;

    /**
     * 分页条数
     */
    private Long count;

    /**
     * 响应的结果数据
     */
    private Object data;

    public JsonData(Integer code){
        this.code = code;
    }

    /**
     * 功能描述: 成功返回，带有数据和消息
     * @Author 小莫
     * @Date 10:28 2019/06/04
     * @param data
     * @param msg
     * @return com.xmlvhy.permission.common.JsonData
     */
    public static JsonData success(Long count,Object data,String msg){
        JsonData jsonData = new JsonData(0);
        jsonData.count = count;
        jsonData.data = data;
        jsonData.msg = msg;
        return jsonData;
    }

    /**
     * 功能描述: 成功返回 data + count
     * @Author 小莫
     * @Date 10:28 2019/06/04
     * @param data
     * @return com.xmlvhy.permission.common.JsonData
     */
    public static JsonData success(Long count,Object data){
        JsonData jsonData = new JsonData(0);
        jsonData.count = count;
        jsonData.data = data;
        return jsonData;
    }

    /**
     * 功能描述:返回data
     * @Author 小莫
     * @Date 14:08 2019/07/08
     * @param data
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    public static JsonData success(Object data){
        JsonData jsonData = new JsonData(0);
        jsonData.data = data;
        return jsonData;
    }

    /**
     * 功能描述: 成功返回，带消息
     * @Author 小莫
     * @Date 11:15 2019/06/04
     * @param msg
     * @return com.xmlvhy.permission.common.JsonData
     */
    public static JsonData success(String msg){
        JsonData jsonData = new JsonData(0);
        jsonData.msg = msg;
        return jsonData;
    }

    /**
     * 功能描述: 成功返回，未带消息和数据
     * @Author 小莫
     * @Date 10:30 2019/06/04
     * @param
     * @return com.xmlvhy.permission.common.JsonData
     */
    public static JsonData success(){
        JsonData jsonData = new JsonData(0);
        return jsonData;
    }

    /**
     * 功能描述: 成功返回，带消息和数据
     * @Author 小莫
     * @Date 15:01 2019/07/25
     * @param msg
     * @param data
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    public static JsonData success(String msg,Object data){
        JsonData jsonData = new JsonData(0);
        jsonData.msg = msg;
        jsonData.data = data;
        return jsonData;
    }

    /**
     * 功能描述: 失败返回，带消息
     * @Author 小莫
     * @Date 10:29 2019/06/04
     * @param msg
     * @return com.xmlvhy.permission.common.JsonData
     */
    public static JsonData fail(String msg){
        JsonData jsonData = new JsonData(1);
        jsonData.msg = msg;
        return jsonData;
    }

    /**
     * 功能描述: 讲返回的数据封装为一个 map ,针对jsonView的返回结果类型
     * @Author 小莫
     * @Date 11:00 2019/06/04
     * @param
     * @return java.util.Map<java.lang.String,java.lang.Object>
     */
    public Map<String,Object> toMap(){
        Map<String,Object> result = new HashMap<>();
        result.put("code",code);
        result.put("msg",msg);
        result.put("data",data);
        return  result;
    }

}
